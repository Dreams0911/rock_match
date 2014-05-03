/**
 * User: Dreams-Ultra
 * Date: 20.04.14
 * Time: 15:39
 */
package com.rockmatch.screenstates.gameplay.models.fallLogic.vo
{
	public class FallChipVO
	{
		private var _id:int;
		private var _gridX:int;
		private var _startGridY:int;
		private var _finishGridY:int;

		public function FallChipVO(id:int = -1, gridX:int = -1, startGridY:int = -1, finishGridY:int = -1)
		{
			_id = id;
			_gridX = gridX;
			_startGridY = startGridY;
			_finishGridY = finishGridY;
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

		public function get startGridY():int
		{
			return _startGridY;
		}

		public function set startGridY(value:int):void
		{
			_startGridY = value;
		}

		public function get finishGridY():int
		{
			return _finishGridY;
		}

		/*public function set finishGridY(value:int):void
		{
			_finishGridY = value;
		}*/

		public function get fallDistance():int
		{
			var distance:int = _finishGridY - _startGridY;
			return distance;
		}

		//} endregion GETTERS/SETTERS ==================================================
	}
}
