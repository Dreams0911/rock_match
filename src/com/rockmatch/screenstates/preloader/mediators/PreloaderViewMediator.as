package com.rockmatch.screenstates.preloader.mediators
{
	import com.rockmatch.resourcemanager.events.ResourceManagerEvent;
	import com.rockmatch.resourcemanager.models.IResourceManager;
	import com.rockmatch.root.events.ScreenStateEvent;
	import com.rockmatch.root.model.ScreenStatesEnum;
	import com.rockmatch.screenstates.preloader.views.PreloaderView;

	import flash.display.MovieClip;

	import robotlegs.bender.bundles.mvcs.Mediator;


	/**
	 *
	 * @author dkoloskov
	 *
	 */
	public class PreloaderViewMediator extends Mediator
	{
		[Inject]
		public var view:PreloaderView;

		[Inject]
		public var resourceManager:IResourceManager;

		private const RESOURCE_NAME:String = "Preloader";

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
			this.addContextListener(ResourceManagerEvent.PROGRESS, this.loadProgressHandler);
			this.addContextListener(ResourceManagerEvent.LOAD_COMPLETED, this.loadCompletedHandler);
		}

		private function removeListeners():void
		{
			this.removeContextListener(ResourceManagerEvent.PROGRESS, this.loadProgressHandler);
			this.removeContextListener(ResourceManagerEvent.LOAD_COMPLETED, this.loadCompletedHandler);
		}

		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		private function loadProgressHandler(event:ResourceManagerEvent):void
		{
			var progressPercent:int = event.body;
			this.view.updateProgress(progressPercent);
		}

		private function loadCompletedHandler(event:ResourceManagerEvent):void
		{
			this.dispatch(new ScreenStateEvent(ScreenStateEvent.SET_SCREEN_STATE, ScreenStatesEnum.MAIN_MENU));
		}

		//} endregion EVENTS HANDLERS ==================================================
	}
}