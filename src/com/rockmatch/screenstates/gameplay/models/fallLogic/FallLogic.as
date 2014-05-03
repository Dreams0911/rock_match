/**
 * User: Dreams-Ultra
 * Date: 23.04.14
 * Time: 19:55
 */
package com.rockmatch.screenstates.gameplay.models.fallLogic
{
	import com.rockmatch.AppSettings;
	import com.rockmatch.screenstates.gameplay.models.fallLogic.vo.FallChipVO;
	import com.rockmatch.screenstates.gameplay.models.gridregion.vo.ChipVO;
	import com.rockmatch.utils.GameUtils;


	public class FallLogic
	{
		private var _grid:Vector.<Vector.<ChipVO>>;

		private var _fallChipsMap:Array;

		public function FallLogic()
		{
		}

		//==============================================================================
		//{region							PUBLIC METHODS
		public function createFallChips():Vector.<FallChipVO>
		{
			// STEP 1. CREATE FALL CHIPS MAP
			this.createEmptyFallChipsMap();

			// STEP 2. GET REMOVABLE BOTTOM CHIPS
			var removableBottomChips:Vector.<ChipVO> = this.getRemovableBottomChips();
			var chipsLen:uint = removableBottomChips.length;

			// STEP 3. FILL FALL CHIPS MAP
			var i:uint;
			var gridX:int;
			var gridY:int;
			var removableChip:ChipVO;
			var fallDistance:int;
			for(i = 0; i < chipsLen; i++)
			{
				removableChip = removableBottomChips[i];
				gridX = removableChip.gridX;
				//fallDistance - DISTANCE TO FALL FOR CHIP (fallChip)
				fallDistance = 1;

				// ADD fallChip IN GRID AREA
				for(gridY = removableChip.gridY - 1; gridY >= 0; gridY--)
				{
					if(_grid[gridX][gridY] == null || _fallChipsMap[gridX][gridY] != null)
					{
						fallDistance++;
						continue;
					}

					this.setFallChip(gridX, gridY, fallDistance);
				}

				// ADD fallChip ABOVE GRID AREA
				for(gridY = -1; gridY >= -fallDistance; gridY--)
				{
					if(_fallChipsMap[gridX][gridY] == null)
					{
						this.setFallChip(gridX, gridY, fallDistance);
					}
				}
			}

			// STEP 4. GET FILLED CHIPS TO fallChipsArr:Array
			var fallChipsArr:Array = [];
			var fallChip:FallChipVO;
			for(gridX = 0; gridX < AppSettings.GRID_WIDTH; gridX++)
			{
				for(gridY = -AppSettings.GRID_HEIGHT; gridY < AppSettings.GRID_HEIGHT; gridY++)
				{
					fallChip = _fallChipsMap[gridX][gridY];
					if(fallChip != null)
					{
						fallChipsArr.push(fallChip);
					}
				}
			}
			_fallChipsMap = null;

			// STEP 5. SORT ARRAY TO MOVE LOWEST(BY gridY) FallChipVO TO BOTTOM
			fallChipsArr.sortOn("startGridY", Array.NUMERIC | Array.DESCENDING);
			var fallChips:Vector.<FallChipVO> = Vector.<FallChipVO>(fallChipsArr);

			return fallChips;
		}

		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		private function getRemovableBottomChips():Vector.<ChipVO>
		{
			var removableBottomChips:Vector.<ChipVO> = new <ChipVO>[];

			var gridX:int;
			var gridY:int;
			var chipVO:ChipVO;
			for(gridX = 0; gridX < AppSettings.GRID_WIDTH; gridX++)
			{
				for(gridY = AppSettings.GRID_HEIGHT - 1; gridY >= 0; gridY--)
				{
					if(_grid[gridX][gridY] == null)
					{
						chipVO = new ChipVO(-1, gridX, gridY);
						removableBottomChips.push(chipVO);
						break;
					}
				}
			}
			return removableBottomChips;
		}

		private function createEmptyFallChipsMap():void
		{
			_fallChipsMap = [];
			var gridX:int;
			var gridY:int;
			for(gridX = 0; gridX < AppSettings.GRID_WIDTH; gridX++)
			{
				_fallChipsMap[gridX] = [];
				for(gridY = -AppSettings.GRID_HEIGHT; gridY < AppSettings.GRID_HEIGHT; gridY++)
				{
					_fallChipsMap[gridX][gridY] = null;
				}
			}
		}

		/**
		 * IF FallChipVO DON'T EXIST - CREATE FallChipVO
		 * AND SET FALL DISTANCE TO IT
		 */
		private function setFallChip(gridX:int, gridY:int, fallDistance:int):void
		{
			var chip_id:int;
			if(gridY >= 0)
			{
				var chipVO:ChipVO = _grid[gridX][gridY];
				chip_id = chipVO.id;
			}
			else
			{
				chip_id = GameUtils.generateRandomChipID();
			}

			var fallChip:FallChipVO = new FallChipVO(chip_id, gridX, gridY, gridY + fallDistance);
			_fallChipsMap[gridX][gridY] = fallChip;
		}

		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		public function set grid(value:Vector.<Vector.<ChipVO>>):void
		{
			_grid = value;
		}

		//} endregion GETTERS/SETTERS ==================================================

	}
}
