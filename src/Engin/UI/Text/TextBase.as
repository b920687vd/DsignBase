package Engin.UI.Text 
{
	import Engin.Shape.ShapeStyle;
	import Engin.UI.UICtrlBase;
	
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * ...
	 * @author OMaster
	 */
	public class TextBase extends UICtrlBase 
	{
		
		public function TextBase(text_set:String, id:String="", skin:ShapeStyle=null) 
		{
			if (!skin)
				skin = Text_Style;
			this._text = text_set;
			super(100, 20, skin,id);
			this._view_init();
		}
		
		public static var Text_Style:ShapeStyle = new ShapeStyle(
		{
			line_size:2,
			line_color:0xFFFFFF,
			line_alpha:0.8,
			shape_color:0xFFFFFF,
			shape_alpha:0,
			rect_ellipse:1
		}
		)
		
		public static var Text_Font:TextFormat = new TextFormat(
		"微软雅黑", 11,0xFFFFFF,false,false,false,null,null,TextFormatAlign.CENTER,null,null,null,null
		)
		
		protected var _text:String;
		protected var _text_field:TextField;
		
		override protected function _view_init():void 
		{
			super._view_init();
			
			if(this._text_field&&this._text_field.parent)
				this.removeChild(_text_field)
			
			this._text_field = new TextField();
			this.addChild(_text_field);
			this.mouseEnabled = false;
			this._text_field.mouseEnabled = false;
			this.refresh();
		}
		
		public function set text(_text_set:String):void
		{
			this._text = _text_set;
			this.refresh();
		}
		
		public function get text():String
		{
			return this._text;
		}
		
		public function get field():TextField
		{
			return _text_field;
		}
		
		public function clear():void
		{
			this._text = "";
			this.refresh();
		}
		
		override public function refresh():void 
		{
			if ((!this._text_field)||(!this._text))
				return;
			
			this._text_field.text = this._text;
			this._text_field.setTextFormat(Text_Font);
			
			if((this._width!=this._text_field.width)||(this._width!=this._text_field.height))
				this.resize(this._text_field.width, this._text_field.height);
		}
		
		override public function dispose():void 
		{
			this.removeChild(_text_field);
			this._text_field = null;
			super.dispose();
		}
	}
}