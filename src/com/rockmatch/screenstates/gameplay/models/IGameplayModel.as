package com.rockmatch.screenstates.gameplay.models
{
	/**
	 *
	 * @author dkoloskov
	 *
	 */
	public interface IGameplayModel
	{
		//==============================================================================
		//{region							PUBLIC METHODS
		function reset():void


		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		function get score():uint

		function set score(value:uint):void

		//} endregion GETTERS/SETTERS ==================================================
	}
}