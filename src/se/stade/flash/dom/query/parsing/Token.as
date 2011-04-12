package se.stade.flash.dom.query.parsing
{
	public interface Token
	{
		function get index():int;
		function get length():uint;
		
		function get value():*;
	}
}