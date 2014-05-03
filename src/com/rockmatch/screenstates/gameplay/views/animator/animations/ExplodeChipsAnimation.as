/**
 * User: dkoloskov
 * Date: 25.04.14
 * Time: 17:21
 */
package com.rockmatch.screenstates.gameplay.views.animator.animations
{
	import com.greensock.TweenLite;
	import com.rockmatch.AppSettings;
	import com.rockmatch.screenstates.gameplay.views.animator.animations.base.AbstractAnimation;
	import com.rockmatch.screenstates.gameplay.views.components.ChipView;


	public class ExplodeChipsAnimation extends AbstractAnimation
	{
		private var _chips:Vector.<ChipView>;
		private var _match_id:uint;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function ExplodeChipsAnimation()
		{

		}

		override public function play():void
		{
			var chipsLen:uint = _chips.length;
			this.trackAnimations(chipsLen);

			var i:uint;
			var chip:ChipView;
			for(i = 0; i < chipsLen; i++)
			{
				chip = _chips[i];
				TweenLite.to(chip, AppSettings.EXPLODE_SPEED, {scaleX: 0, scaleY: 0, onComplete: this.untrackAnimation});
			}
		}

		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		override protected function onAnimationComplete():void
		{
			if(_onComplete != null)
			{
				_onComplete(_chips, _match_id);
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
			_chips = _params["chips"];
			_match_id = _params["match_id"];
		}

		//} endregion GETTERS/SETTERS ==================================================
	}
}
