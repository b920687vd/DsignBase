package UI 
{
	/**
	 * ...
	 * @author Adam White
	 */
	public class BoardList extends BoardBase implements IContainer
	{
		
		public function BoardList(width_set:Number, height_set:Number, resize_able:Boolean=false, drag_able:Boolean=false,id:String="")
		{
			_child = new Array();
			_arrange = "y";
			_padding_x = 10;
			_padding_y = 10;
			
			_margin_x = 4;
			_margin_y = 4;
			
			_cont_x = _padding_x;
			_cont_y = _padding_y;
			super(width_set, height_set, id, resize_able, drag_able);
		}
		
		private var _child:Array;
		private var _cont_x:Number;
		private var _cont_y:Number;
		
		private var _padding_x:Number;
		private var _padding_y:Number;
		
		private var _margin_x:Number;
		private var _margin_y:Number;
		
		private var _arrange:String;
		
		public function get arrange():String
		{
			return _arrange;
		}
		
		public function add(ui:UICtrlBase):void
		{
			this._child.push(ui);
			this.addChild(ui);

			ui.x = _cont_x;
			ui.y = _cont_y;
			
			Debug.Console("ui size " + ui.width + " " + ui.height);
			
			if (_arrange == "x")
			{
				_cont_x += ui.s_width + _margin_x;
				this.resize(_cont_x+_padding_x, this._height);
			}
			else if (_arrange == "y")
			{
				_cont_y += ui.s_height + _margin_y;
				this.resize(this._width, _cont_y + _padding_y);
			}
		}
		
		public function pop():UICtrlBase
		{
			var reui:UICtrlBase = this._child.pop() as UICtrlBase
			this.removeChild(reui);
			return reui;
		}
		
	}

}