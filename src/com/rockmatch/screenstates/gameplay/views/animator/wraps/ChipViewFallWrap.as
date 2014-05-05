/**
 * User: Dreams-Ultra
 * Date: 20.04.14
 * Time: 15:56
 */
package com.rockmatch.screenstates.gameplay.views.animator.wraps
{
	import com.rockmatch.screenstates.gameplay.views.components.*;


	public class ChipViewFallWrap extends ChipViewAbstractWrap
	{
		private var _finishGridY:int;

		public function ChipViewFallWrap(view:ChipView, finishGridY:int)
		{
			super(view);
			_finishGridY = finishGridY;
		}

		//==============================================================================
		//{region							PUBLIC METHODS
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		public function get fallDistance():int
		{
			var distance:int = _finishGridY - _view.gridY;
			return distance;
		}

		//} endregion GETTERS/SETTERS ==================================================
	}
}
