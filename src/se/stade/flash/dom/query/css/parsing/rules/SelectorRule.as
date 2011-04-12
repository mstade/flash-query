package se.stade.flash.dom.query.css.parsing.rules
{
	import se.stade.flash.dom.query.DisplayObjectMatcher;
	import se.stade.flash.dom.query.parsing.ParseRule;
	import se.stade.flash.dom.query.parsing.TokenStream;
	import se.stade.flash.dom.query.ChainMatcher;
	
	public class SelectorRule implements ParseRule
	{
		public function SelectorRule(element:ParseRule, identity:ParseRule, styleClass:ParseRule, attribute:ParseRule, pseudo:ParseRule, negation:ParseRule)
		{
			this.element = element;
			
			attributes = new <ParseRule>
			[
				identity,
				styleClass,
				attribute,
				pseudo,
				negation
			];
		}
		
		private var element:ParseRule;
		private var attributes:Vector.<ParseRule>;
		
		public function evaluate(stream:TokenStream):*
		{
			var selectors:Vector.<DisplayObjectMatcher> = new <DisplayObjectMatcher>[];
			
			var type:DisplayObjectMatcher = stream.evaluate(element);
			if (type)
				selectors.push(type);
			
			while (stream.peek())
			{
				var selector:DisplayObjectMatcher = null;
				
				for each (var attribute:ParseRule in attributes)
				{
					selector = stream.evaluate(attribute);
					
					if (selector)
						break;
				}
				
				if (selector)
					selectors.push(selector);
				else
					break;
			}
			
			return ChainMatcher.FromList(selectors);
		}
	}
}