package Engin 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	import Engin.Debug;
	
	/**
	 * 【预载管理器】
	 * <p>
	 * /工具类/；管理资源预载并储存预载资源。
	 * </p>
	 * <p>
	 * 最多需要三步预载工作。
	 * <li>将资源从网络下载至本地</li>
	 * <li>将资源从本地加载至内存</li>
	 * <li>将资源分割并分配至指定容器</li>
	 * </p>
	 */
	public class Resource
	{
		public function Resource()
		{
			
		}
		
		/*文件类型常量*/
		public static const FILE_PICTURE:String = "file_picture";
		public static const FILE_AUDIO:String = "file_audio";
		public static const FILE_JSON:String = "file_json";
		public static const FILE_BINARY:String = "file_binary";
		
		/*
		以下为预载信息存储
		除preloadList为数组之外，其他均为字典
		*/
		
		/** var：预载列表<BR/> 内容为要加载内容的url*/
		public static var preloadList:Array = new Array();
		
		/*
		为保证语义明确，字典两两成对
		List字典的关键字均为 资源名；用于用资源名查询资源信息
		Dict字典的关键字均为 对应的信息（如url、loader）；用于用资源信息反查资源名
		*/
		
		/** 资源名列表<BR/> 关键字为 资源名 ，值为 资源url */
		private static var nameList:Dictionary = new Dictionary();
		/** 资源名字典<BR/> 关键字为 资源url ，值为 资源名 */
		private static var nameDict:Dictionary = new Dictionary();
		/** 加载器列表<BR/> 关键字为 资源名 ，值为 资源加载器 */
		public static var loaderList:Dictionary = new Dictionary();
		/** 加载器字典<BR/> 关键字为 资源加载器 ，值为 资源名 */
		private static var loaderDict:Dictionary = new Dictionary();
		/** 资源状态表<BR/> 关键字为 资源名 ，值为 资源加载状态["to load","loading","loaded"] */
		public static var stepList:Dictionary = new Dictionary();
		
		/** Dict：加载器列表<BR/> 关键字为 资源名 ，值为 资源加载器 */
		public static function get get():Dictionary
		{
			return loaderList;
		}
		
		/** 已加载资源数*/
		public static var Loaded:int = 0;
		/** 加载中资源数*/
		public static var Loading:int = 0;
		public static var loadedBytes:int = 0;
		
		/**
		 * 添加预载<BR/>
		 * /调用接口/；将参数添加至预载列表
		 * @param ob 资源代号
		 * @param url 资源文件地址
		 */
		public static function add(ob:String,url:String):void
		{
			Engin.Debug.Console(ob+" "+url);
			preloadList.push(url);
			nameList[ob] = url;
			nameDict[url] = ob;
			stepList[ob] = "to load";
			Engin.Debug.Console(ob+" 已写入 "+url+" "+nameList[ob]+" "+nameDict[url]);
		}
		
		/**后缀名识别/已测验/
		 * @return 表示文件处理类型的常量字符串；
		*/
		public static function extenRec(aimURL:String):String
		{
			var divice:Array = aimURL.split(".");
			var extension:String = divice[divice.length-1];
			switch(extension)
			{
				case "jpg":{}
				case "jpeg":{}
				case "png":
				{
					return FILE_PICTURE;
				}
				case "mp3":{}
				case "wav":{}
				case "avi":
				{
					return FILE_AUDIO;
				}
				case "map":{}
				case "json":{}
				case "evt":
				{
					return FILE_JSON;
				}
				default:
				{
					return FILE_BINARY;
					break;
				}
			}
		}
		
		/*重要函数*/
		/**
		 * func：开始预载<BR/>
		 * /调用接口/；调用则使预载工作开始。预载器将逐一检查preloadList中的url，并将其对应的资源加载到新创建的加载器中。
		 * 其进度将由Loading属性和Loaded属性表示，当Loading属性归零时加载完毕。
		 */
		public static function PreLoad():void
		{
			for each(var i:String in preloadList)
			{
				Engin.Debug.Console("正在预载 "+i+" ;"+nameDict[i])
				Loading++;
				stepList[nameDict[i]] = "loading";
				switch(extenRec(i))
				{
					case FILE_PICTURE:{}
					case FILE_AUDIO:
					{
						loadFromFile(i,extenRec(i));
						break;
					}
						
					default:
					{
						ExloadFromFile(i,extenRec(i));
						break;
					}
				}
				//错误处理
				
			}
		}
		
		/*第一步加载函数组 网络 -> 本地*/
		/** /需要网络/；从指定网址下载资源至本地 */
		private static function loadFromNet(url:String,loader:*,type:String):void
		{
			
		}
		
		/** /需要网络/；从指定网址加载变量*/
		private static function loadVariables(url:String,loader:*,type:String):void
		{
			
		}
		
		/*第二步加载函数组 本地 -> 内存*/
		/** 从指定文件加载资源至内存（文本/二进制/变量）*/
		private static function ExloadFromFile(url:String,type:String):void
		{
			var loader:URLLoader = new URLLoader();
			loaderDict[loader] = nameDict[url];
			var request:URLRequest = new URLRequest(url)
			if(type == FILE_JSON)
			{
				loader.dataFormat = URLLoaderDataFormat.TEXT;
				loader.addEventListener(Event.COMPLETE,JSONpreloadComplete);
			}
			else if(type == FILE_BINARY)
			{
				loader.dataFormat = URLLoaderDataFormat.BINARY;
			}
			loader.load(request);
		}
		/** 从指定文件加载资源至内存 (swf/图片/声音)*/
		private static function loadFromFile(url:String,type:String):void
		{
			var loader:Loader = new Loader();
			loader.load(new URLRequest(url));
			loaderDict[loader.contentLoaderInfo] = nameDict[url];
			if(type == FILE_PICTURE)
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE,PicpreloadComplete);
		}
		
		/*第三步加载函数组 对象->对象（闲置）*/
		/** 从指定对象读取数据并分配至制定容器 */
		private static function loadFromObject(object:*,loader:*,type:String,...args):void
		{
			
		}
		
		/*完成处理函数组*/
		/**
		 * 图片预载完成<BR/>
		 * /事件处理/；图片预载完成时调用。
		 */
		private static function PicpreloadComplete(e:Event):void
		{
			var sourcename:String = loaderDict[e.target];
			var loadedpic:* = e.target;
			var newpic:Bitmap = new Bitmap();
			newpic.bitmapData = new BitmapData(loadedpic.width,loadedpic.height);
			newpic.bitmapData.copyPixels(loadedpic.content.bitmapData,new Rectangle(0,0,loadedpic.width,loadedpic.height),new Point());
			loaderList[sourcename] = newpic;
			stepList[sourcename] = "loaded";
			Engin.Debug.Console(sourcename+" 加载完成");
			loadedBytes+= e.target.bytesTotal;
			Loaded++;
			Loading--;
			
			//检察预载是否完成；
			loadCompleteCheck();
		}
		/**JSON文件预载完成<br/>
		 * /事件处理/；JSON内容的文件预载完成时调用
		*/
		private static function JSONpreloadComplete(e:Event):void
		{
			var sourcename:String = loaderDict[e.target];
			var loadedFile:String = e.target.data;
			var newobj:Object = JSON.parse(loadedFile);
			stepList[sourcename] = "loaded";
			loaderList[sourcename] = newobj;
			loadedBytes+= e.target.bytesTotal;
			Loaded++;
			Loading--;
			
			//检察预载是否完成；
			loadCompleteCheck();
		}
		
		/**检查预载进度<BR/>
		 * 检查预载是否产完成。若完成，发送预载完成("preload_complete")事件。*/
		private static function loadCompleteCheck():void
		{
			Engin.Debug.Console("当前已加载 "+Loaded+"/"+preloadList.length)
			if(Loading == 0)
			{
				EventManager.sendEvent(new PreLoadEvent("preload_complete"));
				var bytes:String = (loadedBytes>1024)?((loadedBytes/1024)>1024?(int(loadedBytes/1024/1024)+"M"):int(loadedBytes/1024)+"K"):(loadedBytes+"字节")
				Engin.Debug.Console("本次预载 "+Loaded+"个对象，共占用"+bytes+"空间");
				Engin.Debug.ConsoleBlock("资源预载完成");
			}
		}
	}
}