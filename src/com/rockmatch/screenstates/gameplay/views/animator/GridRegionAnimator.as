/**
 * User: dkoloskov
 * Date: 25.04.14
 * Time: 17:03
 */
package com.rockmatch.screenstates.gameplay.views.animator
{
	import com.rockmatch.screenstates.gameplay.views.animator.animations.ChipsAnimationsEnum;
	import com.rockmatch.screenstates.gameplay.views.animator.animations.ExplodeChipsAnimation;
	import com.rockmatch.screenstates.gameplay.views.animator.animations.FallChipsAnimation;
	import com.rockmatch.screenstates.gameplay.views.animator.animations.swapchips.SwapFailAnimation;
	import com.rockmatch.screenstates.gameplay.views.animator.animations.swapchips.SwapSuccessfulAnimation;

	import flash.display.Stage;


	public class GridRegionAnimator extends Animator
	{
		//==============================================================================
		//{region							PUBLIC METHODS
		public function GridRegionAnimator(stage:Stage = null)
		{
			super(stage);
		}

		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		override protected function determineAnimations():void
		{
			_animationClasses = [];
			_animationClasses[ChipsAnimationsEnum.SWAP_CHIPS_SUCCESSFUL] = SwapSuccessfulAnimation;
			_animationClasses[ChipsAnimationsEnum.SWAP_CHIPS_FAIL] = SwapFailAnimation;
			_animationClasses[ChipsAnimationsEnum.EXPLODE_CHIPS] = ExplodeChipsAnimation;
			_animationClasses[ChipsAnimationsEnum.FALL_CHIPS] = FallChipsAnimation;
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
