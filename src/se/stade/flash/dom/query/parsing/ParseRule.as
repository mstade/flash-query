package se.stade.flash.dom.query.parsing
{
	import se.stade.flash.dom.query.DisplayObjectMatcher;

	public interface ParseRule
	{
		function evaluate(stream:TokenStream):*;
	}
}