package com.rockmatch.root.model
{
	import com.rockmatch.core.base.models.BaseActor;
	import com.rockmatch.root.events.ScreenStateEvent;
	import com.rockmatch.screenstates.gameplay.views.GameplayView;
	import com.rockmatch.screenstates.mainmenu.views.MainMenuView;
	import com.rockmatch.screenstates.preloader.views.PreloaderView;

	import flash.utils.Dictionary;


	/**
	 *
	 * @author dkoloskov
	 *
	 */
	public class ScreenStateModel extends BaseActor implements IScreenStateModel
	{
		private var _screenStates:Dictionary;
		private var _starlingScreenStates:Dictionary;

		private var _screenState:String;
		//==============================================================================
		//{region							PUBLIC METHODS
		public function ScreenStateModel()
		{
			this.initScreenStates();
		}

		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		private function initScreenStates():void
		{
			_screenStates = new Dictionary();
			_screenStates[ScreenStatesEnum.PRELOADER] = PreloaderView;
			_screenStates[ScreenStatesEnum.MAIN_MENU] = MainMenuView;
			_screenStates[ScreenStatesEnum.GAMEPLAY] = GameplayView;
			//_screenStates[ScreenStatesEnum.SCORE] = ScoreView;

			//_starlingScreenStates = new Dictionary();
		}

		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		public function set screenState(value:String):void
		{
			_screenState = value;
			this.dispatch(new ScreenStateEvent(ScreenStateEvent.SCREEN_STATE_CHANGED));
		}

		public function get screenStateClass():Class
		{
			return _screenStates[_screenState];
		}

		public function get starlingScreenStateClass():Class
		{
			return _starlingScreenStates[_screenState];
		}

		//} endregion GETTERS/SETTERS ==================================================
	}
}