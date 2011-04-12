package se.stade.flash.dom.query.css.parsing.rules
{
	import se.stade.stilts.string.formatting.format;
	import se.stade.flash.dom.query.DisplayObjectMatcher;
	import se.stade.flash.dom.query.css.parsing.tokens.GroupToken;
	import se.stade.flash.dom.query.css.selectors.GroupSelector;
	import se.stade.flash.dom.query.parsing.ParseError;
	import se.stade.flash.dom.query.parsing.ParseRule;
	import se.stade.flash.dom.query.parsing.TokenStream;

	public class SelectorGroupRule implements ParseRule
	{
		public function SelectorGroupRule(selector:ParseRule)
		{
			this.selector = selector;
		}
		
		private var selector:ParseRule;
		
		public function evaluate(stream:TokenStream):*
		{
			var left:DisplayObjectMatcher = selector.evaluate(stream);
			
			if (left && stream.match(GroupToken))
			{
				var right:DisplayObjectMatcher = evaluate(stream.next());
				return new GroupSelector(left, right);
			}
			
			return left;
		}
	}
}