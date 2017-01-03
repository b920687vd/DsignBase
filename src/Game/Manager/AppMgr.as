package Game.Manager 
{
	/**
	 * 管理程序的进程
	 * @author Adam White
	 */
	public class AppMgr 
	{
		
		public function AppMgr() 
		{
			
		}
		
		private static var One:AppMgr;
		private var _status:String;
		
		/**
		 * 当前程序状态
		 *  -- 可能值 --
		 * "init"	:	初始化
		 * "game"	:	游戏进行
		 * "stop"	:	暂停中
		 */
		public static function get Status():String
		{
			return _status;
		}
		
		/**
		 * 初始化程序必要组件
		 */
		public static function Init():void
		{
			
		}
		
		/**
		 * 进入游戏进程
		 */
		public static function Game():void
		{
			
		}
		
		/**
		 * 暂停程序
		 */
		public static function Stop():void
		{
			
		}
		
		/**
		 * 结束程序
		 */
		public static function Over():void
		{
			
		}
		
		/**
		 * 退出程序
		 */
		public static function Exit():void
		{
			
		}
	}

}