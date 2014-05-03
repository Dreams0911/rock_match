package com.rockmatch.screenstates.gameplay.models
{
	import com.rockmatch.AppSettings;
	import com.rockmatch.core.base.models.BaseActor;
	import com.rockmatch.resourcemanager.models.IResourceManager;
	import com.rockmatch.screenstates.gameplay.views.components.ChipView;

	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	import robotlegs.bender.extensions.contextView.ContextView;


	/**
	 *
	 * @author dkoloskov
	 *
	 */
	public class UIFactory extends BaseActor implements IUIFactory
	{
		private const CHIP_RESOURCE_NAME:String = "chip_";

		[Inject]
		public var resourceManager:IResourceManager;

		[Inject]
		public var contextView:ContextView;

		//==============================================================================
		//{region							PUBLIC METHODS
		public function UIFactory()
		{

		}

		public function createChipFrame():Sprite
		{
			var chipFrame:Sprite = this.drawChipFrame();
			return chipFrame;
		}

		public function createBackground():Sprite
		{
			var background:Sprite = this.drawBackground();
			return background;
		}

		public function createGrid():Sprite
		{
			var grid:Sprite = this.drawGrid();
			return grid;
		}

		public function createChipView(id:int):ChipView
		{
			var chipGraphicsContainer:Sprite = new Sprite();

			var invisibleArea:Sprite = this.drawChipInvisibleArea();
			chipGraphicsContainer.addChild(invisibleArea);

			var chipImage:Bitmap = this.resourceManager.getBitmap(this.CHIP_RESOURCE_NAME + id + ".png");
			chipGraphicsContainer.addChild(chipImage);
			chipImage.x = (invisibleArea.width - chipImage.width) >> 1;
			chipImage.y = (invisibleArea.height - chipImage.height) >> 1;

			chipGraphicsContainer.x -= chipGraphicsContainer.width >> 1;
			chipGraphicsContainer.y -= chipGraphicsContainer.height >> 1;

			var chipView:ChipView = new ChipView(id);
			chipView.addChild(chipGraphicsContainer);

			// ++++++++++++ TEST TEST TEST TEST TEST ++++++++++++
			if(AppSettings.TEST_SHOW_IDS)
			{
				var tf:TextField = new TextField();
				tf.autoSize = TextFieldAutoSize.LEFT;
				tf.background = true;
				tf.text = id.toString();

				var f:TextFormat = new TextFormat(null, 20);
				tf.setTextFormat(f);

				tf.x = ((chipView.width - tf.width) / 2) - AppSettings.GRID_TILE_SIZE/2;
				tf.y = (chipView.height - tf.height) / 2 - AppSettings.GRID_TILE_SIZE/2;
				chipView.addChild(tf);
			}
			// ------------ TEST TEST TEST TEST TEST ------------

			return chipView;
		}

		//} endregion PUBLIC METHODS ===================================================

		//==============================================================================
		//{region						PRIVATE\PROTECTED METHODS
		private function drawChipFrame():Sprite
		{
			var s:Sprite = new Sprite();
			var framePartSize:Number = AppSettings.GRID_TILE_SIZE / 4;
			s.graphics.lineStyle(3, 0x5fb9f8);
			/*s.graphics.lineTo(AppSettings.GRID_TILE_SIZE, 0);
			 s.graphics.lineTo(AppSettings.GRID_TILE_SIZE, AppSettings.GRID_TILE_SIZE);
			 s.graphics.lineTo(0, AppSettings.GRID_TILE_SIZE);
			 s.graphics.lineTo(0, 0);*/

			// TOP LINES
			s.graphics.lineTo(framePartSize, 0);
			s.graphics.moveTo(framePartSize * 3, 0);
			s.graphics.lineTo(AppSettings.GRID_TILE_SIZE, 0);

			// RIGHT LINES
			s.graphics.lineTo(AppSettings.GRID_TILE_SIZE, framePartSize);
			s.graphics.moveTo(AppSettings.GRID_TILE_SIZE, framePartSize * 3);
			s.graphics.lineTo(AppSettings.GRID_TILE_SIZE, AppSettings.GRID_TILE_SIZE);

			// BOTTOM LINES
			s.graphics.lineTo(framePartSize * 3, AppSettings.GRID_TILE_SIZE);
			s.graphics.moveTo(framePartSize, AppSettings.GRID_TILE_SIZE);
			s.graphics.lineTo(0, AppSettings.GRID_TILE_SIZE);

			// LEFT LINES
			s.graphics.lineTo(0, framePartSize * 3);
			s.graphics.moveTo(0, framePartSize);
			s.graphics.lineTo(0, 0);

			return s;
		}

		private function drawChipInvisibleArea():Sprite
		{
			var s:Sprite = new Sprite();
			s.graphics.lineStyle(0);
			s.graphics.beginFill(0x0a0f01);
			s.graphics.drawRect(0, 0, AppSettings.GRID_TILE_SIZE, AppSettings.GRID_TILE_SIZE);
			s.graphics.endFill();
			s.alpha = 0;
			return s;
		}

		private function drawGrid():Sprite
		{
			var s:Sprite = new Sprite();
			s.graphics.lineStyle(2, 0xead8ca);

			var i:uint;
			// Horizontal lines
			var rightBorderX:Number = AppSettings.GRID_WIDTH * AppSettings.GRID_TILE_SIZE;
			for(i = 0; i <= AppSettings.GRID_HEIGHT; i++)
			{
				s.graphics.moveTo(0, (i * AppSettings.GRID_TILE_SIZE));
				s.graphics.lineTo(rightBorderX, (i * AppSettings.GRID_TILE_SIZE));
			}

			// Vertical lines
			var bottomBorderY:Number = AppSettings.GRID_HEIGHT * AppSettings.GRID_TILE_SIZE;
			for(i = 0; i <= AppSettings.GRID_WIDTH; i++)
			{
				s.graphics.moveTo((i * AppSettings.GRID_TILE_SIZE), 0);
				s.graphics.lineTo((i * AppSettings.GRID_TILE_SIZE), bottomBorderY);
			}

			return s;
		}

		private function drawBackground():Sprite
		{
			var s:Sprite = new Sprite();
			s.graphics.lineStyle(0);
			s.graphics.beginFill(0x302821);
			s.graphics.drawRect(0, 0, contextView.view.stage.stageWidth, contextView.view.stage.stageHeight);
			s.graphics.endFill();
			return s;
		}

		//} endregion PRIVATE\PROTECTED METHODS ========================================

		//==============================================================================
		//{region							GETTERS/SETTERS

		//} endregion GETTERS/SETTERS ==================================================
	}
}