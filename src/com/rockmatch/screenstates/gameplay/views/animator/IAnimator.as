/**
 * User: dkoloskov
 * Date: 25.04.14
 * Time: 17:02
 */
package com.rockmatch.screenstates.gameplay.views.animator
{
	public interface IAnimator
	{
		//==============================================================================
		//{region							METHODS
		function playAnimation(animationType:String, params:Object = null, onComplete:Function = null):void
		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		//} endregion GETTERS/SETTERS ==================================================
	}
}
