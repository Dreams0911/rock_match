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
	import com.rockmatch.screenstates.gameplay.views.components.ChipViewFallWrap;


	public class FallChipsAnimation extends AbstractAnimation
	{
		private var _chipsFallWraps:Vector.<ChipViewFallWrap>;
		private var _fallenChipsFallWraps:Vector.<ChipViewFallWrap>;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function FallChipsAnimation()
		{

		}

		override public function play():void
		{
			var animationStarted:Boolean = false;

			var i:uint;
			var chipsLen:uint = _chipsFallWraps.length;
			var chipFallWrap:ChipViewFallWrap;
			for(i = 0; i < chipsLen; i++)
			{
				chipFallWrap = _chipsFallWraps[i];

				if(chipFallWrap.view.gridY >= 0)
				{
					animationStarted = true;
					this.playChipFall(chipFallWrap);
				}
				else if(chipFallWrap.view.gridY == -1)
				{
					animationStarted = true;
					this.playChipShowAndFall(chipFallWrap);
				}
				else if(chipFallWrap.view.gridY < -1)
				{
					this.moveWithoutAnimation(chipFallWrap);
				}
			}

			if(!animationStarted)
			{
				this.play();
			}
		}

		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		private function playChipFall(chipFallWrap:ChipViewFallWrap):void
		{
			this.trackAnimation();
			var newGridY:Number = chipFallWrap.view.y + AppSettings.GRID_TILE_SIZE;
			TweenLite.to(chipFallWrap.view, AppSettings.FALL_SPEED, {y: newGridY, onCompleteParams: [chipFallWrap], onComplete: this.chipFallCompleteHandler});
		}

		private function playChipShowAndFall(chipFallWrap:ChipViewFallWrap):void
		{
			this.trackAnimation();

			chipFallWrap.view.scaleX = 0;
			chipFallWrap.view.scaleY = 0;
			chipFallWrap.view.visible = true;

			var newGridY:Number = chipFallWrap.view.y + AppSettings.GRID_TILE_SIZE;
			TweenLite.to(chipFallWrap.view, AppSettings.FALL_SPEED, {y: newGridY, scaleX: 1, scaleY: 1, onCompleteParams: [chipFallWrap], onComplete: this.chipFallCompleteHandler});
		}

		private function moveWithoutAnimation(chipFallWrap:ChipViewFallWrap):void
		{
			chipFallWrap.view.gridY++;
			chipFallWrap.view.y += AppSettings.GRID_TILE_SIZE;
		}

		override protected function onAnimationComplete():void
		{
			if(_chipsFallWraps.length > 0)
			{
				this.play();
				return;
			}

			if(_onComplete != null)
			{
				_onComplete(_fallenChipsFallWraps);
			}
		}

		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		private function chipFallCompleteHandler(chipFallWrap:ChipViewFallWrap):void
		{
			chipFallWrap.view.gridY++;
			if(chipFallWrap.fallDistance == 0)
			{
				this.removeChipFallWrap(chipFallWrap);
			}

			this.untrackAnimation();
		}

		private function removeChipFallWrap(chipFallWrap:ChipViewFallWrap):void
		{
			var index:int = _chipsFallWraps.indexOf(chipFallWrap);
			_chipsFallWraps.splice(index, 1);

			_fallenChipsFallWraps.push(chipFallWrap);
		}

		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		override public function set params(value:Object):void
		{
			_params = value;
			_chipsFallWraps = _params["chipsFallWraps"];
			_fallenChipsFallWraps = new <ChipViewFallWrap>[];
		}

		//} endregion GETTERS/SETTERS ==================================================
	}
}
