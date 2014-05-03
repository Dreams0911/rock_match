/**
 * User: Dreams-Ultra
 * Date: 20.04.14
 * Time: 15:56
 */
package com.rockmatch.screenstates.gameplay.views.components
{
	public class ChipViewFallWrap
	{
		private var _view:ChipView;
		private var _finishGridY:int;

		public function ChipViewFallWrap(view:ChipView, finishGridY:int)
		{
			_view = view;
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
		public function get view():ChipView
		{
			return _view;
		}

		public function get fallDistance():int
		{
			var distance:int = _finishGridY - _view.gridY;
			return distance;
		}
		//} endregion GETTERS/SETTERS ==================================================
	}
}
