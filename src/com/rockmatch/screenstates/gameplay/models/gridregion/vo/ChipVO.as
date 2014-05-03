/**
 * User: Dreams-Ultra
 * Date: 20.04.14
 * Time: 15:39
 */
package com.rockmatch.screenstates.gameplay.models.gridregion.vo
{
	public class ChipVO
	{
		private var _id:int;
		private var _gridX:int;
		private var _gridY:int;

		public function ChipVO(id:int = -1, gridX:int = -1, gridY:int = -1)
		{
			_id = id;
			_gridX = gridX;
			_gridY = gridY;
		}

		//==============================================================================
		//{region							PUBLIC METHODS
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		public function get id():int
		{
			return _id;
		}

		public function set id(value:int):void
		{
			_id = value;
		}

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
