package com.rockmatch.core.base.events
{
	import flash.events.Event;


	/**
	 *
	 * @author dkoloskov
	 *
	 */
	public class ContextEvent extends Event
	{
		private var _body:*;

		//==============================================================================
		//{region							PUBLIC METHODS
		public function ContextEvent(type:String, body:* = null)
		{
			_body = body;
			super(type);
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