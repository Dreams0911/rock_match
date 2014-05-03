package com.rockmatch.screenstates.gameplay.mediators.test
{
	import com.rockmatch.AppSettings;
	import com.rockmatch.screenstates.gameplay.events.model.GridRegionModelEvent;
	import com.rockmatch.screenstates.gameplay.models.IUIFactory;
	import com.rockmatch.screenstates.gameplay.models.gridregion.IGridRegionModel;
	import com.rockmatch.screenstates.gameplay.models.gridregion.vo.ChipVO;
	import com.rockmatch.screenstates.gameplay.views.test.TestRegionView;

	import flash.display.Sprite;

	import robotlegs.bender.bundles.mvcs.Mediator;


	/**
	 *
	 * @author dkoloskov
	 *
	 */
	public class TestRegionViewMediator extends Mediator
	{
		[Inject]
		public var view:TestRegionView;

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

		private function addListeners():void
		{
			this.addContextListener(GridRegionModelEvent.TEST_CHIPS_UPDATED, this.chipsUpdatedHandler);
		}

		private function removeListeners():void
		{
			this.removeContextListener(GridRegionModelEvent.TEST_CHIPS_UPDATED, this.chipsUpdatedHandler);
		}

		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		private function chipsUpdatedHandler(event:GridRegionModelEvent):void
		{
			var gridX:uint;
			var gridY:uint;
			var chipVO:ChipVO;
			for(gridX = 0; gridX < AppSettings.GRID_WIDTH; gridX++)
			{
				for(gridY = 0; gridY < AppSettings.GRID_HEIGHT; gridY++)
				{
					chipVO = this.gridRegionModel.grid[gridX][gridY];
					this.view.setChipID(chipVO.id, chipVO.gridX, chipVO.gridY);
				}
			}
		}

		//} endregion EVENTS HANDLERS ==================================================
	}
}