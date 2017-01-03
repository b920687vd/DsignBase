package Game.Manager 
{
	/**
	 * 管理游戏的进行
	 * @author Adam White
	 */
	public class GameMgr 
	{
		
		public function GameMgr() 
		{
			
		}
		
		private static var One:GameMgr;
		private var _status:String;
		
		/**
		 * 当前游戏状态
		 *  -- 可能值 --
		 * "init"	:	初始化
		 * "start"	:	开始界面
		 * "being"	:	游戏进行中
		 * "stop"	:	暂停中
		 * "end"	:	游戏结束
		 */
		public static function get Status():String
		{
			
		}
		
		/**
		 * 初始化游戏进程
		 */
		public static function Game_Init():void
		{
			
		}
		
		/**
		 * 进入开始界面
		 */
		public static function Game_Start():void
		{
			
		}
		
		/**
		 * 开始新游戏
		 */
		public static function Game_New():void
		{
			
		}
		
		/**
		 * 加载存档
		 */
		public static function Game_Load():void
		{
			
		}
		
		/**
		 * 保存游戏
		 */
		public static function Game_Save():void
		{
			
		}
		
		/**
		 * 结束游戏
		 */
		public static function Game_End():void
		{
			
		}
		
	}

}