package com.rockmatch.core.bootstraps
{
	import com.rockmatch.AppSettings;
	import com.rockmatch.root.mediators.RootViewMediator;
	import com.rockmatch.root.views.RootView;
	import com.rockmatch.screenstates.gameplay.mediators.GameplayViewMediator;
	import com.rockmatch.screenstates.gameplay.mediators.GridRegionViewMediator;
	import com.rockmatch.screenstates.gameplay.mediators.HudViewMediator;
	import com.rockmatch.screenstates.gameplay.mediators.test.TestRegionViewMediator;
	import com.rockmatch.screenstates.gameplay.views.GameplayView;
	import com.rockmatch.screenstates.gameplay.views.GridRegionView;
	import com.rockmatch.screenstates.gameplay.views.HudView;
	import com.rockmatch.screenstates.gameplay.views.test.TestRegionView;
	import com.rockmatch.screenstates.mainmenu.mediators.MainMenuViewMediator;
	import com.rockmatch.screenstates.mainmenu.views.MainMenuView;
	import com.rockmatch.screenstates.preloader.mediators.PreloaderViewMediator;
	import com.rockmatch.screenstates.preloader.views.PreloaderView;

	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;


	/**
	 *
	 * @author dkoloskov
	 *
	 */
	public class BootstrapViewMediators extends Object
	{
		//==============================================================================
		//{region							PUBLIC METHODS
		public function BootstrapViewMediators(mediatorMap:IMediatorMap)
		{
			mediatorMap.map(RootView).toMediator(RootViewMediator);
			mediatorMap.map(PreloaderView).toMediator(PreloaderViewMediator);
			mediatorMap.map(MainMenuView).toMediator(MainMenuViewMediator);

			mediatorMap.map(GameplayView).toMediator(GameplayViewMediator);
			mediatorMap.map(GridRegionView).toMediator(GridRegionViewMediator);
			// ++++++++++++ TEST TEST TEST TEST TEST ++++++++++++
			if(AppSettings.TEST_SHOW_IDS)
			{
				mediatorMap.map(TestRegionView).toMediator(TestRegionViewMediator);
			}
			// ------------ TEST TEST TEST TEST TEST ------------
			mediatorMap.map(HudView).toMediator(HudViewMediator);
			//mediatorMap.map(ScoreView).toMediator(ScoreViewMediator);

			//STARLING
			//...
		}

		//} endregion PUBLIC METHODS ===================================================
	}
}