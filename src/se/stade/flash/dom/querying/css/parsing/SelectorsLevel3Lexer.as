package se.stade.flash.dom.querying.css.parsing
{
    import flash.utils.Dictionary;
    
    import se.stade.parsing.lexer.ConfigurableLexer;
    import se.stade.parsing.lexer.ExpressionLexemeFactory;
    import se.stade.parsing.lexer.Lexeme;
    
    public class SelectorsLevel3Lexer extends ConfigurableLexer
    {
        public function SelectorsLevel3Lexer()
        {
            initialize();
        }
        
        private var lexemeFactory:ExpressionLexemeFactory;
        
        private function initialize():void
        {
            var definitions:Object = {
                nmstart:    "[_a-z]",
                nmchar:     "[_a-z0-9-]",
                name:       "{nmchar}+",
                ident:      "{nmstart}{nmchar}*",
                nonascii:   "[^\\0-\\177]",
                w:          "[ \\t\\r\\n\\f]",
                nl:         "\\n|\\r\\n|\\r|\\f",
                num:        "[0-9]+|[0-9]*\\.[0-9]+",
                unicode:    "[0-9a-f]{1,6}(?:{nl}|{w})?",
                escape:     "{unicode}|[^\\n\\r\\f0-9a-f]",
                string1:    '"([^\\n\\r\\f\"]|{nl}|{nonascii}|{escape})*"',
                string2:    "'([^\\n\\r\\f\']|{nl}|{nonascii}|{escape})*'"
            };
            
            var tokens:Dictionary = new Dictionary;
            tokens[SelectorToken.Id]             = "\\#{name}+";
            tokens[SelectorToken.Num]            = "{num}";
            tokens[SelectorToken.Str]            = "{string1}|{string2}";
            tokens[SelectorToken.Name]           = "\\*|{ident}";
            tokens[SelectorToken.Class]          = "\\.{name}(\\.{name})*";
            tokens[SelectorToken.AttributeStart] = "\\[";
            tokens[SelectorToken.AttributeEnd]   = "\\]";
            tokens[SelectorToken.Namespace]      = "({ident}(?:\\.{ident})*|\\*)?\\|";
            tokens[SelectorToken.Whitespace]     = "{w}+";
            
            tokens[SelectorToken.Equals]         = "{w}*={w}*";
            tokens[SelectorToken.IsOneOf]        = "{w}*~={w}*";
            tokens[SelectorToken.Contains]       = "{w}*\\*={w}*";
            tokens[SelectorToken.BeginsWith]     = "{w}*\\^={w}*";
            tokens[SelectorToken.EndsWith]       = "{w}*\\$={w}*";
            tokens[SelectorToken.Group]          = "{w}*,{w}*";
            tokens[SelectorToken.Child]          = "{w}*>{w}*";
            tokens[SelectorToken.Sibling]        = "{w}*(<~|~>|<\\+|\\+>|~|\\+){w}*";
            tokens[SelectorToken.Dimension]      = "{num}{name}";
            tokens[SelectorToken.Percentage]     = "{num}%";
            
            tokens[SelectorToken.Function]       = ":{ident}\\(";
            tokens[SelectorToken.FunctionEnd]    = "\\)";
            tokens[SelectorToken.PseudoClass]    = ":{ident}";
            
            lexemeFactory = new ExpressionLexemeFactory(definitions);
            
            for (var type:String in tokens)
            {
                var lexeme:Lexeme = lexemeFactory.create(type, tokens[type]);
                setLexeme(type, lexeme);
            }
        }
    }
}