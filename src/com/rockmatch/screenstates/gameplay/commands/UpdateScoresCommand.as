package com.rockmatch.screenstates.gameplay.commands
{
	import com.rockmatch.screenstates.gameplay.events.GameplayEvent;
	import com.rockmatch.screenstates.gameplay.models.gridregion.IGridRegionModel;

	import robotlegs.bender.bundles.mvcs.Command;


	/**
	 *
	 * @author dkoloskov
	 *
	 */
	public class UpdateScoresCommand extends Command
	{
		[Inject]
		public var event:GameplayEvent;

		[Inject]
		public var gridRegionModel:IGridRegionModel;

		//==============================================================================
		//{region							PUBLIC METHODS
		override public function execute():void
		{
			/* var objectType:uint = event.body["objectType"];
			 var asteroidType:uint = event.body["asteroidType"];
			 var scoreToAdd:int = this.objectsScoresModel.getObjectScores(objectType, asteroidType);

			 this.gameplayModel.score += scoreToAdd;*/
		}

		//} endregion PUBLIC METHODS ===================================================
	}
}
