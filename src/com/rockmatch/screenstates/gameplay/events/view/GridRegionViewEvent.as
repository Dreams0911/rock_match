package com.rockmatch.screenstates.gameplay.events.view
{
	import com.rockmatch.core.base.events.BaseViewEvent;


	/**
	 *
	 * @author dkoloskov
	 *
	 */
	public class GridRegionViewEvent extends BaseViewEvent
	{
		static public const PICK_CHIP:String = "GridRegionViewEvent::PICK_CHIP";
		static public const SWAP_CHIPS_COMPLETE:String = "GridRegionViewEvent::SWAP_CHIPS_COMPLETE";
		static public const EXPLODE_CHIPS_COMPLETE:String = "GridRegionViewEvent::EXPLODE_CHIPS_COMPLETE";
		static public const FALL_CHIPS_COMPLETE:String = "GridRegionViewEvent::FALL_CHIPS_COMPLETE";

		//==============================================================================
		//{region							PUBLIC METHODS
		public function GridRegionViewEvent(type:String, body:* = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, body, bubbles, cancelable);
		}

		//} endregion PUBLIC METHODS ===================================================
	}
}