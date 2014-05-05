/**
 * User: Dreams-Ultra
 * Date: 20.04.14
 * Time: 15:56
 */
package com.rockmatch.screenstates.gameplay.views.animator.wraps
{
	import com.rockmatch.screenstates.gameplay.views.components.*;


	public class ChipViewAbstractWrap
	{
		protected var _view:ChipView;

		public function ChipViewAbstractWrap(view:ChipView)
		{
			_view = view;
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

		//} endregion GETTERS/SETTERS ==================================================
	}
}
