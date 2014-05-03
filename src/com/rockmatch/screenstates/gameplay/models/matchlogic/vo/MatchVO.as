/**
 * User: Dreams-Ultra
 * Date: 20.04.14
 * Time: 15:39
 */
package com.rockmatch.screenstates.gameplay.models.matchlogic.vo
{
	import com.rockmatch.screenstates.gameplay.models.gridregion.vo.*;
	import com.rockmatch.screenstates.gameplay.models.matchlogic.MatchTypesEnum;

	import flash.geom.Point;


	public class MatchVO
	{
		private var _id:uint;
		private var _type:uint;
		private var _chips:Vector.<ChipVO>;

		private var _length:uint;

		public function MatchVO(chips:Vector.<ChipVO>)
		{
			_chips = chips;
			_length = _chips.length;
			_type = MatchTypesEnum.SIMPLE;
		}

		//==============================================================================
		//{region							PUBLIC METHODS
		public function addChip(chip:ChipVO):void
		{
			_chips.push(chip);
			_length = _chips.length;
		}

		public function updateType():void
		{
			if(_type < MatchTypesEnum.LARGE_PIECE)
			{
				_type++;
			}
		}

		public function getPositions():Vector.<Point>
		{
			var positions:Vector.<Point> = new <Point>[];

			var i:uint;
			var chip:ChipVO;
			var p:Point;
			for(i = 0; i < _length; i++)
			{
				chip = _chips[i];
				p = new Point(chip.gridX, chip.gridY);

				positions.push(p);
			}
			return positions;
		}

		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		public function get id():uint
		{
			return _id;
		}

		public function set id(value:uint):void
		{
			_id = value;
		}

		public function get type():uint
		{
			return _type;
		}

		public function set type(value:uint):void
		{
			_type = value;
		}

		public function get chips():Vector.<ChipVO>
		{
			return _chips;
		}

		public function get length():uint
		{
			return _length;
		}

		//} endregion GETTERS/SETTERS ==================================================
	}
}
