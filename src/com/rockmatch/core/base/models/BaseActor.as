package com.rockmatch.core.base.models
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;


	/**
	 *
	 * @author dkoloskov
	 *
	 */
	public class BaseActor
	{
		private var _eventDispatcher:IEventDispatcher;

		//==============================================================================
		//{region							PUBLIC METHODS
		public function BaseActor()
		{
		}

		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		protected function dispatch(event:Event):Boolean
		{
			if(_eventDispatcher.hasEventListener(event.type))
			{
				return _eventDispatcher.dispatchEvent(event);
			}
			return false;
		}

		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		public function get eventDispatcher():IEventDispatcher
		{
			return _eventDispatcher;
		}

		[Inject]
		public function set eventDispatcher(value:IEventDispatcher):void
		{
			_eventDispatcher = value;
		}

		//} endregion GETTERS/SETTERS ==================================================
	}
}