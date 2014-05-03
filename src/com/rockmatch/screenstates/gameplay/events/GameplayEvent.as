package com.rockmatch.screenstates.gameplay.events
{
	import com.rockmatch.core.base.events.ContextEvent;


	/**
	 *
	 * @author dkoloskov
	 *
	 */
	public class GameplayEvent extends ContextEvent
	{
		static public const UPDATE_SCORES:String = "GameplayEvent::UPDATE_SCORES";

		//==============================================================================
		//{region							PUBLIC METHODS
		public function GameplayEvent(type:String, body:* = null)
		{
			super(type, body);
		}

		//} endregion PUBLIC METHODS ===================================================
	}
}