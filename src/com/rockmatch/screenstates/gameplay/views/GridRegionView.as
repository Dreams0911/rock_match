package com.rockmatch.screenstates.gameplay.views
{
	import com.rockmatch.AppSettings;
	import com.rockmatch.core.base.views.BaseView;
	import com.rockmatch.screenstates.gameplay.events.view.GridRegionViewEvent;
	import com.rockmatch.screenstates.gameplay.models.fallLogic.vo.FallChipVO;
	import com.rockmatch.screenstates.gameplay.views.animator.GridRegionAnimator;
	import com.rockmatch.screenstates.gameplay.views.animator.IAnimator;
	import com.rockmatch.screenstates.gameplay.views.animator.animations.ChipsAnimationsEnum;
	import com.rockmatch.screenstates.gameplay.views.components.ChipView;
	import com.rockmatch.screenstates.gameplay.views.animator.wraps.ChipViewFallWrap;

	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;


	/**
	 *
	 * @author dkoloskov
	 *
	 */
	public class GridRegionView extends BaseView
	{
		private var _chipFrameLayer:Sprite;
		private var _chipsLayer:Sprite;
		private var _backgroundLayer:Sprite;

		private var _grid:Vector.<Vector.<ChipView>>;

		private var _animator:IAnimator;

		//==============================================================================
		//{region							PUBLIC METHODS
		public function GridRegionView()
		{
			this.createEmptyGrid();
			this.createLayers();

			this.addEventListener(MouseEvent.CLICK, chipClickHandler);
		}

		override public function activate():void
		{
			_animator = new GridRegionAnimator();
		}

		public function playSwapChipsAnimation(swapSuccessful:Boolean, chip1X:int, chip1Y:int, chip2X:int, chip2Y:int):void
		{
			var animationType:String = (swapSuccessful) ? ChipsAnimationsEnum.SWAP_CHIPS_SUCCESSFUL : ChipsAnimationsEnum.SWAP_CHIPS_FAIL;
			var chip1:ChipView = _grid[chip1X][chip1Y];
			var chip2:ChipView = _grid[chip2X][chip2Y];

			var params:Object = {chip1: chip1, chip2: chip2, swapSuccessful: swapSuccessful};
			_animator.playAnimation(animationType, params, this.swapChipsAnimationCompleteHandler);
		}

		public function playExplodeChipsAnimation(chipsPositions:Vector.<Point>, match_id:uint):void
		{
			var explodeChips:Vector.<ChipView> = new <ChipView>[];

			var i:uint;
			var chipsLen:uint = chipsPositions.length;
			var chip:ChipView;
			var p:Point;
			for(i = 0; i < chipsLen; i++)
			{
				p = chipsPositions[i];
				chip = _grid[p.x][p.y];

				explodeChips.push(chip);
			}

			var params:Object = {chips: explodeChips, match_id: match_id};
			_animator.playAnimation(ChipsAnimationsEnum.EXPLODE_CHIPS, params, this.explodeChipsAnimationCompleteHandler);
		}

		public function playFallChipsAnimation(chipsFallWraps:Vector.<ChipViewFallWrap>):void
		{
			var params:Object = {chipsFallWraps: chipsFallWraps};
			_animator.playAnimation(ChipsAnimationsEnum.FALL_CHIPS, params, this.fallChipsAnimationCompleteHandler);
		}

		public function addChipFrame(chipFrame:Sprite, gridX:int, gridY:int):void
		{
			this.removeChipFrame();

			chipFrame.x = gridX * AppSettings.GRID_TILE_SIZE;
			chipFrame.y = gridY * AppSettings.GRID_TILE_SIZE;
			_chipFrameLayer.addChild(chipFrame);
		}

		public function removeChipFrame():void
		{
			while(_chipFrameLayer.numChildren > 0)
			{
				_chipFrameLayer.removeChildAt(0);
			}
		}

		public function addChip(chip:ChipView):void
		{
			// CHECK FOR FALL ANIMATION
			if(chip.gridY >= 0)
			{
				if(_grid[chip.gridX][chip.gridY] != null)
				{
					this.removeChipOnPosition(chip.gridX, chip.gridY);
				}

				_grid[chip.gridX][chip.gridY] = chip;
			}

			_chipsLayer.addChild(chip);
			chip.x = chip.gridX * AppSettings.GRID_TILE_SIZE + AppSettings.GRID_TILE_SIZE / 2;
			chip.y = chip.gridY * AppSettings.GRID_TILE_SIZE + AppSettings.GRID_TILE_SIZE / 2;
		}

		public function getChipOnPosition(gridX:int, gridY:int):ChipView
		{
			return _grid[gridX][gridY];
		}

		public function removeChipOnPosition(gridX:int, gridY:int):void
		{
			var chip:ChipView = _grid[gridX][gridY];
			_grid[gridX][gridY] = null;

			chip.destroy();
			chip = null;
		}

		public function addGrid(grid:Sprite):void
		{
			grid.alpha = 0.3;
			_backgroundLayer.addChild(grid);
		}

		override public function destroy():void
		{
			super.destroy();

			_backgroundLayer = null;
			_chipsLayer = null;
			_chipFrameLayer = null;

			_grid = null;
		}

		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		private function swapChips(chip1:ChipView, chip2:ChipView):void
		{
			var tempGridX:uint = chip1.gridX;
			var tempGridY:uint = chip1.gridY;

			chip1.gridX = chip2.gridX;
			chip1.gridY = chip2.gridY;
			_grid[chip1.gridX][chip1.gridY] = chip1;

			chip2.gridX = tempGridX;
			chip2.gridY = tempGridY;
			_grid[chip2.gridX][chip2.gridY] = chip2;
		}

		private function createEmptyGrid():void
		{
			_grid = new <Vector.<ChipView>>[];

			var i:int;
			var column:Vector.<ChipView>;
			for(i = 0; i < AppSettings.GRID_WIDTH; i++)
			{
				column = new Vector.<ChipView>(AppSettings.GRID_HEIGHT);
				_grid.push(column);
			}
		}

		private function createLayers():void
		{
			_backgroundLayer = new Sprite();
			_backgroundLayer.mouseEnabled = false;
			_backgroundLayer.mouseChildren = false;
			this.addChild(_backgroundLayer);

			_chipsLayer = new Sprite();
			this.addChild(_chipsLayer);

			_chipFrameLayer = new Sprite();
			this.addChild(_chipFrameLayer);
		}

		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		private function chipClickHandler(event:MouseEvent):void
		{
			var chipView:ChipView = event.target as ChipView;
			this.dispatchEvent(new GridRegionViewEvent(GridRegionViewEvent.PICK_CHIP, {gridX: chipView.gridX, gridY: chipView.gridY}));
		}

		private function swapChipsAnimationCompleteHandler(chip1:ChipView, chip2:ChipView, swapSuccessful:Boolean):void
		{
			if(swapSuccessful)
			{
				this.swapChips(chip1, chip2);
			}
			this.dispatchEvent(new GridRegionViewEvent(GridRegionViewEvent.SWAP_CHIPS_COMPLETE));
		}

		private function explodeChipsAnimationCompleteHandler(explodeChips:Vector.<ChipView>, match_id:uint):void
		{
			var i:uint;
			var chipsLen:uint = explodeChips.length;
			var chip:ChipView;
			for(i = 0; i < chipsLen; i++)
			{
				chip = explodeChips[i];
				this.removeChipOnPosition(chip.gridX, chip.gridY);
			}
			this.dispatchEvent(new GridRegionViewEvent(GridRegionViewEvent.EXPLODE_CHIPS_COMPLETE, match_id));
		}

		private function fallChipsAnimationCompleteHandler(chipsFallWraps:Vector.<ChipViewFallWrap>):void
		{
			var i:uint;
			var chipsLen:uint = chipsFallWraps.length;
			var chipFallWrap:ChipViewFallWrap;
			for(i = 0; i < chipsLen; i++)
			{
				chipFallWrap = chipsFallWraps[i];
				_grid[chipFallWrap.view.gridX][chipFallWrap.view.gridY] = chipFallWrap.view;
			}
			this.dispatchEvent(new GridRegionViewEvent(GridRegionViewEvent.FALL_CHIPS_COMPLETE));
		}
		//} endregion EVENTS HANDLERS ==================================================
	}
}