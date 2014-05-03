package com.rockmatch.screenstates.gameplay.events.model
{
	import com.rockmatch.core.base.events.ContextEvent;


	/**
	 *
	 * @author dkoloskov
	 *
	 */
	public class GridRegionModelEvent extends ContextEvent
	{
		static public const STATE_CHANGED:String = "GridRegionModelEvent::STATE_CHANGED";
		static public const ALL_NEW_CHIPS_GENERATED:String = "GridRegionModelEvent::ALL_NEW_CHIPS_GENERATED";

		static public const CHIP_PICKED:String = "GridRegionModelEvent::CHIP_PICKED";
		//static public const CHIP_PICKED:String = "GridRegionModelEvent::CHIP_PICKED";

		// TESTING EVENT
		public static const TEST_CHIPS_UPDATED:String = "GridRegionModelEvent::TEST_CHIPS_UPDATED";

		//==============================================================================
		//{region							PUBLIC METHODS
		public function GridRegionModelEvent(type:String, body:* = null)
		{
			super(type, body);
		}

		//} endregion PUBLIC METHODS ===================================================
	}
}