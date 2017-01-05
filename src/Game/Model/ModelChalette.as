package Game.Model 
{
	/**
	 * 人理模型
	 * 衡量物种是否应该继续存续的模型
	 * @author Adam White
	 */
	public class ModelChalette 
	{
		
		public function ModelChalette(base:Number = 100,is_crowd = true) 
		{
			this.base_chalette = base;
			this._chalette = this.base_chalette
			this.is_crowd = is_crowd;
		}
		
		/**
		 * 基础人理值，由创造时指定
		 */
		private var base_chalette:Number;
		
		/**
		 * 当前模型是否是人群人理
		 */
		public var is_crowd:Boolean;
		
		/**
		 * 人理值
		 */
		private var _chalette:Number = 0;
		
		/**
		 * 计算平均人理
		 * 输入人群人理和伟人人理，计算种群平均人理
		 */
		public function avg_chalette(args:Array):Number
		{
			//计算人理总和
			var sum:Number = 0;
			for (var i = 0; i < args.length; i++ )
			{
				if (args[i] is ModelChalette)
					sum += (args[i] as ModelChalette).chalette;
				else if (args[i] is ModelGiant)
					sum += (args[i] as ModelGiant).chalette;
				else
					sum += args[i] as Number;
			}
			//计算平均人理
			var avg_ch:Number = sum / input_scale;
			//影响种群人理
			_chalette += 0.1 * (avg_ch - _chalette);
			return avg_ch;
		}
		
		/**
		 * 输入 - 物种规模
		 */
		private var input_scale:Number;
		/**
		 * 输入 - 物种绵延
		 */
		private var input_history:Number;
		/**
		 * 输入 - 物种价值
		 */
		private var input_score:Number;
		/**
		 * 输入 - 物种作用
		 */
		private var input_usage:Number;
		
		/**
		 * 物种规模
		 * 衡量物种庞大（空间）的数值
		 */
		public function set scale(s:Number):void
		{
			//计算人均人理
			var scale_rate:Number = _chalette / input_scale;
			//计算扩张速度
			var rise_scale:Number = s - input_scale;
			//如果种群扩张
			if (rise_scale > 0)
			{
				//物种作用可以抑制人理衰减
				if (scale_rate < 0.01)
				{
					//人理稀薄，人口极度拥挤，扩张消耗大量人理
					_chalette -= (input_usage>(rise_scale / 20))?(rise_scale / 40):(rise_scale / 20);
				}else if (scale_rate < 0.1)
				{
					//人理不足，人口拥挤，扩张消耗人理
					_chalette -= (input_usage>(rise_scale / 100))?(rise_scale / 200):(rise_scale / 100);
				}else if (scale_rate < 1)
				{
					//人理平衡
				}else if (scale_rate < 10)
				{
					//人理充足，扩张符合人理
					_chalette += rise_scale / 50;
				}
			}
			input_scale = s;
			//当scale降为0时，种群即宣告灭亡
		}
		
		/**
		 * 物种绵延
		 * 衡量物种时间跨度的数值
		 */
		public function set history(h:Number):void
		{
			//每一次迭代，人理都会自动回复[10%]自身数值（和[1%]score的数值）
			_chalette += 0.1 * _chalette + 0.01*input_score;
			input_history = h;
		}
		/**
		 * 物种价值
		 * 衡量物种创造的价值（已经改变）的数值
		 */
		public function set score(s:Number):void
		{
			input_score = s;
		}
		/**
		 * 物种作用
		 * 衡量物种作用（将要改变）的数值
		 */
		public function set usage(u:Number):void
		{
			input_usage = s;
		}
		
		/**
		 * 物种当前的人理值
		 */
		public function get chalette():Number
		{
			return base_chalette;
		}
	}

}