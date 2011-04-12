package se.stade.flash.dom.query
{
	public interface QueryParser
	{
		function interpret(query:String):DisplayObjectMatcher;
	}
}