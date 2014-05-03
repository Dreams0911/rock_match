package com.rockmatch.screenstates.gameplay.mediators
{
	import com.rockmatch.AppSettings;
	import com.rockmatch.screenstates.gameplay.models.IUIFactory;
	import com.rockmatch.screenstates.gameplay.views.GameplayView;

	import flash.display.Sprite;

	import robotlegs.bender.bundles.mvcs.Mediator;


	/**
	 *
	 * @author dkoloskov
	 *
	 */
	public class GameplayViewMediator extends Mediator
	{
		[Inject]
		public var view:GameplayView;

		[Inject]
		public var uiFactory:IUIFactory;


		//==============================================================================
		//{region							PUBLIC METHODS
		override public function initialize():void
		{
			super.initialize();

			this.addBackground();
			// ++++++++++++ TEST TEST TEST TEST TEST ++++++++++++
			if(AppSettings.TEST_SHOW_IDS)
			{
				this.view.addTestRegion();
			}
			// ------------ TEST TEST TEST TEST TEST ------------
			this.addGridRegion();
			this.addHud();

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
		private function addHud():void
		{
			this.view.addHud();
		}

		private function addGridRegion():void
		{
			this.view.addGridRegion();
		}

		private function addBackground():void
		{
			var background:Sprite = this.uiFactory.createBackground();
			this.view.addChild(background);
		}

		private function addListeners():void
		{

		}

		private function removeListeners():void
		{

		}

		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS


		//} endregion EVENTS HANDLERS ==================================================
	}
}