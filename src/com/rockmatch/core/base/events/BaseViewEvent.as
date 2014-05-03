package com.rockmatch.core.base.events
{
	import flash.events.Event;


	/**
	 *
	 * @author dkoloskov
	 *
	 */
	public class BaseViewEvent extends Event
	{
		private var _body:*;

		//==============================================================================
		//{region							PUBLIC METHODS
		public function BaseViewEvent(type:String, body:* = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			_body = body;
			super(type, bubbles, cancelable);
		}
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		public function get body():*
		{
			return _body;
		}
		//} endregion GETTERS/SETTERS ==================================================
	}
}