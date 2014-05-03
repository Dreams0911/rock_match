/**
 * User: dkoloskov
 * Date: 25.04.14
 * Time: 17:21
 */
package com.rockmatch.screenstates.gameplay.views.animator.animations.base
{
	public class StatesAnimation extends AbstractAnimation
	{
		protected var _statesAnimations:Array;
		protected var _currentState:uint = 0;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function StatesAnimation()
		{
		}

		override public function play():void
		{
			_statesAnimations[_currentState].call();
		}

		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		override protected function onAnimationComplete():void
		{
			if(_currentState < _statesAnimations.length - 1)
			{
				_currentState++;
				this.play();
				return;
			}

			if(_onComplete != null)
			{
				_onComplete();
			}
		}

		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		//} endregion GETTERS/SETTERS ==================================================
	}
}
