package com.rockmatch.screenstates.mainmenu.views
{
	import com.rockmatch.core.base.views.BaseView;
	import com.rockmatch.screenstates.mainmenu.events.view.MainMenuViewEvent;

	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;


	/**
	 *
	 * @author dkoloskov
	 *
	 */
	public class MainMenuView extends BaseView
	{
		private var _play_btn:SimpleButton;

		//==============================================================================
		//{region							PUBLIC METHODS
		public function MainMenuView()
		{

		}

		public function addResource(resource:MovieClip):void
		{
			_play_btn = resource["play_btn"];
			this.addChild(resource);

			this.addListeners();
		}

		override public function destroy():void
		{
			super.destroy();
			_play_btn = null;
		}

		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		override protected function addListeners():void
		{
			_play_btn.addEventListener(MouseEvent.CLICK, this.playClickHandler);
		}

		override protected function removeListeners():void
		{
			_play_btn.removeEventListener(MouseEvent.CLICK, this.playClickHandler);
		}

		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		private function playClickHandler(event:MouseEvent):void
		{
			this.dispatchEvent(new MainMenuViewEvent(MainMenuViewEvent.PLAY_CLICK));
		}

		//} endregion EVENTS HANDLERS ==================================================
	}
}