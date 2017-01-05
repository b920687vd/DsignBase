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
		
		private var _ui_mgr:UIMgr;
		private var _model_mgr:ModelMgr;
		
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
			if(One)
				return One._status;
			else
				return "end";
		}
		
		/**
		 * 初始化游戏进程
		 */
		public static function Game_Init():void
		{
			One = new GameMgr();
			One._init();
		}
		
		private function _init():void
		{
			_status = "init";
			
			_ui_mgr = new UIMgr();
			_model_mgr = new ModelMgr();
		}
		
		/**
		 * 进入开始界面
		 */
		public static function Game_Start():void
		{
			One._status = "start";
		}
		
		/**
		 * 开始新游戏
		 */
		public static function Game_New():void
		{
			One._status = "being";
		}
		
		/**
		 * 加载存档
		 */
		public static function Game_Load():void
		{
			One._status = "stop";
		}
		
		/**
		 * 保存游戏
		 */
		public static function Game_Save():void
		{
			One._status = "stop";
		}
		
		/**
		 * 结束游戏
		 */
		public static function Game_End():void
		{
			One._status = "end";
		}
		
	}

}