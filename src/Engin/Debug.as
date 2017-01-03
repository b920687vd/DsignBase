package Engin 
{
	/**
	 * 纠错控制台
	 * @author Adam White
	 */
	public class Debug 
	{
		
		public function Debug() 
		{
			
		}
		
		public static function Console(...args):void
		{
			var channel:String = "";
			if (args[args.length - 1] == "debug")
			{
				channel = args.pop();
			}
			trace(args.join(""));
		}
		
	}

}