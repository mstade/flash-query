package se.stade.flash.dom.query.css.parsing.rules
{
	import se.stade.flash.dom.query.DisplayObjectMatcher;
	import se.stade.flash.dom.query.css.parsing.tokens.NegationToken;
	import se.stade.flash.dom.query.css.selectors.NegatedSelector;
	import se.stade.flash.dom.query.parsing.ParseRule;
	import se.stade.flash.dom.query.parsing.TokenStream;
	
	public class NegationRule implements ParseRule
	{
		public function NegationRule(selector:ParseRule = null)
		{
			this.selector = selector;
		}
		
		public var selector:ParseRule;
		
		public function evaluate(stream:TokenStream):*
		{
			if (stream.match(NegationToken))
			{
				var selector:DisplayObjectMatcher = stream.evaluate(selector);
				
				if (selector)
					return new NegatedSelector(selector);
			}
		}
	}
}