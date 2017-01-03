package Engin.UI.Button 
{
	import Engin.Shape.ShapeStyle;
	import Engin.Tool.FunctionTool;
	import Engin.UI.UICtrlBase;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author OMaster
	 */
	public class ButtonBase extends UICtrlBase 
	{
		
		public function ButtonBase(width_set:int =100, height_set:int =20, id:String="") 
		{
			super(width_set, height_set, Button_Style, id);
			this.buttonMode = true;
			this.useHandCursor = true;
		}
		
		public static var Button_Style:ShapeStyle = new ShapeStyle(
		{
			line_size:2,
			line_color:0x000000,
			line_alpha:0,
			shape_color:0x000000,
			shape_alpha:0.8,
			rect_ellipse:1
		})
		
		public static var Button_Style_Over:ShapeStyle = new ShapeStyle(
		{
			line_size:2,
			line_color:0x000000,
			line_alpha:0,
			shape_color:0x000000,
			shape_alpha:0.8,
			rect_ellipse:1
		})
		
		private var _click_event:Function;
		private var _click_eventify:Function;
		
		public function set click(e:Function):void
		{
			this._click_event = e;
			this._click_eventify = FunctionTool.Eventify(e);
			this.addEventListener(MouseEvent.CLICK, _click_eventify);
		}
		
	}

}