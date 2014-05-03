package com.rockmatch.resourcemanager.models
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;


	/**
	 *
	 * @author dkoloskov
	 *
	 */
	public interface IResourceManager
	{
		//==============================================================================
		//{region							PUBLIC METHODS
		function loadResources():void

		/**
		 * Get MovieClip by mcName
		 * */
		function getMC(mcName:String):MovieClip

		/**
		 * Get Bitmap of image(PNG/JPG etc)
		 * */
		function getBitmap(bName:String):Bitmap

		/**
		 * Get SimpleButton by btnName
		 * */
		function getButton(btnName:String):SimpleButton

		//} endregion PUBLIC METHODS ===================================================
	}
}