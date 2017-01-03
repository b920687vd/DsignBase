package Engin.Tool 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author OMaster
	 */
	public class FunctionTool 
	{
		
		public function FunctionTool() 
		{
			
		}
		
		/**
		 * 将函数侦听器化并返回新函数
		 * @param	e
		 * @return
		 */
		public static function Eventify(e:Function):Function
		{
			var return_func:Function = function (ke:Event):void
			{
				e();
			}
			return return_func;
		}
		
		/**
		 * 将函数参数固定化并返回新函数
		 * @param	e
		 * @return
		 */
		public static function Paramify(e:Function, ...arguments):Function
		{
			var return_func:Function = function ():*
			{
				return e.apply(null, arguments);
			}
			return return_func;
		}
		
	}

}