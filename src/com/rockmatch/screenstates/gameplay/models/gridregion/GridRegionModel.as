package com.rockmatch.screenstates.gameplay.models.gridregion
{
	import com.rockmatch.AppSettings;
	import com.rockmatch.core.base.models.BaseActor;
	import com.rockmatch.screenstates.gameplay.events.model.GridRegionModelEvent;
	import com.rockmatch.screenstates.gameplay.models.fallLogic.FallLogic;
	import com.rockmatch.screenstates.gameplay.models.fallLogic.vo.FallChipVO;
	import com.rockmatch.screenstates.gameplay.models.gridregion.vo.ChipVO;
	import com.rockmatch.screenstates.gameplay.models.matchlogic.MatchLogic;
	import com.rockmatch.screenstates.gameplay.models.matchlogic.vo.MatchVO;
	import com.rockmatch.utils.GameUtils;


	/**
	 *
	 * @author dkoloskov
	 *
	 */
	public class GridRegionModel extends BaseActor implements IGridRegionModel
	{
		private var _matchLogic:MatchLogic;
		private var _fallLogic:FallLogic;

		private var _state:String = GridRegionStatesEnum.IDLE_STATE;

		private var _grid:Vector.<Vector.<ChipVO>>;
		private var _currentChip:ChipVO;

		private var _swapChip1:ChipVO;
		private var _swapChip2:ChipVO;
		private var _matches:Vector.<MatchVO>;

		private var _fallChips:Vector.<FallChipVO>;

		//==============================================================================
		//{region							PUBLIC METHODS
		public function GridRegionModel()
		{
			_matchLogic = new MatchLogic();
			_fallLogic = new FallLogic();
		}

		public function lookForMatches():void
		{
			_matches = _matchLogic.findMatches();
			if(_matches.length > 0)
			{
				this.clearRemovableChipsFromGrid();
				this.createFallChips();
				this.fillGridWithNewChips();
				// ++++++++++++ TEST TEST TEST TEST TEST ++++++++++++
				this.dispatch(new GridRegionModelEvent(GridRegionModelEvent.TEST_CHIPS_UPDATED));
				// ------------ TEST TEST TEST TEST TEST ------------
			}
		}

		public function pickChipValidation(gridX:int, gridY:int):void
		{
			// IF PICKED EMPTY SPACE CHIP (POSSIBLY WILL BE IMPLEMENTED)
			var chip:ChipVO = _grid[gridX][gridY];
			if(chip == null)
			{
				return;
			}

			// IF PICKED SAME CHIP
			if(_currentChip != null && _currentChip.gridX == gridX && _currentChip.gridY == gridY)
			{
				return;
			}

			// PICK CURRENT CHIP (FIRST CHIP TO SWAP)
			if(_currentChip == null || !_matchLogic.isNeighbors(_currentChip, chip))
			{
				this.pickCurrentChip(chip);
				return;
			}

			//
			this.swapAndFindMatches(_currentChip, chip);
		}

		/**
		 * REMOVES MatchVO FROM Vector.<MatchVO>
		 * @param match_id
		 */
		public function removeMatch(match_id:uint):void
		{
			var i:uint;
			var matchesLen:uint = _matches.length;
			var match:MatchVO;
			for(i = 0; i < matchesLen; i++)
			{
				match = _matches[i];
				if(match.id == match_id)
				{
					_matches.splice(i, 1);
					break;
				}
			}
		}

		public function generateAllNewChips():void
		{
			_grid = new <Vector.<ChipVO>>[];
			_matchLogic.grid = _grid;
			_fallLogic.grid = _grid;

			var gridX:int;
			var gridY:int;
			var chip_id:int;
			var chip:ChipVO;
			var column:Vector.<ChipVO>;
			for(gridX = 0; gridX < AppSettings.GRID_WIDTH; gridX++)
			{
				column = new <ChipVO>[];
				for(gridY = 0; gridY < AppSettings.GRID_HEIGHT; gridY++)
				{
					chip_id = GameUtils.generateRandomChipID();
					chip = new ChipVO(chip_id, gridX, gridY);

					column.push(chip);
				}
				_grid.push(column);
			}

			this.dispatch(new GridRegionModelEvent(GridRegionModelEvent.ALL_NEW_CHIPS_GENERATED));
			// ++++++++++++ TEST TEST TEST TEST TEST ++++++++++++
			this.dispatch(new GridRegionModelEvent(GridRegionModelEvent.TEST_CHIPS_UPDATED));
			// ------------ TEST TEST TEST TEST TEST ------------
		}

		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		private function swapAndFindMatches(chip1:ChipVO, chip2:ChipVO):void
		{
			_currentChip = null;
			_swapChip1 = chip1;
			_swapChip2 = chip2;

			this.swapChips();
			this.lookForMatches();
			if(_matches.length == 0)
			{
				this.swapChips();
			}
			this.state = GridRegionStatesEnum.SWAP_CHIPS_STATE;
		}

		private function fillGridWithNewChips():void
		{
			var i:uint;
			var fallChipsLen:uint = _fallChips.length;
			var fallChip:FallChipVO;
			var chip:ChipVO;
			for(i = 0; i < fallChipsLen; i++)
			{
				fallChip = _fallChips[i];

				if(fallChip.startGridY >= 0)
				{
					_grid[fallChip.gridX][fallChip.startGridY] = null;
				}
				chip = new ChipVO(fallChip.id, fallChip.gridX, fallChip.finishGridY);
				_grid[fallChip.gridX][fallChip.finishGridY] = chip;
			}
		}

		private function clearRemovableChipsFromGrid():void
		{
			var removableChips:Vector.<ChipVO> = this.getRemovableChips();
			var chipsLen:uint = removableChips.length;

			var i:uint;
			var chip:ChipVO;
			for(i = 0; i < chipsLen; i++)
			{
				chip = removableChips[i];
				_grid[chip.gridX][chip.gridY] = null;
			}
		}

		private function createFallChips():void
		{
			// FALL CHIPS SHOULD BE CREATED ONLY AFTER CLEAR "REMOVABLE" CHIPS FROM GRID
			_fallChips = _fallLogic.createFallChips();
		}

		private function getRemovableChips():Vector.<ChipVO>
		{
			var removableChips:Vector.<ChipVO> = new <ChipVO>[];

			var i:uint;
			var j:uint;
			var matchesLen:uint = _matches.length;
			var chipsLen:uint;
			var match:MatchVO;
			var chip:ChipVO;
			for(i = 0; i < matchesLen; i++)
			{
				match = _matches[i];
				chipsLen = match.length;

				for(j = 0; j < chipsLen; j++)
				{
					chip = match.chips[j];
					removableChips.push(chip);
				}
			}
			return removableChips;
		}

		private function swapChips():void
		{
			var tempGridX:uint = _swapChip1.gridX;
			var tempGridY:uint = _swapChip1.gridY;

			_swapChip1.gridX = _swapChip2.gridX;
			_swapChip1.gridY = _swapChip2.gridY;
			_grid[_swapChip1.gridX][_swapChip1.gridY] = _swapChip1;

			_swapChip2.gridX = tempGridX;
			_swapChip2.gridY = tempGridY;
			_grid[_swapChip2.gridX][_swapChip2.gridY] = _swapChip2;
		}

		private function pickCurrentChip(chip:ChipVO):void
		{
			_currentChip = chip;
			this.dispatch(new GridRegionModelEvent(GridRegionModelEvent.CHIP_PICKED));
		}

		private function clearPreviousSwapData():void
		{
			if(_state == GridRegionStatesEnum.IDLE_STATE)
			{
				_swapChip1 = null;
				_swapChip2 = null;
				_fallChips = null;
			}
		}

		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		public function get state():String
		{
			return _state;
		}

		public function set state(value:String):void
		{
			_state = value;
			this.clearPreviousSwapData();

			this.dispatch(new GridRegionModelEvent(GridRegionModelEvent.STATE_CHANGED));
		}

		public function get grid():Vector.<Vector.<ChipVO>>
		{
			return _grid;
		}

		public function get currentChip():ChipVO
		{
			return _currentChip;
		}

		public function get swapChip1():ChipVO
		{
			return _swapChip1;
		}

		public function get swapChip2():ChipVO
		{
			return _swapChip2;
		}

		public function get matches():Vector.<MatchVO>
		{
			return _matches;
		}

		public function get fallChips():Vector.<FallChipVO>
		{
			return _fallChips;
		}

		//} endregion GETTERS/SETTERS ==================================================
	}
}