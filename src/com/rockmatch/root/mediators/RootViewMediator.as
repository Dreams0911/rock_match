package com.rockmatch.root.mediators
{
	import com.rockmatch.core.base.views.BaseView;
	import com.rockmatch.root.events.ScreenStateEvent;
	import com.rockmatch.root.model.IScreenStateModel;
	import com.rockmatch.root.views.RootView;

	import robotlegs.bender.bundles.mvcs.Mediator;
	import robotlegs.bender.extensions.contextView.ContextView;


	/**
	 *
	 * @author dkoloskov
	 *
	 */
	public class RootViewMediator extends Mediator
	{
		[Inject]
		public var view:RootView;

		[Inject]
		public var contextView:ContextView;

		[Inject]
		public var _stateModel:IScreenStateModel;

		//==============================================================================
		//{region							PUBLIC METHODS
		override public function initialize():void
		{
			super.initialize();
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
		private function clearPreviousScreenState():void
		{
			if(this.view.numChildren == 0)
			{
				return;
			}

			var prevStateView:BaseView = this.view.getChildAt(0) as BaseView;
			if(prevStateView == null)
			{
				return;
			}
			prevStateView.destroy();
		}

		private function setScreenState():void
		{
			var stateView:BaseView = new _stateModel.screenStateClass();
			this.view.addChild(stateView);
		}

		private function setFocusIn():void
		{
			this.contextView.view.stage.focus = contextView.view;
		}

		private function addListeners():void
		{
			this.addContextListener(ScreenStateEvent.SCREEN_STATE_CHANGED, this.scteenStateChangeHandler);
		}

		private function removeListeners():void
		{
			this.removeContextListener(ScreenStateEvent.SCREEN_STATE_CHANGED, this.scteenStateChangeHandler)
		}

		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		private function scteenStateChangeHandler(event:ScreenStateEvent):void
		{
			this.clearPreviousScreenState();
			this.setScreenState();

			//Fix for mouse click loose focus
			this.setFocusIn();
		}

		//} endregion EVENTS HANDLERS ==================================================
	}
}