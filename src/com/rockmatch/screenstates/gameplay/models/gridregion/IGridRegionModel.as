package com.rockmatch.screenstates.gameplay.models.gridregion
{
	import com.rockmatch.screenstates.gameplay.models.fallLogic.vo.FallChipVO;
	import com.rockmatch.screenstates.gameplay.models.gridregion.vo.ChipVO;
	import com.rockmatch.screenstates.gameplay.models.matchlogic.vo.MatchVO;


	/**
	 *
	 * @author dkoloskov
	 *
	 */
	public interface IGridRegionModel
	{
		//==============================================================================
		//{region							PUBLIC METHODS
		function lookForMatches():void

		function pickChipValidation(gridX:int, gridY:int):void

		function removeMatch(match_id:uint):void

		function generateAllNewChips():void


		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		function get state():String

		function set state(value:String):void

		function get grid():Vector.<Vector.<ChipVO>>

		function get currentChip():ChipVO

		function get swapChip1():ChipVO;

		function get swapChip2():ChipVO;

		function get matches():Vector.<MatchVO>;

		function get fallChips():Vector.<FallChipVO>

		//} endregion GETTERS/SETTERS ==================================================
	}
}