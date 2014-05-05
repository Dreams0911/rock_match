package com.rockmatch.screenstates.gameplay.mediators
{
	import com.rockmatch.AppSettings;
	import com.rockmatch.screenstates.gameplay.events.GridRegionEvent;
	import com.rockmatch.screenstates.gameplay.events.model.GridRegionModelEvent;
	import com.rockmatch.screenstates.gameplay.events.view.GridRegionViewEvent;
	import com.rockmatch.screenstates.gameplay.models.IUIFactory;
	import com.rockmatch.screenstates.gameplay.models.fallLogic.vo.FallChipVO;
	import com.rockmatch.screenstates.gameplay.models.gridregion.GridRegionStatesEnum;
	import com.rockmatch.screenstates.gameplay.models.gridregion.IGridRegionModel;
	import com.rockmatch.screenstates.gameplay.models.gridregion.vo.ChipVO;
	import com.rockmatch.screenstates.gameplay.models.matchlogic.vo.MatchVO;
	import com.rockmatch.screenstates.gameplay.views.GridRegionView;
	import com.rockmatch.screenstates.gameplay.views.components.ChipView;
	import com.rockmatch.screenstates.gameplay.views.animator.wraps.ChipViewFallWrap;

	import flash.display.Sprite;
	import flash.geom.Point;

	import robotlegs.bender.bundles.mvcs.Mediator;


	/**
	 *
	 * @author dkoloskov
	 *
	 */
	public class GridRegionViewMediator extends Mediator
	{
		[Inject]
		public var view:GridRegionView;

		[Inject]
		public var uiFactory:IUIFactory;

		[Inject]
		public var gridRegionModel:IGridRegionModel;

		//==============================================================================
		//{region							PUBLIC METHODS
		override public function initialize():void
		{
			super.initialize();
			this.addGrid();

			this.addListeners();

			this.dispatch(new GridRegionEvent(GridRegionEvent.GENERATE_ALL_NEW_CHIPS));
		}

		override public function destroy():void
		{
			this.removeListeners();
			super.destroy();
		}

		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		private function addGrid():void
		{
			var grid:Sprite = this.uiFactory.createGrid();
			this.view.addGrid(grid);
		}

		private function createChipView(id:int, gridX:int, gridY:int):ChipView
		{
			var chip:ChipView = this.uiFactory.createChipView(id);
			chip.gridX = gridX;
			chip.gridY = gridY;
			return chip;
		}

		private function prepareSwapAnimation():void
		{
			this.view.removeChipFrame();

			var swapSuccessful:Boolean = (this.gridRegionModel.matches.length > 0);
			var chip1:ChipVO = this.gridRegionModel.swapChip1;
			var chip2:ChipVO = this.gridRegionModel.swapChip2;
			this.view.playSwapChipsAnimation(swapSuccessful, chip1.gridX, chip1.gridY, chip2.gridX, chip2.gridY);
		}

		private function prepareChipsExplosionAnimation():void
		{
			var i:uint;
			var matchesLen:uint = this.gridRegionModel.matches.length;
			var match:MatchVO;
			var chipsPositions:Vector.<Point>;
			for(i = 0; i < matchesLen; i++)
			{
				match = this.gridRegionModel.matches[i];
				chipsPositions = match.getPositions();
				this.view.playExplodeChipsAnimation(chipsPositions, match.id);
			}
		}

		private function prepareFallChipsAnimation():void
		{
			// STEP 1. CREATE NEW INVISIBLE CHIPS AND PACK THEM TO chipViewFallWrap:ChipViewFallWrap
			var chipsFallWraps:Vector.<ChipViewFallWrap> = new <ChipViewFallWrap>[];
			var chipViewFallWrap:ChipViewFallWrap;

			var i:uint;
			var fallChipsLen:uint = this.gridRegionModel.fallChips.length;
			var fallChipVO:FallChipVO;
			var chipView:ChipView;
			for(i = 0; i < fallChipsLen; i++)
			{
				// GET/CREATE CHIP
				fallChipVO = this.gridRegionModel.fallChips[i];
				if(fallChipVO.startGridY >= 0)
				{
					chipView = this.view.getChipOnPosition(fallChipVO.gridX, fallChipVO.startGridY);
				}
				else
				{
					chipView = this.createChipView(fallChipVO.id, fallChipVO.gridX, fallChipVO.startGridY);
					chipView.visible = false;
					this.view.addChip(chipView);
				}

				// PACK CHIP
				chipViewFallWrap = new ChipViewFallWrap(chipView, fallChipVO.finishGridY);
				chipsFallWraps.push(chipViewFallWrap);
			}

			// STEP 2. ANIMATION
			this.view.playFallChipsAnimation(chipsFallWraps);
		}

		private function addListeners():void
		{
			this.view.addEventListener(GridRegionViewEvent.PICK_CHIP, this.pickChipHandler);
			this.view.addEventListener(GridRegionViewEvent.SWAP_CHIPS_COMPLETE, this.swapChipsCompleteHandler);
			this.view.addEventListener(GridRegionViewEvent.EXPLODE_CHIPS_COMPLETE, this.explodeChipsCompleteHandler);
			this.view.addEventListener(GridRegionViewEvent.FALL_CHIPS_COMPLETE, this.fallChipsCompleteHandler);

			this.addContextListener(GridRegionModelEvent.STATE_CHANGED, this.stateChangedHandler);

			this.addContextListener(GridRegionModelEvent.ALL_NEW_CHIPS_GENERATED, this.allNewChipsGeneratedHandler);
			this.addContextListener(GridRegionModelEvent.CHIP_PICKED, this.chipPickedHandler);
		}

		private function removeListeners():void
		{
			this.view.removeEventListener(GridRegionViewEvent.PICK_CHIP, this.pickChipHandler);
			this.view.removeEventListener(GridRegionViewEvent.SWAP_CHIPS_COMPLETE, this.swapChipsCompleteHandler);
			this.view.removeEventListener(GridRegionViewEvent.EXPLODE_CHIPS_COMPLETE, this.explodeChipsCompleteHandler);
			this.view.removeEventListener(GridRegionViewEvent.FALL_CHIPS_COMPLETE, this.fallChipsCompleteHandler);

			this.removeContextListener(GridRegionModelEvent.STATE_CHANGED, this.stateChangedHandler);

			this.removeContextListener(GridRegionModelEvent.ALL_NEW_CHIPS_GENERATED, this.allNewChipsGeneratedHandler);
			this.removeContextListener(GridRegionModelEvent.CHIP_PICKED, this.chipPickedHandler);
		}

		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		private function pickChipHandler(event:GridRegionViewEvent):void
		{
			var gridX:int = event.body["gridX"];
			var gridY:int = event.body["gridY"];
			this.dispatch(new GridRegionEvent(GridRegionEvent.PICK_CHIP, {gridX: gridX, gridY: gridY}));
		}

		private function swapChipsCompleteHandler(event:GridRegionViewEvent):void
		{
			this.dispatch(new GridRegionEvent(GridRegionEvent.SWAP_COMPLETE));
		}

		private function explodeChipsCompleteHandler(event:GridRegionViewEvent):void
		{
			this.dispatch(new GridRegionEvent(GridRegionEvent.EXPLOSION_COMPLETE, event.body));
		}

		private function fallChipsCompleteHandler(event:GridRegionViewEvent):void
		{
			this.dispatch(new GridRegionEvent(GridRegionEvent.FALL_CHIPS_COMPLETE));
		}

		private function stateChangedHandler(event:GridRegionModelEvent):void
		{
			switch(this.gridRegionModel.state)
			{
				case GridRegionStatesEnum.SWAP_CHIPS_STATE:
					this.prepareSwapAnimation();
					break;

				case GridRegionStatesEnum.CHIPS_EXPLOSION_STATE:
					this.prepareChipsExplosionAnimation();
					break;

				case GridRegionStatesEnum.FALL_CHIPS_STATE:
					this.prepareFallChipsAnimation();
					break;
			}
		}

		private function chipPickedHandler(event:GridRegionModelEvent):void
		{
			var chipFrame:Sprite = this.uiFactory.createChipFrame();
			var currentChip:ChipVO = this.gridRegionModel.currentChip;

			this.view.addChipFrame(chipFrame, currentChip.gridX, currentChip.gridY);
		}

		private function allNewChipsGeneratedHandler(event:GridRegionModelEvent):void
		{
			var gridX:uint;
			var gridY:uint;
			var column:Vector.<ChipVO>;
			var chipVO:ChipVO;
			var chipView:ChipView;
			for(gridX = 0; gridX < AppSettings.GRID_WIDTH; gridX++)
			{
				column = this.gridRegionModel.grid[gridX];

				for(gridY = 0; gridY < AppSettings.GRID_HEIGHT; gridY++)
				{
					chipVO = column[gridY];
					chipView = this.createChipView(chipVO.id, gridX, gridY)
					this.view.addChip(chipView);
				}
			}
		}

		//} endregion EVENTS HANDLERS ==================================================
	}
}