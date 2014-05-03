package com.rockmatch.screenstates.gameplay.events.view
{
	import com.rockmatch.core.base.events.BaseViewEvent;


	/**
	 *
	 * @author dkoloskov
	 *
	 */
	public class HudViewEvent extends BaseViewEvent
	{
		static public const SHUFFLE_CLICK:String = "HudViewEvent::SHUFFLE_CLICK";

		//==============================================================================
		//{region							PUBLIC METHODS
		public function HudViewEvent(type:String, body:* = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, body, bubbles, cancelable);
		}

		//} endregion PUBLIC METHODS ===================================================
	}
}