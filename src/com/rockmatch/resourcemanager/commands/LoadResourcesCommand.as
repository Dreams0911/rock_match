package com.rockmatch.resourcemanager.commands
{
	import com.rockmatch.resourcemanager.models.IResourceManager;

	import robotlegs.bender.bundles.mvcs.Command;


	/**
	 * 
	 * @author dkoloskov
	 * 
	 */
	public class LoadResourcesCommand extends Command
	{
        [Inject]
        public var resourceManager:IResourceManager;
		
		//==============================================================================
		//{region							PUBLIC METHODS
		override public function execute():void
		{
            this.resourceManager.loadResources();
		}
		//} endregion PUBLIC METHODS ===================================================
	}
}