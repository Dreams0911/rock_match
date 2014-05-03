package com.rockmatch.screenstates.gameplay.commands
{
	import com.rockmatch.screenstates.gameplay.models.gridregion.GridRegionStatesEnum;
	import com.rockmatch.screenstates.gameplay.models.gridregion.IGridRegionModel;

	import robotlegs.bender.bundles.mvcs.Command;


	/**
	 *
	 * @author dkoloskov
	 *
	 */
	public class GenerateAllNewChipsCommand extends Command
	{
		[Inject]
		public var gridRegionModel:IGridRegionModel;

		//==============================================================================
		//{region							PUBLIC METHODS
		override public function execute():void
		{
			if(gridRegionModel.state == GridRegionStatesEnum.IDLE_STATE)
			{
				this.gridRegionModel.generateAllNewChips();
			}
		}

		//} endregion PUBLIC METHODS ===================================================
	}
}
