package se.stade.flash.dom.query.css.parsing.rules
{
	import se.stade.flash.dom.query.DisplayObjectMatcher;
	import se.stade.flash.dom.query.css.parsing.tokens.HashToken;
	import se.stade.flash.dom.query.css.selectors.IdentitySelector;
	import se.stade.flash.dom.query.parsing.ParseRule;
	import se.stade.flash.dom.query.parsing.TokenStream;
	
	public class IdentityRule implements ParseRule
	{
		public function evaluate(stream:TokenStream):*
		{
			if (stream.match(HashToken))
				return new IdentitySelector(stream.token.value.substr(1));
		}
	}
}