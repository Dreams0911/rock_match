/**
 * User: dkoloskov
 * Date: 25.04.14
 * Time: 17:21
 */
package com.rockmatch.screenstates.gameplay.views.animator.animations
{
	import com.greensock.TweenLite;
	import com.rockmatch.AppSettings;
	import com.rockmatch.screenstates.gameplay.views.animator.animations.base.StatesAnimation;
	import com.rockmatch.screenstates.gameplay.views.components.ChipView;

	import flash.geom.Point;


	public class AbstractSwapChipsAnimation extends StatesAnimation
	{
		private var _chip1:ChipView;
		private var _chip2:ChipView;

		private var _swapSuccessful:Boolean;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function AbstractSwapChipsAnimation()
		{
			_statesAnimations = [this.playSwap];
		}

		override public function play():void
		{
			_statesAnimations[_currentState].call();
		}

		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		protected function playSwap():void
		{
			this.trackAnimations(2);

			var chip1Position:Point = new Point(_chip1.x, _chip1.y);
			var chip2Position:Point = new Point(_chip2.x, _chip2.y);
			TweenLite.to(_chip1, AppSettings.SWAP_SPEED, {x: chip2Position.x, y: chip2Position.y, onComplete: this.untrackAnimation});
			TweenLite.to(_chip2, AppSettings.SWAP_SPEED, {x: chip1Position.x, y: chip1Position.y, onComplete: this.untrackAnimation});
		}

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
				_onComplete(_chip1, _chip2, _swapSuccessful);
			}
		}

		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		override public function set params(value:Object):void
		{
			_params = value;
			_chip1 = _params["chip1"];
			_chip2 = _params["chip2"];
			_swapSuccessful = _params["swapSuccessful"];
		}
		//} endregion GETTERS/SETTERS ==================================================
	}
}
