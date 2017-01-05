package Game.Manager 
{
	import Game.Model.ModelAmbition;
	import Game.Model.ModelChalette;
	import Game.Model.ModelGiant;
	import Game.Model.ModelIdeology;
	/**
	 * ...
	 * @author Adam White
	 */
	public class ModelMgr 
	{
		
		public function ModelMgr() 
		{
			
		}
		
		//人理之础
		private var _model_chalette:ModelChalette = new ModelChalette(100,false);
		//宏图之础
		private var _model_ambition:ModelAmbition = new ModelAmbition();
		//诸子之础
		private var _model_giant:ModelGiant = new ModelGiant();
		//争鸣之础
		private var _model_ideology:ModelIdeology = new ModelIdeology();
		//
	}

}