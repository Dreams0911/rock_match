package com.rockmatch.core.base.views
{
	import flash.display.Sprite;
	import flash.events.Event;


	/**
	 *
	 * @author dkoloskov
	 *
	 */
	public class BaseView extends Sprite
	{
		//==============================================================================
		//{region							PUBLIC METHODS
		public function BaseView()
		{
			this.init();
		}

		public function init():void
		{
			this.addEventListener(Event.ADDED_TO_STAGE, this.addedToStageHandler);
		}

		/**
		 * Triggers when added to stage
		 */
		public function activate():void
		{

		}

		public function destroy():void
		{
			this.removeListeners();
			this.parent.removeChild(this);
			this.removeChildren(0, this.numChildren - 1);
		}

		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		private function addedToStageHandler(event:Event):void
		{
			event.stopPropagation();
			this.removeEventListener(Event.ADDED_TO_STAGE, this.addedToStageHandler);
			this.activate();
		}

		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		protected function addListeners():void
		{

		}

		protected function removeListeners():void
		{

		}

		//} endregion PRIVATE\PROTECTED METHODS ========================================
	}
}