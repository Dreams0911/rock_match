package com.rockmatch.resourcemanager.events
{
	import com.rockmatch.core.base.events.ContextEvent;


	/**
	 *
	 * @author dkoloskov
	 *
	 */
	public class ResourceManagerEvent extends ContextEvent
	{
		static public const LOAD:String = "LOAD";
		static public const PROGRESS:String = "PROGRESS";
		static public const LOAD_COMPLETED:String = "LOAD_COMPLETED";

		//==============================================================================
		//{region							PUBLIC METHODS
		public function ResourceManagerEvent(type:String, body:* = null)
		{
			super(type, body);
		}

		//} endregion PUBLIC METHODS ===================================================
	}
}