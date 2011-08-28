package se.stade.flash.dom.querying.css.parsing.rules
{
	import se.stade.flash.dom.querying.css.selectors.attributes.ClassSelector;
	import se.stade.parsing.Expression;
	import se.stade.parsing.Token;
	import se.stade.parsing.TokenStream;
	import se.stade.parsing.pratt.Parser;
	import se.stade.parsing.pratt.PrefixRule;
	
	public class ClassRule implements PrefixRule
	{
        public function evaluate(current:Token, following:TokenStream, parser:Parser, priority:uint):Expression
        {
            var names:Array = current.value.substr(1).split(".");
            return new ClassSelector(names);
		}
	}
}