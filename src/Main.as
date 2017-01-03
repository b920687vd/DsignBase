package
{
	import Engin.UI.Button.ButtonBase;
	import Engin.UI.Text.TextBase;
	import Engin.UI.Board.BoardList;
	import Engin.UI.Text.NumberBase;
	import Engin.Shape.ShapeStyle;
	import Engin.UI.Board.BoardBase;
	import Engin.UI.UICtrlBase;
	
	import flash.display.StageDisplayState;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Adam White
	 */
	import Engin.Tool.TypeTool;
	public class Main extends Sprite 
	{
		
		public function Main() 
		{
			this.stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
		}
		
		public static var Design_Width:Number = 960;
		public static var Design_Height:Number = 540;
		
	}
	
}