/**
 * User: dkoloskov
 * Date: 25.04.14
 * Time: 17:21
 */
package com.rockmatch.screenstates.gameplay.views.animator.animations.swapchips
{
	import com.rockmatch.screenstates.gameplay.views.components.ChipView;


	public class SwapFailAnimation extends AbstractSwapChipsAnimation
	{
		private var _chip1:ChipView;
		private var _chip2:ChipView;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function SwapFailAnimation()
		{
			_statesAnimations = [this.playSwap, this.playSwapBack];
		}

		override public function play():void
		{
			_chip1 = _params["chip1"];
			_chip2 = _params["chip2"];

			_statesAnimations[_currentState].call();
		}

		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		private function playSwapBack():void
		{
			this.playSwap();
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
