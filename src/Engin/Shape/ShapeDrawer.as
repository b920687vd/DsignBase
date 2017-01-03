package Engin.Shape 
{
	/**
	 * ...
	 * @author Adam White
	 */
	
	import Engin.Debug;
	import Engin.Shape.ShapeDrawable;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import Engin.Shape.ShapeStyle;
	import Engin.Tool.TypeTool;
	
	public class ShapeDrawer 
	{
		
		public function ShapeDrawer() 
		{
			
		}
		
		private static var drawer:Shape = new Shape();
		
		/**
		 * 调用接口
		 * 绘制图形返回给调用者
		 * @param	shape
		 * @param	width
		 * @param	height
		 * @param	style
		 * @return
		 */
		public static function Draw(shape:String, width:int, height:int, style:ShapeStyle, return_type:String = "flash.display::Sprite"):DisplayObject
		{
			return _draw_base(shape)(width, height, style, return_type);
		}
		
		private static function _draw_base(shape:String):Function
		{
			var draw_func:Function =
			function(width:int, height:int, style:ShapeStyle, return_type:String):DisplayObject
			{
				var shape_sprite:Sprite = new Sprite();
				
				drawer = new Shape(); 
				if(!(style.line_alpha-0.0)<0.01)
					drawer.graphics.lineStyle(style.line_size, style.line_color, style.line_alpha); 
				
				//根据shape_fill_staus属性填充图形
				Engin.Debug.Console(style.shape_fill_staus)
				if(style.shape_fill_staus == ShapeFillStatus.COLOR)
				{
					if (!(style.shape_fill_param.shape_alpha - 0.0) < 0.01)
						drawer.graphics.beginFill(style.shape_fill_param.shape_color, style.shape_fill_param.shape_alpha);
				}
				else if (style.shape_fill_staus == ShapeFillStatus.BITMAP)
				{
					var fill_bmdata:BitmapData = style.shape_fill_param.shape_bitmap
					drawer.graphics.beginBitmapFill(style.shape_fill_param.shape_bitmap, style.shape_fill_param.matrix, style.shape_fill_param.repeat, style.shape_fill_param.smooth);
				}
				
				Engin.Debug.Console("Draw " + shape);
				
				//闭包函数生成
				if (shape == ShapeDrawable.RECTANGLE)
				{
					drawer.graphics.drawRoundRect(0, 0, width, height,style.shape_fill_param.rect_ellipse); 
				}
				else if (shape == ShapeDrawable.CIRCLE)
				{
					if (width == height)
						drawer.graphics.drawCircle(0, 0, width);
					else
						drawer.graphics.drawEllipse(0, 0, width, height);
				}
				
				drawer.graphics.endFill();
				
				var shape_bmdata:BitmapData = new BitmapData(width, height, true, 0x00000000);
				shape_bmdata.draw(drawer);
				var shape_bitmap:Bitmap = new Bitmap(shape_bmdata);
				shape_sprite.addChild(shape_bitmap)
				var return_obj:DisplayObject = TypeTool.Return_Switch(return_type, false, shape_bmdata, shape_bitmap, shape_sprite);
				return return_obj;
			}
			return draw_func;
		}
	}

}