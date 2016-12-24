package UI 
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	
	import Shape.ShapeStyle;
	import Shape.ShapeDrawer;
	import Shape.ShapeDrawable;
	
	/**
	 * 基础控件类
	 * 所有控件的父类
	 * 定义基本的绘制逻辑
	 * @author Adam White
	 */
	public class UICtrlBase extends Sprite 
	{
		
		public function UICtrlBase(width_set:int,height_set:int,skin:ShapeStyle,id:String="") 
		{
			super();
			this._width = width_set;
			this._height = height_set;
			this._skin = skin;
			_view_init();
			
			_UIBase.push(this);
			if (!id)
			{
				id = "UICtrl_".concat(_UIBase.length - 1);
			}
			this.id = id;
			UIBase[id] = this;
		}
		
		private static var _UIBase:Array = new Array();
		public static var UIBase:Dictionary = new Dictionary();
		
		private var _event_handler:Dictionary;
		
		public function set skin(skin:ShapeStyle):void
		{
			this._skin = skin;
			_view_init();
		}
		
		public override function set width(width_set:Number):void
		{
			this._width = width_set;
			_view_init();
		}
		
		public override function set height(height_set:Number):void
		{
			this._height = height_set;
			_view_init();
		}
		
		/**
		 * 重新调整控件大小
		 * 不输入参数则按照_width,_height值进行调整
		 * @param	width_set
		 * @param	height_set
		 */
		public function resize(width_set:Number = -1, height_set:Number = -1):void
		{
			this._width = width_set!=-1?width_set:this._width;
			this._height = height_set != -1?height_set:this._height;
			_view_init();
			Debug.Console("Size drawing 2" + this.width + " " + this.height);
		}
		
		public function refresh():void
		{
			//...
		}
		
		protected function _view_init():void
		{
			_shape_dispose();
			_shape_arr = new Array();
			var main_shape:Sprite = ShapeDrawer.Draw(ShapeDrawable.RECTANGLE, _width, _height, _skin,"flash.display::Sprite") as Sprite
			_shape_arr.push(main_shape);
			this.addChild(main_shape);
			Debug.Console("Size drawing 3" + this.width + " " + this.height);
			this.setChildIndex(main_shape, 0);
			Debug.Console("Size drawing 4" + this.width + " " + this.height);
		}
		
		public function dispose():void
		{
			_shape_dispose();
			if (this.parent)
			{
				this.parent.removeChild(this);
			}
			_UIBase.splice(_UIBase.indexOf(this),1);
			UIBase[this.id] = null;
		}
		
		protected function _shape_dispose():void
		{
			if (!_shape_arr)
			{
				return;
			}
			
			for each(var s:DisplayObject in _shape_arr)
			{
				if (s.parent == this)
				{
					this.removeChild(s);
				}
				s = null;
			}
		}
		
		/**
		 * 设计宽度
		 */
		public function get s_width():Number
		{
			return _width;
		}
		
		/**
		 * 设计高度
		 */
		public function get s_height():Number
		{
			return _height;
		}
		
		protected var _skin:ShapeStyle;
		protected var _width:Number;
		protected var _height:Number;
		protected var _shape_arr:Array;
		
		public var id:String;
		
	}

}