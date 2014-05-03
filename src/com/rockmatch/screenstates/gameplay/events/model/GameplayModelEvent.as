package com.rockmatch.screenstates.gameplay.events.model
{
	import com.rockmatch.core.base.events.ContextEvent;


	/**
	 *
	 * @author dkoloskov
	 *
	 */
	public class GameplayModelEvent extends ContextEvent
	{
		static public const INFO_UPDATED:String = "GameplayModelEvent::INFO_UPDATED";

		//==============================================================================
		//{region							PUBLIC METHODS
		public function GameplayModelEvent(type:String, body:* = null)
		{
			super(type, body);
		}

		//} endregion PUBLIC METHODS ===================================================
	}
}