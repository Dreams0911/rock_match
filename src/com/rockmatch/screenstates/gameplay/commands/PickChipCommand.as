package com.rockmatch.screenstates.gameplay.commands
{
	import com.rockmatch.screenstates.gameplay.events.GridRegionEvent;
	import com.rockmatch.screenstates.gameplay.models.gridregion.GridRegionStatesEnum;
	import com.rockmatch.screenstates.gameplay.models.gridregion.IGridRegionModel;

	import robotlegs.bender.bundles.mvcs.Command;


	/**
	 *
	 * @author dkoloskov
	 *
	 */
	public class PickChipCommand extends Command
	{
		[Inject]
		public var event:GridRegionEvent;

		[Inject]
		public var gridRegionModel:IGridRegionModel;

		//==============================================================================
		//{region							PUBLIC METHODS
		override public function execute():void
		{
			if(gridRegionModel.state != GridRegionStatesEnum.IDLE_STATE)
			{
				return;
			}

			var gridX:int = event.body["gridX"];
			var gridY:int = event.body["gridY"];
			this.gridRegionModel.pickChipValidation(gridX, gridY);
		}

		//} endregion PUBLIC METHODS ===================================================
	}
}
