package com.rockmatch.screenstates.preloader.views
{
	import com.rockmatch.core.base.views.BaseView;

	import flash.display.MovieClip;
	import flash.text.TextField;


	/**
	 *
	 * @author dkoloskov
	 *
	 */
	public class PreloaderView extends BaseView
	{
		private var _percents_tf:TextField;

		//==============================================================================
		//{region							PUBLIC METHODS
		public function PreloaderView()
		{

		}

		public function addResource(resource:MovieClip):void
		{
			_percents_tf = resource["percents_tf"];

			this.addChild(resource);
		}

		public function updateProgress(progressPercent:int):void
		{
			_percents_tf.text = progressPercent.toString() + "%";
		}

		override public function destroy():void
		{
			_percents_tf = null;
			super.destroy();
		}

		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS

		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS

		//} endregion EVENTS HANDLERS ==================================================
	}
}