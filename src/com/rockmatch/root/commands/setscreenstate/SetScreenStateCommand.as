package com.rockmatch.root.commands.setscreenstate
{
	import com.rockmatch.root.events.ScreenStateEvent;
	import com.rockmatch.root.model.IScreenStateModel;

	import robotlegs.bender.bundles.mvcs.Command;


	/**
	 *
	 * @author dkoloskov
	 *
	 */
	public class SetScreenStateCommand extends Command
	{
		[Inject]
		public var event:ScreenStateEvent;

		[Inject]
		public var screenStateModel:IScreenStateModel;

		//==============================================================================
		//{region							PUBLIC METHODS
		override public function execute():void
		{
			var state:String = event.body;
			this.screenStateModel.screenState = state;
		}

		//} endregion PUBLIC METHODS ===================================================
	}
}
