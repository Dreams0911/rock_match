package com.rockmatch.screenstates.gameplay.models
{
	import com.rockmatch.core.base.models.BaseActor;
	import com.rockmatch.screenstates.gameplay.events.model.GameplayModelEvent;


	/**
	 *
	 * @author dkoloskov
	 *
	 */
	public class GameplayModel extends BaseActor implements IGameplayModel
	{
		private var _score:uint;

		//==============================================================================
		//{region							PUBLIC METHODS
		public function GameplayModel()
		{

		}

		public function reset():void
		{
			_score = 0;
			this.dispatch(new GameplayModelEvent(GameplayModelEvent.INFO_UPDATED));
		}

		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS

		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							GETTERS/SETTERS
		public function get score():uint
		{
			return _score;
		}

		public function set score(value:uint):void
		{
			_score = value;
			this.dispatch(new GameplayModelEvent(GameplayModelEvent.INFO_UPDATED));
		}

		//} endregion GETTERS/SETTERS ==================================================
	}
}