/**
 * User: dkoloskov
 * Date: 25.04.14
 * Time: 17:13
 */
package com.rockmatch.screenstates.gameplay.views.animator.animations.base
{
	public interface IAnimation
	{
		//==============================================================================
		//{region							METHODS
		function play():void

		function stop():void

		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		function set params(value:Object):void

		function set onComplete(value:Function):void

		//} endregion GETTERS/SETTERS ==================================================
	}
}
