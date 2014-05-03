/**
 * User: Dreams-Ultra
 * Date: 20.04.14
 * Time: 15:56
 */
package com.rockmatch.screenstates.gameplay.views.components
{
	import com.rockmatch.core.base.views.BaseView;


	public class ChipView extends BaseView
	{
		private var _gridX:int;
		private var _gridY:int;

		public function ChipView(_gridX:int = -1, _gridY:int = -1)
		{
			_gridX = _gridX;
			_gridY = _gridY;
			this.mouseChildren = false;

			super();
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
		public function get gridX():int
		{
			return _gridX;
		}

		public function set gridX(value:int):void
		{
			_gridX = value;
		}

		public function get gridY():int
		{
			return _gridY;
		}

		public function set gridY(value:int):void
		{
			_gridY = value;
		}

		//} endregion GETTERS/SETTERS ==================================================
	}
}
