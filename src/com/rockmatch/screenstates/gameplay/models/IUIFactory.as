package com.rockmatch.screenstates.gameplay.models
{
	import com.rockmatch.screenstates.gameplay.views.components.ChipView;

	import flash.display.Sprite;


	/**
	 *
	 * @author dkoloskov
	 *
	 */
	public interface IUIFactory
	{
		//==============================================================================
		//{region							PUBLIC METHODS
		function createChipFrame():Sprite;

		function createChipView(id:int):ChipView;

		function createGrid():Sprite;

		function createBackground():Sprite;

		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region							GETTERS/SETTERS

		//} endregion GETTERS/SETTERS ==================================================
	}
}