package se.stade.flash.dom.querying.css.parsing.rules
{
	import flash.utils.Dictionary;
	
	import se.stade.flash.dom.querying.ElementMatcher;
	import se.stade.flash.dom.querying.css.parsing.SelectorToken;
	import se.stade.flash.dom.querying.css.selectors.SelectorGroup;
	import se.stade.flash.dom.querying.css.selectors.combinators.ChildSelector;
	import se.stade.flash.dom.querying.css.selectors.combinators.DescendantSelector;
	import se.stade.flash.dom.querying.css.selectors.combinators.SiblingSelector;
	import se.stade.parsing.Expression;
	import se.stade.parsing.Token;
	import se.stade.parsing.TokenStream;
	import se.stade.parsing.pratt.InfixRule;
	import se.stade.parsing.pratt.Parser;
	import se.stade.stilts.string.trim;

	public class CombinatorRule implements InfixRule
	{
        public function CombinatorRule()
        {
            factories = new Dictionary;
            factories[SelectorToken.Group]      = SelectorGroup;
            factories[SelectorToken.Child]      = ChildSelector;
            factories[SelectorToken.Sibling]    = SiblingSelector;
            factories[SelectorToken.Whitespace] = DescendantSelector;
        }
        
        private var factories:Dictionary;
        
        public function evaluate(preceding:Expression, current:Token, following:TokenStream, parser:Parser, precedence:uint):Expression
        {
            var left:ElementMatcher = ElementMatcher(preceding);
            var right:ElementMatcher = ElementMatcher(parser.interpret(following, precedence - 1));
            
            if (current.type == SelectorToken.Sibling)
            {
                var operator:String = trim(current.value);
                var distance:int; 
                
                if (operator == "<~")
                    distance = int.MIN_VALUE;
                else if (operator == "~>" || operator == "~")
                    distance = int.MAX_VALUE;
                else if (operator == "<+")
                    distance = -1;
                else if (operator == "+>" || operator == "+")
                    distance = 1;
                
                return new SiblingSelector(left, right, distance);
            }
            
            var Combinator:Class = factories[current.type];
            return new Combinator(left, right);
        }
	}
}