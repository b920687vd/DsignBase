package Engin.Tool 
{
	/**
	 * ...
	 * @author Adam White
	 */
	import flash.utils.*;
	
	public class TypeTool 
	{
		
		public function TypeTool() 
		{
			
		}
		
		/**
		 * 返回指定类型的第一个对象
		 * @param	return_type		需要返回的对象类名
		 * @param	isSuper			是否搜索待选择对象的超类
		 * @param	...arguments	将所有待选择的参数传入
		 * @return	指定类名的第一个对象。若无则返回null
		 */
		public static function Return_Switch(return_type:String, isSuper:Boolean, ...arguments):*
		{
			for each(var x:* in arguments)
			{
				if (getQualifiedClassName(x) == return_type)
				{
					return x;
				}
			}
			//若不需要搜索超类，则停止搜索，返回null
			if (!isSuper)
			{
				return null;
			}
			
			for each(x in arguments)
			{
				if (getQualifiedSuperclassName(x) == return_type)
				{
					return x;
				}
			}
			
			//未搜索到类名或超类名为return_type的对象
			return null;
		}
		
	}

}