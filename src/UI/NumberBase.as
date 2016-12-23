package UI 
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import Tool.ShapeStyle;
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
			super(100, 20, Number_Style,id);
			_view_init();
		}
		
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
		
		override protected function _view_init():void 
		{
			super._view_init();
			
			if(this._num_field&&this._num_field.parent)
				this.removeChild(_num_field)
			
			this._num_field = new TextField();
			this.addChild(_num_field);
			this.mouseEnabled = false;
			this._num_field.mouseEnabled = false;
			this.refresh();
		}
		
		public function set num(num_set:Number):void
		{
			this._num = num_set;
			this.refresh();
		}
		
		public function clear():void
		{
			this.num = 0;
		}
		
		public function set label(label_set:String):void
		{
			this._label = label_set;
			this.refresh();
		}
		
		override public function refresh():void 
		{
			if ((!this._num_field)||(!this._label)||(!this._num))
				return;
			
			this._num_field.text = this._label.concat(" : ", this._num.toString());
			this._num_field.setTextFormat(Number_Font);
		}
		
		override public function dispose():void 
		{
			this.removeChild(_num_field);
			this._num_field = null;
			super.dispose();
		}
		
		protected var _num_field:TextField;
		
	}

}