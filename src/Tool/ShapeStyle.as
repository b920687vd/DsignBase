package Tool 
{
	/**
	 * 皮肤描述类
	 * @author Adam White
	 */
	import Object;
	public dynamic class ShapeStyle extends Object
	{
		/**
		 * 创建新的样式描述
		 * 传空参数即为默认值
		 * @param	obj
		 */
		public function ShapeStyle(obj:Object = null) 
		{
			if (obj == null)
				obj = new Object();
			
			this.line_size = obj.hasOwnProperty("line_size")?obj.line_size:4;
			this.line_color = obj.hasOwnProperty("line_color")?obj.line_color:0xFF000000;
			this.line_alpha = obj.hasOwnProperty("line_alpha")?obj.line_alpha:0.4;
			
			this.shape_fill_staus = obj.hasOwnProperty("shape_fill_staus")?obj.shape_fill_staus:ShapeFillStatus.COLOR;
			this.shape_fill_param = new Object();
			
			if (this.shape_fill_staus == ShapeFillStatus.COLOR)
			{
				this.shape_fill_param.shape_color = obj.hasOwnProperty("shape_color")?obj.shape_color:0xFF440044;
				this.shape_fill_param.shape_alpha = obj.hasOwnProperty("shape_alpha")?obj.shape_alpha:0.4;
			}
			this.shape_fill_param.rect_ellipse = obj.hasOwnProperty("rect_ellipse")?obj.rect_ellipse:0;
		}
		
		public var line_size:int;
		public var line_color:int;
		public var line_alpha:Number;
		
		public var shape_fill_staus:String;
		public var shape_fill_param:Object;
	}

}