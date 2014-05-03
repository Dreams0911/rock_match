package com.rockmatch.utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;


	/**
	 *
	 * @author dkoloskov
	 *
	 */
	public class Utils
	{
		//==============================================================================
		//{region							PUBLIC METHODS
		static public function randomNumber(min:Number, max:Number):Number
		{
			return Math.floor(Math.random() * (max - min + 1)) + min;
		}

		public static function hypotenuse(cat1:Number, cat2:Number):Number
		{
			return Math.sqrt((cat1 * cat1) + (cat2 * cat2));
		}

		public static function displayObjectToBitmap(displayObject:DisplayObject):Bitmap
		{
			var bData:BitmapData = new BitmapData(displayObject.width, displayObject.height, true, 0x000000);
			bData.draw(displayObject);

			var b:Bitmap = new Bitmap(bData);
			return b;
		}

		//} endregion PUBLIC METHODS ===================================================
	}
}