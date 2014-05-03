package com.rockmatch
{
	import com.rockmatch.core.bootstraps.BootstrapCommands;
	import com.rockmatch.core.bootstraps.BootstrapModels;
	import com.rockmatch.core.bootstraps.BootstrapServices;
	import com.rockmatch.core.bootstraps.BootstrapViewMediators;
	import com.rockmatch.resourcemanager.events.ResourceManagerEvent;
	import com.rockmatch.root.views.RootView;

	import flash.events.IEventDispatcher;

	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.framework.api.IConfig;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.IInjector;


	/**
	 *
	 * @author dkoloskov
	 *
	 */
	public class AppConfig implements IConfig
	{
		[Inject]
		public var context:IContext;

		[Inject]
		public var injector:IInjector;

		[Inject]
		public var mediatorMap:IMediatorMap;

		[Inject]
		public var commandMap:IEventCommandMap;

		[Inject]
		public var evenDispatcher:IEventDispatcher;

		[Inject]
		public var contextView:ContextView;

		//==============================================================================
		//{region							PUBLIC METHODS
		public function configure():void
		{
			this.context.afterInitializing(this.init);

			this.mapModels();
			this.mapServices();
			this.mapViews();
			this.mapCommands();
		}

		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		private function init():void
		{
			var rootView:RootView = new RootView();
			this.contextView.view.addChild(rootView);

			this.evenDispatcher.dispatchEvent(new ResourceManagerEvent(ResourceManagerEvent.LOAD));
		}

		private function mapModels():void
		{
			new BootstrapModels(this.injector);
		}

		private function mapServices():void
		{
			new BootstrapServices(this.injector);
		}

		private function mapViews():void
		{
			new BootstrapViewMediators(this.mediatorMap);
		}

		private function mapCommands():void
		{
			new BootstrapCommands(this.commandMap);
		}

		//} endregion PRIVATE\PROTECTED METHODS ========================================
	}
}