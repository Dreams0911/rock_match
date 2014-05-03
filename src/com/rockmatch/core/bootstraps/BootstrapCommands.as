package com.rockmatch.core.bootstraps
{
	import com.rockmatch.resourcemanager.commands.LoadResourcesCommand;
	import com.rockmatch.resourcemanager.events.ResourceManagerEvent;
	import com.rockmatch.root.commands.setscreenstate.SetScreenStateCommand;
	import com.rockmatch.root.events.ScreenStateEvent;
	import com.rockmatch.screenstates.gameplay.commands.ExplodeChipsCompleteCommand;
	import com.rockmatch.screenstates.gameplay.commands.FallChipsCompleteCommand;
	import com.rockmatch.screenstates.gameplay.commands.GenerateAllNewChipsCommand;
	import com.rockmatch.screenstates.gameplay.commands.PickChipCommand;
	import com.rockmatch.screenstates.gameplay.commands.SwapChipsCompleteCommand;
	import com.rockmatch.screenstates.gameplay.commands.UpdateScoresCommand;
	import com.rockmatch.screenstates.gameplay.events.GameplayEvent;
	import com.rockmatch.screenstates.gameplay.events.GridRegionEvent;

	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;


	/**
	 *
	 * @author dkoloskov
	 *
	 */
	public class BootstrapCommands
	{
		//==============================================================================
		//{region							PUBLIC METHODS
		public function BootstrapCommands(commandMap:IEventCommandMap)
		{
			commandMap.map(ResourceManagerEvent.LOAD).toCommand(LoadResourcesCommand);
			commandMap.map(ScreenStateEvent.SET_SCREEN_STATE).toCommand(SetScreenStateCommand);

			// GAMEPLAY STATE
			// ++++++++++++++++++++++
			// GAMEPLAY
			commandMap.map(GameplayEvent.UPDATE_SCORES).toCommand(UpdateScoresCommand);

			// GRID REGION
			commandMap.map(GridRegionEvent.GENERATE_ALL_NEW_CHIPS).toCommand(GenerateAllNewChipsCommand);

			commandMap.map(GridRegionEvent.PICK_CHIP).toCommand(PickChipCommand);
			commandMap.map(GridRegionEvent.SWAP_COMPLETE).toCommand(SwapChipsCompleteCommand);
			commandMap.map(GridRegionEvent.EXPLOSION_COMPLETE).toCommand(ExplodeChipsCompleteCommand);
			commandMap.map(GridRegionEvent.FALL_CHIPS_COMPLETE).toCommand(FallChipsCompleteCommand);
			// ++++++++++++++++++++++
		}

		//} endregion PUBLIC METHODS ===================================================
	}
}