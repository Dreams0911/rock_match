package com.rockmatch.resourcemanager.models
{
	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.BulkProgressEvent;

	import com.rockmatch.AppSettings;

	import com.rockmatch.core.base.models.BaseActor;
	import com.rockmatch.resourcemanager.events.ResourceManagerEvent;
	import com.rockmatch.root.events.ScreenStateEvent;
	import com.rockmatch.root.model.ScreenStatesEnum;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.system.ApplicationDomain;


	/**
	 *
	 * @author dkoloskov
	 *
	 */
	public class ResourceManager extends BaseActor implements IResourceManager
	{
		private var _bulkLoader:BulkLoader;

		//==============================================================================
		//{region							PUBLIC METHODS
		public function ResourceManager()
		{

		}

		public function loadResources():void
		{
			_bulkLoader = new BulkLoader();

			// add preloader to loading stack
			var preloaderUrl:String = AppSettings.RESOURCES_PATH + AppSettings.PRELOADER_FILE_NAME;
			_bulkLoader.add(preloaderUrl);

			// add all the rest resources to loading stack
			var resources:Vector.<String> = AppSettings.RESOURCE_FILES_NAMES_STACK;
			var resourceUrl:String;
			var i:uint;
			var resourcesLen:uint = resources.length;
			for(i = 0; i < resourcesLen; i++)
			{
				resourceUrl = AppSettings.RESOURCES_PATH + resources[i];
				_bulkLoader.add(resourceUrl);
			}

			// this will fire once all items have been loaded
			_bulkLoader.addEventListener(BulkLoader.COMPLETE, this.loadCompleteHandler);

			// this will fire on progress for any item
			// the event , BulkProgress is a subclass of ProgressEvent (with extra information)
			_bulkLoader.addEventListener(BulkLoader.PROGRESS, this.loadProgressHandler);

			// this will fire if any item fails to load:
			// the event is BulkErrorEvent and holds an array (errors) with all failed LoadingItem instances
			_bulkLoader.addEventListener(BulkLoader.ERROR, this.loadErrorHandler);

			// this will fire as soon as the item preloaderUrl is done loading (even if there are other items to load)
			_bulkLoader.get(preloaderUrl).addEventListener(Event.COMPLETE, this.preloaderLoadCompleteHandler);

			_bulkLoader.start();
		}

		public function getMC(mcName:String):MovieClip
		{
			var mcClass:Class = this.getResourceClass(mcName);
			if(mcClass == null)
			{
				return null;
			}

			var mc:MovieClip = new mcClass();
			return mc;
		}

		public function getButton(btnName:String):SimpleButton
		{
			var btnClass:Class = this.getResourceClass(btnName);
			if(btnClass == null)
			{
				return null;
			}

			var btn:SimpleButton = new btnClass();
			return btn;
		}

		public function getBitmap(bName:String):Bitmap
		{
			var b:Bitmap = _bulkLoader.getBitmap(AppSettings.RESOURCES_PATH + bName);
			var bData:BitmapData = new BitmapData(b.width, b.height, true, 0x000000);
			bData.draw(b);

			var bCopy:Bitmap = new Bitmap(bData);
			return bCopy;
		}

		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		private function getResourceClass(resName:String):Class
		{
			var appDomain:ApplicationDomain;
			var resClass:Class;

			var i:uint;
			var resourcesLength:uint = _bulkLoader.items.length;
			for(i = 0; i < resourcesLength; i++)
			{
				appDomain = _bulkLoader.items[i]["loader"]["contentLoaderInfo"]["applicationDomain"];
				if(appDomain.hasDefinition(resName))
				{
					resClass = appDomain.getDefinition(resName) as Class;
					break;
				}
			}

			return resClass;
		}

		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS		
		private function loadCompleteHandler(event:BulkProgressEvent):void
		{
			_bulkLoader.removeEventListener(BulkLoader.COMPLETE, this.loadCompleteHandler);
			_bulkLoader.removeEventListener(BulkLoader.PROGRESS, this.loadProgressHandler);
			_bulkLoader.removeEventListener(BulkLoader.ERROR, this.loadErrorHandler);

			this.dispatch(new ResourceManagerEvent(ResourceManagerEvent.LOAD_COMPLETED));
		}

		private function preloaderLoadCompleteHandler(event:Event):void
		{
			var preloaderUrl:String = event.currentTarget["url"]["url"];
			_bulkLoader.get(preloaderUrl).removeEventListener(Event.COMPLETE, this.preloaderLoadCompleteHandler);

			this.dispatch(new ScreenStateEvent(ScreenStateEvent.SET_SCREEN_STATE, ScreenStatesEnum.PRELOADER));
		}

		private function loadProgressHandler(event:BulkProgressEvent):void
		{
			var progressPercent:int = int(event.percentLoaded * 100);
			this.dispatch(new ResourceManagerEvent(ResourceManagerEvent.PROGRESS, progressPercent));
		}

		private function loadErrorHandler(event:* = null):void
		{
			trace("=========> LOADING ERROR!!!");
			trace(event);
		}

		//} endregion EVENTS HANDLERS ==================================================
	}
}