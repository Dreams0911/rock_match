/**
 * User: Dreams-Ultra
 * Date: 20.04.14
 * Time: 15:56
 */
package com.rockmatch.screenstates.gameplay.views.animator.wraps
{
	import com.rockmatch.screenstates.gameplay.views.components.*;
	public class ChipViewMoveWrap extends ChipViewAbstractWrap
	{
		private var _finishX:int;
		private var _finishY:int;

		public function ChipViewMoveWrap(view:ChipView, finishX:int, finishY:int)
		{
			super(view);
			_finishX = finishX;
			_finishY = finishY;
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
		public function get moveCompleted():Boolean
		{
			if(_view.x == _finishX && _view.y == _finishY)
			{
				return true;
			}
			return false;
		}
		//} endregion GETTERS/SETTERS ==================================================
	}
}
