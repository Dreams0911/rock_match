package com.rockmatch.screenstates.gameplay.views
{
	import com.rockmatch.core.base.views.BaseView;
	import com.rockmatch.screenstates.gameplay.events.view.HudViewEvent;

	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.text.TextField;


	/**
	 *
	 * @author dkoloskov
	 *
	 */
	public class HudView extends BaseView
	{
		private var _score_tf:TextField;
		private var _shuffle_btn:SimpleButton;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function HudView()
		{

		}

		public function addResource(resource:MovieClip):void
		{
			_score_tf = resource["score_tf"];
			_shuffle_btn = resource["shuffle_btn"];

			this.addChild(resource);
			this.addListeners();
		}

		public function updateScore(score:uint):void
		{
			_score_tf.text = score.toString();
		}

		override public function destroy():void
		{
			super.destroy();
			_score_tf = null;
			_shuffle_btn = null;
		}

		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		override protected function addListeners():void
		{
			_shuffle_btn.addEventListener(MouseEvent.CLICK, shuffleClickHandler);
		}

		override protected function removeListeners():void
		{
			_shuffle_btn.removeEventListener(MouseEvent.CLICK, shuffleClickHandler)
		}

		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		private function shuffleClickHandler(event:MouseEvent):void
		{
			this.dispatchEvent(new HudViewEvent(HudViewEvent.SHUFFLE_CLICK));
		}

		//} endregion EVENTS HANDLERS ==================================================
	}
}
