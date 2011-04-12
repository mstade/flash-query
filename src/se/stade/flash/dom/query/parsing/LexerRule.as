package se.stade.flash.dom.query.parsing
{
	public interface LexerRule
	{
		function matches(input:String, position:int, minLength:int):Boolean;
		
		function apply():Token;
	}
}