package se.stade.flash.dom.query.css.parsing.rules
{
	import se.stade.flash.dom.query.css.parsing.tokens.AttributeValueToken;
	import se.stade.flash.dom.query.css.parsing.tokens.IdentToken;
	import se.stade.flash.dom.query.css.selectors.attributes.AnyAttribute;
	import se.stade.flash.dom.query.css.selectors.attributes.AttributeBeginsWith;
	import se.stade.flash.dom.query.css.selectors.attributes.AttributeContains;
	import se.stade.flash.dom.query.css.selectors.attributes.AttributeEndsWith;
	import se.stade.flash.dom.query.css.selectors.attributes.AttributeEquals;
	import se.stade.flash.dom.query.css.selectors.attributes.AttributeIsOneOf;
	import se.stade.flash.dom.query.css.selectors.attributes.UnknownAttribute;
	import se.stade.flash.dom.query.parsing.ParseRule;
	import se.stade.flash.dom.query.parsing.StringToken;
	import se.stade.flash.dom.query.parsing.TokenStream;
	
	public class AttributeValueRule implements ParseRule
	{
		public function evaluate(stream:TokenStream):*
		{
			if (stream.match(AttributeValueToken))
			{
				if (stream.match(IdentToken) || stream.match(StringToken))
				{
					switch (stream.token.value)
					{
						case AttributeValueToken.Equals:
							return new AttributeEquals(stream.token.value);
							
						case AttributeValueToken.Contains:
							return new AttributeContains(stream.token.value);
							
						case AttributeValueToken.IsOneOf:
							var values:Vector.<String> = Vector.<String>(stream.token.value.split(" ")); 
							return new AttributeIsOneOf(values);
							
						case AttributeValueToken.EndsWith:
							return new AttributeEndsWith(stream.token.value);
							
						case AttributeValueToken.BeginsWith:
							return new AttributeBeginsWith(stream.token.value);
							
						default:
							return new UnknownAttribute(stream.token.value);
					}
				}
			}
		}
	}
}