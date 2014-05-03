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
	public class ExplodeChipsCompleteCommand extends Command
	{
		[Inject]
		public var event:GridRegionEvent;

		[Inject]
		public var gridRegionModel:IGridRegionModel;

		//==============================================================================
		//{region							PUBLIC METHODS
		override public function execute():void
		{
			var match_id:uint = event.body;
			this.gridRegionModel.removeMatch(match_id);

			if(this.gridRegionModel.matches.length == 0)
			{
				this.gridRegionModel.state = GridRegionStatesEnum.FALL_CHIPS_STATE;;
			}
		}

		//} endregion PUBLIC METHODS ===================================================
	}
}
