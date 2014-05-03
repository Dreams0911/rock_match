package com.rockmatch.core.bootstraps
{
	import com.rockmatch.resourcemanager.models.IResourceManager;
	import com.rockmatch.resourcemanager.models.ResourceManager;
	import com.rockmatch.root.model.IScreenStateModel;
	import com.rockmatch.root.model.ScreenStateModel;
	import com.rockmatch.screenstates.gameplay.models.GameplayModel;
	import com.rockmatch.screenstates.gameplay.models.IGameplayModel;
	import com.rockmatch.screenstates.gameplay.models.IUIFactory;
	import com.rockmatch.screenstates.gameplay.models.UIFactory;
	import com.rockmatch.screenstates.gameplay.models.gridregion.GridRegionModel;
	import com.rockmatch.screenstates.gameplay.models.gridregion.IGridRegionModel;

	import robotlegs.bender.framework.api.IInjector;


	/**
	 *
	 * @author dkoloskov
	 *
	 */
	public class BootstrapModels
	{
		//==============================================================================
		//{region							PUBLIC METHODS
		public function BootstrapModels(injector:IInjector)
		{
			injector.map(IResourceManager).toSingleton(ResourceManager);
			injector.map(IScreenStateModel).toSingleton(ScreenStateModel);

			injector.map(IGameplayModel).toSingleton(GameplayModel);
			injector.map(IGridRegionModel).toSingleton(GridRegionModel);
			injector.map(IUIFactory).toSingleton(UIFactory);
		}

		//} endregion PUBLIC METHODS ===================================================
	}
}