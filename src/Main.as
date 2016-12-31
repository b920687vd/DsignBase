package
{
	import UI.Button.ButtonBase;
	import UI.Text.TextBase;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import UI.Board.BoardList;
	import UI.Text.NumberBase;
	
	import flash.display.StageDisplayState;
	
	import Shape.ShapeStyle;
	import UI.Board.BoardBase;
	import UI.UICtrlBase;
	
	/**
	 * ...
	 * @author Adam White
	 */
	import Tool.TypeTool;
	public class Main extends Sprite 
	{
		
		public function Main() 
		{
			this.stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			this.addChild(new BoardBase(960, 540,"board"));
			var ir:BoardBase = new BoardBase(100, 100, "", false, false);
			var er:NumberBase = new NumberBase(100, "干劲");
			var sd:NumberBase = new NumberBase(20, "心情");
			var list:BoardList = new BoardList(120, 10);
			var lisfif:ButtonBase = new ButtonBase();
			var lisfif2:ButtonBase = new ButtonBase(20,20);
			var lisfif3:ButtonBase = new ButtonBase();
			var lisis:TextBase = new TextBase("");
			this.addChild(list);
			list.add(ir);
			list.add(lisfif2);
			list.add(new ButtonBase(20,20));
			list.add(er);
			list.add(lisfif3);
			list.add(sd)
			list.add(lisfif);
			list.add(lisis);
			lisis.text = "我芭蕉桑今天就要告诉你们什么叫俳句！";
			list.x = 100;
			list.y = 200;
			this.addChild(new BoardBase(100, 100, "", true, true));
		}
		
		public static var Design_Width:Number = 960;
		public static var Design_Height:Number = 540;
		
	}
	
}