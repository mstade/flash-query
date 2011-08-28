package se.stade.flash.dom.querying.css.parsing.rules
{
	import flash.utils.Dictionary;
	
	import se.stade.flash.dom.querying.css.parsing.SelectorToken;
	import se.stade.flash.dom.querying.css.selectors.attributes.AttributeSelector;
	import se.stade.flash.dom.querying.css.selectors.attributes.operators.AttributeBeginsWith;
	import se.stade.flash.dom.querying.css.selectors.attributes.operators.AttributeContains;
	import se.stade.flash.dom.querying.css.selectors.attributes.operators.AttributeEndsWith;
	import se.stade.flash.dom.querying.css.selectors.attributes.operators.AttributeEquals;
	import se.stade.flash.dom.querying.css.selectors.attributes.operators.AttributeIsOneOf;
	import se.stade.flash.dom.querying.css.selectors.attributes.operators.AttributeOperator;
	import se.stade.flash.dom.querying.css.selectors.type.NamespaceSelector;
	import se.stade.parsing.Expression;
	import se.stade.parsing.Token;
	import se.stade.parsing.TokenStream;
	import se.stade.parsing.pratt.Parser;
	import se.stade.parsing.pratt.PrefixRule;
	
	public class AttributeRule implements PrefixRule
	{
        private static const OperatorType:Dictionary = new Dictionary;
        {
            OperatorType[SelectorToken.Equals] = AttributeEquals;
            OperatorType[SelectorToken.IsOneOf] = AttributeIsOneOf;
            OperatorType[SelectorToken.Contains] = AttributeContains;
            OperatorType[SelectorToken.EndsWith] = AttributeEndsWith;
            OperatorType[SelectorToken.BeginsWith] = AttributeBeginsWith;
        }
        
        public function evaluate(current:Token, stream:TokenStream, parser:Parser, priority:uint):Expression
        {
            if (stream.ignore(SelectorToken.Whitespace)
                      .accept(SelectorToken.Namespace))
            {
                var namespace:NamespaceSelector = new NamespaceSelector(stream.value.substr(0, -1));
            }
            
            var name:String = stream.expect(SelectorToken.Name).value;
            
            if (stream.ignore(SelectorToken.Whitespace)
                      .accept(SelectorToken.Equals,
                              SelectorToken.BeginsWith,
                              SelectorToken.EndsWith,
                              SelectorToken.Contains,
                              SelectorToken.IsOneOf))
            {
                var AttributeOperatorType:Class = OperatorType[stream.type];
                
                stream.ignore(SelectorToken.Whitespace); // Don't include leading whitespace in the value
                
                var value:String = "";
                
                while (stream.acceptAnythingBut(SelectorToken.AttributeEnd))
                {
                    if (stream.type == SelectorToken.Whitespace &&
                        stream.nextTypeIs(SelectorToken.AttributeEnd))
                        break; // Don't include trailing whitespace in the value
                    else if (stream.type == SelectorToken.Str)
                        value += stream.value.replace(/^"(.*)"|'(.*)'$/sgi, "$1$2");
                    else
                        value += stream.value;
                                
                }
                
                var operator:AttributeOperator = new AttributeOperatorType(value);
            }
            
            stream.ignore(SelectorToken.Whitespace)
                  .expect(SelectorToken.AttributeEnd);
            
            return new AttributeSelector(name, operator, namespace);
        }
	}
}