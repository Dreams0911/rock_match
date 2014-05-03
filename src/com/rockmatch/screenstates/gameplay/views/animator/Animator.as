/**
 * User: dkoloskov
 * Date: 25.04.14
 * Time: 17:03
 */
package com.rockmatch.screenstates.gameplay.views.animator
{
	import com.rockmatch.screenstates.gameplay.views.animator.animations.base.IAnimation;

	import flash.display.Stage;


	public class Animator implements IAnimator
	{
		protected var _stage:Stage;
		protected var _animationClasses:Array;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function Animator(stage:Stage = null)
		{
			_stage = stage;
			this.determineAnimations();
		}

		public function playAnimation(animationType:String, params:Object = null, onComplete:Function = null):void
		{
			if(_animationClasses[animationType] == null)
			{
				trace("---> No such animation as - " + animationType);
				return;
			}

			var animationClass:Class = _animationClasses[animationType];
			var animation:IAnimation = new animationClass;
			animation.params = params;
			animation.onComplete = onComplete;
			animation.play();
		}

		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		protected function determineAnimations():void
		{
			_animationClasses = [];
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
