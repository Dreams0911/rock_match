package com.rockmatch
{
	/**
	 *
	 * @author dkoloskov
	 *
	 */
	public class AppSettings
	{
		public static const RESOURCES_PATH:String = "res/";
		public static const PRELOADER_FILE_NAME:String = "preloader.swf";
		public static const RESOURCE_FILES_NAMES_STACK:Vector.<String> = new <String>[
			"resources.swf", "chip_1.png", "chip_2.png", "chip_3.png", "chip_4.png", "chip_5.png", "chip_6.png"];

		public static const GRID_WIDTH:uint = 8;
		public static const GRID_HEIGHT:uint = 8;
		public static const GRID_TILE_SIZE:uint = 65;

		public static const SWAP_SPEED:Number = 0.4;
		public static const EXPLODE_SPEED:Number = 0.25;
		public static const FALL_SPEED:Number = 0.5;

		// TESTING SETTINGS
		public static const TEST_SHOW_IDS:Boolean = false;
	}
}