package se.stade.flash.dom.querying.css.parsing
{
    import se.stade.flash.dom.querying.ElementMatcher;
    import se.stade.flash.dom.querying.css.selectors.GroupSelector;
    import se.stade.parsing.Expression;
    import se.stade.parsing.Language;
    import se.stade.parsing.TokenStream;
    import se.stade.parsing.pratt.ExpressionParser;
    import se.stade.parsing.pratt.Parser;
    import se.stade.parsing.pratt.PrefixRule;
    import se.stade.stilts.string.trim;
    
    public final class SelectorsLevel3 implements Language
    {
        public function SelectorsLevel3()
        {
            lexer = new SelectorsLevel3Lexer;
            grammar = new SelectorsLevel3Grammar;
            parser = new ExpressionParser(grammar);
        }
        
        private var lexer:SelectorsLevel3Lexer;
        private var grammar:SelectorsLevel3Grammar;
        private var parser:Parser;
        
        public function parse(input:String):Expression
        {
            input = trim(input);
            var tokens:TokenStream = lexer.scan(input);
            
            var selectors:Vector.<ElementMatcher> = new <ElementMatcher>[];
            
            while (tokens.peek)
            {
                if (selectors.length > 0)
                    tokens.expect(SelectorToken.Group);
                
                selectors.push(parser.interpret(tokens, 0));
            }
            
            if (selectors.length > 1)
                return new GroupSelector(selectors);
            else
                return Expression(selectors[0]);
        }
        
        public function setPseudoClass(name:String, SelectorType:Class):void
        {
            grammar.simpleSelector.setPseudoClass(name, SelectorType);
        }
        
        public function setPseudoFunction(name:String, SelectorType:Class):void
        {
            grammar.simpleSelector.setPseudoFunction(name, SelectorType);
        }
        
        public function setPseudoExpression(name:String, parameterParser:PrefixRule):void
        {
            grammar.simpleSelector.setPseudoExpression(name, parameterParser);
        }
    }
}