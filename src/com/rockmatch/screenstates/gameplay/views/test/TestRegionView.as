package com.rockmatch.screenstates.gameplay.views.test
{
	import com.rockmatch.AppSettings;
	import com.rockmatch.core.base.views.BaseView;

	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;


	/**
	 *
	 * @author dkoloskov
	 *
	 */
	public class TestRegionView extends BaseView
	{
		private var _tfLayer:Sprite;
		private var _backgroundLayer:Sprite;

		private var _grid:Vector.<Vector.<TextField>>;

		//==============================================================================
		//{region							PUBLIC METHODS
		public function TestRegionView()
		{
			this.mouseEnabled = false;
			this.mouseChildren = false;

			this.createLayers();
			this.createEmptyGrid();
		}

		override public function activate():void
		{

		}

		public function setChipID(id:int, gridX:int, gridY:int):void
		{
			var tf:TextField = _grid[gridX][gridY];
			tf.text = id.toString();

			var f:TextFormat = this.getTextFormat();
			tf.setTextFormat(f);
		}

		public function addGrid(grid:Sprite):void
		{
			grid.alpha = 0.3;
			_backgroundLayer.addChild(grid);
		}

		override public function destroy():void
		{
			super.destroy();

			_backgroundLayer = null;
			_tfLayer = null;

			_grid = null;
		}

		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		private function createEmptyGrid():void
		{
			_grid = new <Vector.<TextField>>[];

			var i:int;
			var j:int;
			var column:Vector.<TextField>;
			var tf:TextField;
			for(i = 0; i < AppSettings.GRID_WIDTH; i++)
			{
				column = new <TextField>[];
				for(j = 0; j < AppSettings.GRID_HEIGHT; j++)
				{
					tf = this.createTF();
					tf.x = i * AppSettings.GRID_TILE_SIZE + ((AppSettings.GRID_TILE_SIZE - tf.width) / 2);
					tf.y = j * AppSettings.GRID_TILE_SIZE + ((AppSettings.GRID_TILE_SIZE - tf.height) / 2);
					_tfLayer.addChild(tf);

					column.push(tf);
				}
				_grid.push(column);
			}
		}

		private function createTF():TextField
		{
			var tf:TextField = new TextField();
			tf.autoSize = TextFieldAutoSize.CENTER;
			tf.text = "0";
			tf.background = true;

			var f:TextFormat = this.getTextFormat();
			tf.setTextFormat(f);

			return tf;
		}

		private function getTextFormat():TextFormat
		{
			var f:TextFormat = new TextFormat(null, 24);
			return f;
		}

		private function createLayers():void
		{
			_backgroundLayer = new Sprite();
			_backgroundLayer.mouseEnabled = false;
			_backgroundLayer.mouseChildren = false;
			this.addChild(_backgroundLayer);

			_tfLayer = new Sprite();
			this.addChild(_tfLayer);
		}

		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							EVENTS HANDLERS
		//} endregion EVENTS HANDLERS ==================================================
	}
}