package Engin.UI.Board 
{
	import Engin.Shape.ShapeStyle;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import Engin.UI.UICtrlBase;
	/**
	 * 基础面板类
	 * 所有面板的基类
	 * -可调整大小
	 * -可拖动
	 * @author Adam White
	 */
	public class BoardBase extends UICtrlBase
	{
		
		public function BoardBase(width_set:Number,height_set:Number,id:String="",resize_able:Boolean = false,drag_able:Boolean = false,style:ShapeStyle = null) 
		{
			if (!style)
				style = BoardBase.Board_Style
			super(width_set, height_set, style,id);
			if(resize_able)
				this.addEventListener(MouseEvent.MOUSE_DOWN, resize_check);
			if (drag_able)
				this.addEventListener(MouseEvent.MOUSE_DOWN, drag_check);
		}
		
		public static var Min_Width:Number = 20;
		public static var Min_Height:Number = 20;
		
		protected var _dragging_type:String;
		
		/**
		 * 面板类的默认样式
		 */
		public static var Board_Style:ShapeStyle = new ShapeStyle(
		{
			line_size:4,
			line_color:0xFF000000,
			line_alpha:0.4,
			shape_color:0xFFAAAAAA,
			shape_alpha:0.1,
			rect_ellipse:0
		})
		
		protected function drag_check(e:MouseEvent):void
		{
			trace(this.mouseY)
			this.parent.setChildIndex(this,this.parent.numChildren-1);
			if (this.mouseY > 0 && this.mouseY < 10)
			{
				e.stopImmediatePropagation();
				this.startDrag();
				this.parent.addEventListener(MouseEvent.MOUSE_UP,drag_stop)
			}
		}
		
		protected function drag_stop(e:MouseEvent):void
		{
			this.stopDrag();
			this.removeEventListener(MouseEvent.MOUSE_UP, drag_stop);
			if (this.x < 0)
				this.x = 0;
			if (this.y < 0)
				this.y = 0;
				
			trace(this.x+" "+this.stage.width+" "+this._width)
			if (this.x > (Main.Design_Width - this._width))
			{
				this.x = Main.Design_Width - this._width
			}
			if (this.y > (Main.Design_Height - this._height))
			{
				this.y = Main.Design_Height - this._height;
			}
		}
		
		/**
		 * 检查鼠标位置
		 * 根据坐标判断是否满足调整边缘条件
		 * 共有三种调整模式：both，X，Y
		 * 若判断成功则进入侦听阶段更改大小同时删除鼠标按下注册
		 * 同时增加鼠标弹起侦听
		 * @param	e
		 */
		protected function resize_check(e:MouseEvent):void
		{
			trace(this.mouseX + " " + this.width + " " + this.mouseY + " " + this.height);
			trace(this.parent.numChildren);
			this.parent.setChildIndex(this,this.parent.numChildren-1);
			if (this.mouseX > (this.width - Min_Width) && this.mouseX < (this.width + 10) && this.mouseY > (this.height - Min_Height) && this.mouseY < (this.height + 10))
			{
				trace("Board Dragable both");
				this._dragging_type = "both";
				this.removeEventListener(MouseEvent.MOUSE_DOWN, resize_check);
				e.stopImmediatePropagation();
				this.addEventListener(Event.ENTER_FRAME, resize_draging_both);
				this.parent.addEventListener(MouseEvent.MOUSE_UP, resize_stop);
			}
			else if (this.mouseX > (this.width - Min_Width) && this.mouseX < (this.width + 10) && this.mouseY > 0 && this.mouseY < (this.height + 10))
			{
				trace("Board Dragable Y");
				this._dragging_type = "Y";
				this.removeEventListener(MouseEvent.MOUSE_DOWN, resize_check);
				e.stopImmediatePropagation();
				this.addEventListener(Event.ENTER_FRAME, resize_draging_Y);
				this.parent.addEventListener(MouseEvent.MOUSE_UP, resize_stop);
			}
			else if (this.mouseX > 0 && this.mouseX < (this.width + 10) && this.mouseY > (this.height - Min_Height) && this.mouseY < (this.height + 10))
			{
				trace("Board Dragable X");
				this._dragging_type = "X";
				this.removeEventListener(MouseEvent.MOUSE_DOWN, resize_check);
				e.stopImmediatePropagation();
				this.addEventListener(Event.ENTER_FRAME, resize_draging_X);
				this.parent.addEventListener(MouseEvent.MOUSE_UP, resize_stop);
			}
		}
		
		protected function resize_draging_both(e:Event):void
		{
			trace("Board Dragging both"+this.mouseX+" "+this.width+" "+this.mouseY+" "+this.height+" "+this.stage?this.stage.width:""+" "+this.stage?this.stage.height:"");
			if ((this.mouseX <= Min_Width) || (this.mouseY <= Min_Height))
			{
				var temp_width:Number = this.mouseX > Min_Width?this.mouseX:Min_Width;
				var temp_height:Number = this.mouseY > Min_Height?this.mouseY:Min_Height;
				resize(temp_width,temp_height);
				return;
			}
			
			resize(this.mouseX, this.mouseY);
		}
		
		protected function resize_draging_Y(e:Event):void
		{
			trace("Board Dragging Y"+this.mouseX+" "+this.width+" "+this.mouseY+" "+this.height);
			//判断宽度是否过小
			if (this.mouseX <= Min_Width)
			{
				var temp_width:Number = this.mouseX > Min_Width?this.mouseX:Min_Width;
				resize(temp_width);
				return;
			}
			
			resize(this.mouseX);
		}
		
		protected function resize_draging_X(e:Event):void
		{
			trace("Board Dragging X"+this.mouseX+" "+this.width+" "+this.mouseY+" "+this.height);
			//判断高度是否过小
			if (this.mouseY <= Min_Height)
			{
				var temp_height:Number = this.mouseY > Min_Height?this.mouseY:Min_Height;
				resize(-1,temp_height);
				return;
			}
			resize(-1, this.mouseY);
		}
		
		/**
		 * 停止调整大小
		 * 清除更改大小的侦听注册
		 * 重新侦听鼠标按下事件
		 * @param	e
		 */
		protected function resize_stop(e:Event):void
		{
			trace("Board Drag Stop");
			//不再更改大小
			switch(this._dragging_type)
			{
				case "both":
					this.removeEventListener(Event.ENTER_FRAME, resize_draging_both);
					break;
				case "X":
					this.removeEventListener(Event.ENTER_FRAME, resize_draging_X);
					break;
				case "Y":
					this.removeEventListener(Event.ENTER_FRAME, resize_draging_Y);
					break;
			}
			//不再侦听鼠标弹起事件
			this.parent.removeEventListener(MouseEvent.MOUSE_UP, resize_stop);
			//重新侦听鼠标按下事件
			this.addEventListener(MouseEvent.MOUSE_DOWN, resize_check);
		}
	}

}