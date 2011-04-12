package se.stade.flash.dom.query.css.parsing.rules
{
	import se.stade.flash.dom.query.DisplayObjectMatcher;
	import se.stade.flash.dom.query.css.parsing.tokens.IdentToken;
	import se.stade.flash.dom.query.css.parsing.tokens.WhitespaceToken;
	import se.stade.flash.dom.query.css.selectors.AttributeSelector;
	import se.stade.flash.dom.query.css.selectors.attributes.AttributeValue;
	import se.stade.flash.dom.query.parsing.ParseRule;
	import se.stade.flash.dom.query.parsing.TokenStream;
	
	public class AttributeRule implements ParseRule
	{
		public function AttributeRule(namespace:ParseRule, value:ParseRule)
		{
			this.namespace = namespace;
			this.value = value;
		}
		
		private var namespace:ParseRule;
		private var value:ParseRule;
		
		public function evaluate(stream:TokenStream):*
		{
			if (stream.scope("[", "]"))
			{
				var ns:DisplayObjectMatcher = stream.skip(WhitespaceToken).evaluate(namespace);
				
				if (stream.match(IdentToken))
				{
					var name:String = stream.token.value;
					
					var val:AttributeValue = stream.skip(WhitespaceToken).evaluate(value);
					
					return new AttributeSelector(name, val, ns);
				}
			}
		}
	}
}