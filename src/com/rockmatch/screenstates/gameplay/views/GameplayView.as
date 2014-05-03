package com.rockmatch.screenstates.gameplay.views
{
	import com.rockmatch.AppSettings;
	import com.rockmatch.core.base.views.BaseView;
	import com.rockmatch.screenstates.gameplay.views.test.TestRegionView;

	import flash.display.Sprite;


	/**
	 *
	 * @author dkoloskov
	 *
	 */
	public class GameplayView extends BaseView
	{
		private var _gridRegionView:GridRegionView;
		private var _hudView:HudView;

		//==============================================================================
		//{region							PUBLIC METHODS
		public function GameplayView()
		{

		}

		public function addHud():void
		{
			_hudView = new HudView();
			this.addChild(_hudView);
		}

		public function addGridRegion():void
		{
			_gridRegionView = new GridRegionView();

			_gridRegionView.x = (this.stage.stageWidth - (AppSettings.GRID_WIDTH*AppSettings.GRID_TILE_SIZE))/2;
			_gridRegionView.y = this.stage.stageHeight - (AppSettings.GRID_HEIGHT*AppSettings.GRID_TILE_SIZE) - 50;
			// ++++++++++++ TEST TEST TEST TEST TEST ++++++++++++
			if(AppSettings.TEST_SHOW_IDS)
			{
				_gridRegionView.x = 50;
			}
			// ------------ TEST TEST TEST TEST TEST ------------
			this.addChild(_gridRegionView);
		}

		// ++++++++++++ TEST TEST TEST TEST TEST ++++++++++++
		public function addTestRegion():void
		{
			var testRegionView:TestRegionView = new TestRegionView();
			testRegionView.x = (this.stage.stageWidth - (AppSettings.GRID_WIDTH*AppSettings.GRID_TILE_SIZE))- 50;
			testRegionView.y = this.stage.stageHeight - (AppSettings.GRID_HEIGHT*AppSettings.GRID_TILE_SIZE) - 50;
			this.addChild(testRegionView);
		}
		// ------------ TEST TEST TEST TEST TEST ------------

		public function addBackground(background:Sprite):void
		{
			background.mouseEnabled = false;
			background.mouseChildren = false;
			this.addChild(background);
		}

		override public function destroy():void
		{
			_gridRegionView = null;
			super.destroy();
		}

		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS

		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS

		//} endregion EVENTS HANDLERS ==================================================
	}
}