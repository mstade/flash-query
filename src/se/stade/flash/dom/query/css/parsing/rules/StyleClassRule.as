package se.stade.flash.dom.query.css.parsing.rules
{
	import se.stade.flash.dom.query.css.StyleNameCollection;
	import se.stade.flash.dom.query.css.parsing.tokens.IdentToken;
	import se.stade.flash.dom.query.css.selectors.StyleClassSelector;
	import se.stade.flash.dom.query.parsing.ParseRule;
	import se.stade.flash.dom.query.parsing.TokenStream;
	
	public class StyleClassRule implements ParseRule
	{
		public function evaluate(stream:TokenStream):*
		{
			if (stream.match(".") && stream.match(IdentToken))
			{
				var styleNames:String = stream.token.value;
				
				var styles:StyleNameCollection = new StyleNameCollection(styleNames);
				return new StyleClassSelector(styles);
			}
		}
	}
}