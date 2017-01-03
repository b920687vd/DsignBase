package Engin.UI.Text 
{
	import Engin.UI.UICtrlBase;
	import Engin.UI.Text.TextBase;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import Engin.Shape.ShapeStyle;
	/**
	 * 数字显示版
	 * 固定的大小，用一个标签和一个数字组成
	 * @author Adam White
	 */
	public class NumberBase extends UICtrlBase
	{
		public function NumberBase(num_set:Number,label_set:String,id:String = "") 
		{
			this._num = num_set;
			this._label = label_set;
			super(100, 20, Number_Style, id);
			this._text_ctrl = new TextBase(this._label.concat(" : ", this._num.toString()), id.concat("_text"));
			this.addChild(_text_ctrl)
		}
		
		protected var _text_ctrl:TextBase;
		
		public static var Number_Style:ShapeStyle = new ShapeStyle(
		{
			line_size:2,
			line_color:0x000000,
			line_alpha:0,
			shape_color:0x000000,
			shape_alpha:0.8,
			rect_ellipse:1
		}
		)
		
		public static var Number_Font:TextFormat = new TextFormat(
		"微软雅黑", 11,0xFFFFFF,false,false,false,null,null,TextFormatAlign.CENTER,null,null,null,null
		)
		
		protected var _label:String;
		protected var _num:Number;
		
		public function set num(num_set:Number):void
		{
			this._num = num_set;
			this.refresh();
		}
		
		public function clear():void
		{
			this.num = 0;
			this.refresh()
		}
		
		public function set label(label_set:String):void
		{
			this._label = label_set;
			this.refresh();
		}
		
		override public function refresh():void 
		{
			if ((!this._text_ctrl)||(!this._label)||(!this._num))
				return;
			
			this._text_ctrl.text = this._label.concat(" : ", this._num.toString());
			this._text_ctrl.field.setTextFormat(Number_Font);
		}
	}

}