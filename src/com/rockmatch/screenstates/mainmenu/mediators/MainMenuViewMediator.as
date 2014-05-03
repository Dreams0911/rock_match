package com.rockmatch.screenstates.mainmenu.mediators
{
	import com.rockmatch.resourcemanager.models.IResourceManager;
	import com.rockmatch.root.events.ScreenStateEvent;
	import com.rockmatch.root.model.ScreenStatesEnum;
	import com.rockmatch.screenstates.mainmenu.events.view.MainMenuViewEvent;
	import com.rockmatch.screenstates.mainmenu.views.MainMenuView;

	import flash.display.MovieClip;

	import robotlegs.bender.bundles.mvcs.Mediator;


	/**
	 *
	 * @author dkoloskov
	 *
	 */
	public class MainMenuViewMediator extends Mediator
	{
		[Inject]
		public var view:MainMenuView;

		[Inject]
		public var resourceManager:IResourceManager;

		private const RESOURCE_NAME:String = "MainMenu";

		//==============================================================================
		//{region							PUBLIC METHODS
		override public function initialize():void
		{
			super.initialize();

			this.addResource();
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
		private function addResource():void
		{
			var resource:MovieClip = this.resourceManager.getMC(this.RESOURCE_NAME);
			if(resource == null)
			{
				return;
			}

			this.view.addResource(resource);
		}

		private function addListeners():void
		{
			this.view.addEventListener(MainMenuViewEvent.PLAY_CLICK, playClickHandler);
		}

		private function removeListeners():void
		{
			this.view.removeEventListener(MainMenuViewEvent.PLAY_CLICK, playClickHandler);
		}

		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		private function playClickHandler(event:MainMenuViewEvent):void
		{
			this.dispatch(new ScreenStateEvent(ScreenStateEvent.SET_SCREEN_STATE, ScreenStatesEnum.GAMEPLAY));
		}

		//} endregion EVENTS HANDLERS ==================================================
	}
}