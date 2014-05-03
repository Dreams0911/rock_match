/**
 * User: Dreams-Ultra
 * Date: 23.04.14
 * Time: 19:55
 */
package com.rockmatch.screenstates.gameplay.models.matchlogic
{
	import com.rockmatch.AppSettings;
	import com.rockmatch.screenstates.gameplay.models.gridregion.vo.ChipVO;
	import com.rockmatch.screenstates.gameplay.models.matchlogic.vo.MatchVO;

	import flash.geom.Point;


	public class MatchLogic
	{
		private const DIRECTIONS:Vector.<Point> = new <Point>[new Point(1, 0), new Point(0, 1), new Point(-1, 0), new Point(0, -1)];

		private var _grid:Vector.<Vector.<ChipVO>>;

		public function MatchLogic()
		{
		}

		//==============================================================================
		//{region							PUBLIC METHODS
		public function isNeighbors(chip1:ChipVO, chip2:ChipVO):Boolean
		{
			var i:uint;
			var directionsLen:uint = this.DIRECTIONS.length;
			var direction:Point;
			for(i = 0; i < directionsLen; i++)
			{
				direction = this.DIRECTIONS[i];
				if(chip1.gridX + direction.x == chip2.gridX && chip1.gridY + direction.y == chip2.gridY)
				{
					return true;
				}
			}

			return false;
		}

		public function findMatches():Vector.<MatchVO>
		{
			var matchIDCounter:uint = 0;

			var horizontalMatches:Vector.<MatchVO> = new <MatchVO>[];
			// FIND HORIZONTAL LINES
			var gridY:uint;
			var gridX:uint;
			var rowsLen:uint = AppSettings.GRID_HEIGHT;
			var columnsLen:uint = AppSettings.GRID_WIDTH - 2;
			var match:MatchVO;
			for(gridY = 0; gridY < rowsLen; gridY++)
			{
				for(gridX = 0; gridX < columnsLen; gridX++)
				{
					match = this.getMatchHorizontal(gridX, gridY);
					if(match.length > 2)
					{
						matchIDCounter++;
						match.id = matchIDCounter;

						horizontalMatches.push(match);
						gridX += match.length - 1;
					}
				}
			}

			var verticalMatches:Vector.<MatchVO> = new <MatchVO>[];
			// FIND VERTICAL LINES
			columnsLen = AppSettings.GRID_WIDTH;
			rowsLen = AppSettings.GRID_HEIGHT - 2;
			for(gridX = 0; gridX < columnsLen; gridX++)
			{
				for(gridY = 0; gridY < rowsLen; gridY++)
				{
					match = this.getMatchVertical(gridX, gridY);
					if(match.length > 2)
					{
						matchIDCounter++;
						match.id = matchIDCounter;

						verticalMatches.push(match);
						gridY += match.length - 1;
					}
				}
			}

			var matches:Vector.<MatchVO> = this.mergeMatches(horizontalMatches, verticalMatches);
			return matches;
		}

		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		/**
		 * MERGE HORIZONTAL AND VERTICAL MATCHES TO FIND "L" AND "T" TYPE MATCHES
		 */
		private function mergeMatches(horizontal:Vector.<MatchVO>, vertical:Vector.<MatchVO>):Vector.<MatchVO>
		{
			var matches:Vector.<MatchVO> = new <MatchVO>[];

			// FIRST STEP: ADD HORIZONTALS (WITH CONNECTED VERTICALS)
			var i:int;
			var j:int;
			var horizontalLen:int = horizontal.length;
			var verticalLen:int = vertical.length;
			var hMatch:MatchVO;
			var vMatch:MatchVO;
			var merged:Boolean = false;
			for(i = 0; i < horizontalLen; i++)
			{
				hMatch = horizontal[i];
				matches.push(hMatch);

				for(j = verticalLen - 1; j >= 0; j--)
				{
					vMatch = vertical[j];
					merged = this.mergeIfConnected(hMatch, vMatch);
					if(merged)
					{
						merged = false;
						vertical.splice(j, 1);
						verticalLen--;
					}
				}
			}

			// SECOND STEP: NOT MERGED VERTICALS
			for(j = 0; j < verticalLen; j++)
			{
				vMatch = vertical[j];
				matches.push(vMatch);
			}

			return matches;
		}

		/**
		 * CHECK IS HORIZONTAL AND VERTICAL MATCHES ARE CONNECTED BY ONE OF CHIPS
		 * IF CONNECTED, MERGE TO hMatch:MatchVO
		 */
		private function mergeIfConnected(hMatch:MatchVO, vMatch:MatchVO):Boolean
		{
			var connected:Boolean = false;

			// CHECK IS CONNECTED
			var i:int;
			var j:int;
			var horizontalLen:int = hMatch.length;
			var verticalLen:int = vMatch.length;
			var hChip:ChipVO;
			var vChip:ChipVO;
			for(i = 0; i < horizontalLen; i++)
			{
				hChip = hMatch.chips[i];

				for(j = 0; j < verticalLen; j++)
				{
					vChip = vMatch.chips[j];

					if(hChip.gridX == vChip.gridX && hChip.gridY == vChip.gridY)
					{
						connected = true;
						vMatch.chips.splice(j, 1);
						verticalLen--;
						break;
					}
				}
			}

			if(connected)
			{
				// MERGE
				for(j = 0; j < verticalLen; j++)
				{
					vChip = vMatch.chips[j];
					hMatch.addChip(vChip);
				}
				return true;
			}

			return false;
		}

		private function getMatchHorizontal(gridX:uint, gridY:uint):MatchVO
		{
			var firstInLineChip:ChipVO = _grid[gridX][gridY];
			var match:MatchVO = new MatchVO(new <ChipVO>[firstInLineChip]);

			var i:int;
			var columnsLen:uint = AppSettings.GRID_WIDTH;
			var chip:ChipVO;
			for(i = gridX + 1; i < columnsLen; i++)
			{
				chip = _grid[i][gridY];
				if(firstInLineChip.id == chip.id)
				{
					match.addChip(chip);
				}
				else
				{
					return match;
				}
			}
			return match;
		}

		private function getMatchVertical(gridX:uint, gridY:uint):MatchVO
		{
			var firstInLineChip:ChipVO = _grid[gridX][gridY];
			var match:MatchVO = new MatchVO(new <ChipVO>[firstInLineChip]);

			var i:int;
			var rowsLen:uint = AppSettings.GRID_HEIGHT;
			var chip:ChipVO;
			for(i = gridY + 1; i < rowsLen; i++)
			{
				chip = _grid[gridX][i];
				if(firstInLineChip.id == chip.id)
				{
					match.addChip(chip);
				}
				else
				{
					return match;
				}
			}
			return match;
		}

		/*private function getChipNeighbors(chip:ChipVO):Vector.<ChipVO>
		 {
		 var neighbors:Vector.<ChipVO> = new <ChipVO>[];

		 var i:uint;
		 var directionsLen:uint = this.DIRECTIONS.length;
		 var direction:Point;
		 var neighborChipVO:ChipVO;
		 for(i = 0; i < directionsLen; i++)
		 {
		 direction = this.DIRECTIONS[i];
		 neighborChipVO = _chips[chip.gridX+direction.x][chip.gridY+direction.y];

		 if(neighborChipVO != null)
		 {
		 neighbors.push(neighborChipVO);
		 }
		 }
		 return neighbors;
		 }*/
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
