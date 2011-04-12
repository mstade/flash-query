package se.stade.flash.dom.query.css.parsing.rules
{
	import se.stade.flash.dom.query.DisplayObjectMatcher;
	import se.stade.flash.dom.query.css.parsing.tokens.IdentToken;
	import se.stade.flash.dom.query.css.selectors.ElementSelector;
	import se.stade.flash.dom.query.css.selectors.UniversalSelector;
	import se.stade.flash.dom.query.parsing.ParseRule;
	import se.stade.flash.dom.query.parsing.TokenStream;
	
	public class ElementRule implements ParseRule
	{
		public function ElementRule(namespace:ParseRule)
		{
			this.namespace = namespace;
		}
		
		private var namespace:ParseRule;
		
		public function evaluate(stream:TokenStream):*
		{
			var ns:DisplayObjectMatcher = stream.evaluate(namespace);
			
			if (stream.match(IdentToken))
				return new ElementSelector(stream.token.value, ns);
			else if (stream.match("*"))
				return new UniversalSelector(ns);
		}
	}
}