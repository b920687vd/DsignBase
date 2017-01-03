package Engin.UI 
{
	
	/**
	 * ...
	 * @author Adam White
	 */
	public interface IContainer 
	{
		function add(ui:UICtrlBase):void;
		function pop():UICtrlBase;
	}
	
}