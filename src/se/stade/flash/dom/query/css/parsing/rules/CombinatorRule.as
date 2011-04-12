package se.stade.flash.dom.query.css.parsing.rules
{
	import se.stade.flash.dom.query.DisplayObjectMatcher;
	import se.stade.flash.dom.query.css.parsing.tokens.CombinatorToken;
	import se.stade.flash.dom.query.css.parsing.tokens.WhitespaceToken;
	import se.stade.flash.dom.query.css.selectors.ChildSelector;
	import se.stade.flash.dom.query.css.selectors.DescendantSelector;
	import se.stade.flash.dom.query.css.selectors.SiblingSelector;
	import se.stade.flash.dom.query.parsing.ParseRule;
	import se.stade.flash.dom.query.parsing.TokenStream;

	public class CombinatorRule implements ParseRule
	{
		public function CombinatorRule(selector:ParseRule)
		{
			this.selector = selector;
		}
		
		private var selector:ParseRule;
		
		public function evaluate(stream:TokenStream):*
		{
			var left:DisplayObjectMatcher = selector.evaluate(stream);
			
			if (stream.match(CombinatorToken) || stream.match(WhitespaceToken))
			{
				var operator:String = stream.token.value;
				
				var right:DisplayObjectMatcher = evaluate(stream);
				if (!right) return;
				
				var combinator:DisplayObjectMatcher;
				switch (operator)
				{
					case CombinatorToken.Child:
						return new ChildSelector(left, right);
						
					case CombinatorToken.Descendant:
						return new DescendantSelector(left, right);
						
					case CombinatorToken.Sibling:
						return new SiblingSelector(left, right);
						
					case CombinatorToken.Adjacent:
						return new SiblingSelector(left, right, 1);
				}
			}
			
			return left;
		}
	}
}