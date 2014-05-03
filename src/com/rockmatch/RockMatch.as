package com.rockmatch
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;

	import robotlegs.bender.bundles.mvcs.MVCSBundle;
	import robotlegs.bender.extensions.contextView.ContextView;

	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.impl.Context;


	[SWF(frameRate="30", width="1280", height="720", backgroundColor="0x000000")]
	public class RockMatch extends Sprite
	{
		private var _context:IContext;

		//==============================================================================
		//{region							PUBLIC METHODS
		public function RockMatch()
		{
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.stage.align = StageAlign.TOP_LEFT;
			this.focusRect = false;

			_context = new Context();
			_context.install(MVCSBundle);
			_context.configure(AppConfig);
			_context.configure(new ContextView(this));
		}

		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		//} endregion EVENTS HANDLERS ==================================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		//} endregion GETTERS/SETTERS ==================================================
	}
}