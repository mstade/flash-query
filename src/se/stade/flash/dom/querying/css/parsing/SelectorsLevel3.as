package se.stade.flash.dom.querying.css.parsing
{
    import se.stade.flash.dom.querying.ElementMatcher;
    import se.stade.flash.dom.querying.css.parsing.rules.PseudoRuleCollection;
    import se.stade.flash.dom.querying.css.selectors.SelectorGroup;
    import se.stade.parsing.Expression;
    import se.stade.parsing.Language;
    import se.stade.parsing.TokenStream;
    import se.stade.parsing.pratt.ExpressionParser;
    import se.stade.parsing.pratt.Parser;
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
                return new SelectorGroup(selectors);
            else
                return Expression(selectors[0]);
        }
        
        public function get pseudoClasses():PseudoRuleCollection 
        {
            return grammar.simpleSelector.pseudoClasses;
        }
        
        public function get pseudoFunctions():PseudoRuleCollection
        {
            return grammar.simpleSelector.pseudoFunctions;
        }
    }
}