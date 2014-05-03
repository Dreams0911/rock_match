package com.rockmatch.root.model
{
    /**
	 * 
	 * @author dkoloskov
	 * 
	 */	
	public interface IScreenStateModel
	{
		//==============================================================================
		//{region							GETTERS/SETTERS
		function set screenState(value:String):void

        /**
         * Get view class for current screen state
        * */
        function get screenStateClass():Class

        /**
         * Get starling view class for current screen state
         * */
        function get starlingScreenStateClass():Class
		//} endregion GETTERS/SETTERS ==================================================
	}
}