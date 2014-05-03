package com.rockmatch.root.events
{
	import com.rockmatch.core.base.events.ContextEvent;


	/**
	 *
	 * @author dkoloskov
	 *
	 */
	public class ScreenStateEvent extends ContextEvent
	{
		static public const SET_SCREEN_STATE:String = "SET_PRELOADER_SCREEN_STATE";

		static public const SCREEN_STATE_CHANGED:String = "SCREEN_STATE_CHANGED";

		//==============================================================================
		//{region							PUBLIC METHODS
		public function ScreenStateEvent(type:String, body:* = null)
		{
			super(type, body);
		}

		//} endregion PUBLIC METHODS ===================================================
	}
}