package com.rockmatch.screenstates.mainmenu.events.view
{
	import com.rockmatch.core.base.events.BaseViewEvent;


	/**
	 * 
	 * @author dkoloskov
	 * 
	 */	
	public class MainMenuViewEvent extends BaseViewEvent
	{
		static public const PLAY_CLICK:String = "MainMenuViewEvent::PLAY_CLICK";
		
		//==============================================================================
		//{region							PUBLIC METHODS
		public function MainMenuViewEvent(type:String, body:* = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, body, bubbles, cancelable);
		}
		//} endregion PUBLIC METHODS ===================================================
	}
}