/**
 * User: dkoloskov
 * Date: 25.04.14
 * Time: 17:21
 */
package com.rockmatch.screenstates.gameplay.views.animator.animations.base
{
	public class AbstractAnimation implements IAnimation
	{
		private var _trackedAnimationsCounter:uint = 0;

		//SETTABLE PARAMETERS
		protected var _params:Object;
		protected var _onComplete:Function;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function AbstractAnimation()
		{
		}

		public function play():void
		{

		}

		public function stop():void
		{
		}

		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		protected function trackAnimation():void
		{
			_trackedAnimationsCounter++;
		}

		protected function trackAnimations(animationsQuantity:uint):void
		{
			_trackedAnimationsCounter += animationsQuantity;
		}

		protected function untrackAnimation():void
		{
			_trackedAnimationsCounter--;
			if(_trackedAnimationsCounter == 0)
			{
				this.onAnimationComplete();
			}
		}

		protected function onAnimationComplete():void
		{
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
		public function set params(value:Object):void
		{
			_params = value;
		}

		public function set onComplete(value:Function):void
		{
			_onComplete = value;
		}

		//} endregion GETTERS/SETTERS ==================================================
	}
}
