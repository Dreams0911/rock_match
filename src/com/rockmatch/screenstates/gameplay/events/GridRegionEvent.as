package com.rockmatch.screenstates.gameplay.events
{
	import com.rockmatch.core.base.events.ContextEvent;


	/**
	 *
	 * @author dkoloskov
	 *
	 */
	public class GridRegionEvent extends ContextEvent
	{
		static public const GENERATE_ALL_NEW_CHIPS:String = "GridRegionEvent::GENERATE_ALL_NEW_CHIPS";

		static public const PICK_CHIP:String = "GridRegionEvent::PICK_CHIP";
		static public const SWAP_COMPLETE:String = "GridRegionEvent::SWAP_COMPLETE";
		static public const EXPLOSION_COMPLETE:String = "GridRegionEvent::EXPLOSION_COMPLETE";
		static public const FALL_CHIPS_COMPLETE:String = "GridRegionEvent::FALL_CHIPS_COMPLETE";

		//==============================================================================
		//{region							PUBLIC METHODS
		public function GridRegionEvent(type:String, body:* = null)
		{
			super(type, body);
		}

		//} endregion PUBLIC METHODS ===================================================
	}
}