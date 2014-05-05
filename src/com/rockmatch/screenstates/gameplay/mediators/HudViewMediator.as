package com.rockmatch.screenstates.gameplay.mediators
{
	import com.rockmatch.resourcemanager.models.IResourceManager;
	import com.rockmatch.screenstates.gameplay.events.GridRegionEvent;
	import com.rockmatch.screenstates.gameplay.events.model.GameplayModelEvent;
	import com.rockmatch.screenstates.gameplay.events.model.GridRegionModelEvent;
	import com.rockmatch.screenstates.gameplay.events.view.HudViewEvent;
	import com.rockmatch.screenstates.gameplay.models.IGameplayModel;
	import com.rockmatch.screenstates.gameplay.views.HudView;

	import flash.display.MovieClip;

	import robotlegs.bender.bundles.mvcs.Mediator;


	/**
	 *
	 * @author dkoloskov
	 *
	 */
	public class HudViewMediator extends Mediator
	{
		[Inject]
		public var view:HudView;

		[Inject]
		public var resourceManager:IResourceManager;

		[Inject]
		public var gameplayModel:IGameplayModel;

		private const RESOURCE_NAME:String = "Hud";

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
			if(resource != null)
			{
				//resource.x = (this.view.stage.stageWidth - resource.width) >> 1;
				this.view.addResource(resource);
			}
		}

		private function addListeners():void
		{
			this.view.addEventListener(HudViewEvent.SHUFFLE_CLICK, shuffleClickHandler);

			this.addContextListener(GameplayModelEvent.INFO_UPDATED, this.infoUpdatedHandler);
		}

		private function removeListeners():void
		{
			this.view.removeEventListener(HudViewEvent.SHUFFLE_CLICK, shuffleClickHandler);

			this.removeContextListener(GameplayModelEvent.INFO_UPDATED, this.infoUpdatedHandler);
		}

		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		private function shuffleClickHandler(event:HudViewEvent):void
		{
			this.dispatch(new GridRegionEvent(GridRegionEvent.GENERATE_ALL_NEW_CHIPS));
		}

		private function infoUpdatedHandler(event:GridRegionModelEvent):void
		{
			this.view.updateScore(this.gameplayModel.score);
		}

		//} endregion EVENTS HANDLERS ==================================================
	}
}