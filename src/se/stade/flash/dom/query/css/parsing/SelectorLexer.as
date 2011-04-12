package se.stade.flash.dom.query.css.parsing
{
	import se.stade.flash.dom.query.css.parsing.tokens.AttributeValueToken;
	import se.stade.flash.dom.query.css.parsing.tokens.CombinatorToken;
	import se.stade.flash.dom.query.css.parsing.tokens.DimensionToken;
	import se.stade.flash.dom.query.css.parsing.tokens.FunctionEndToken;
	import se.stade.flash.dom.query.css.parsing.tokens.FunctionToken;
	import se.stade.flash.dom.query.css.parsing.tokens.GroupToken;
	import se.stade.flash.dom.query.css.parsing.tokens.HashToken;
	import se.stade.flash.dom.query.css.parsing.tokens.IdentToken;
	import se.stade.flash.dom.query.css.parsing.tokens.InvalidToken;
	import se.stade.flash.dom.query.css.parsing.tokens.NegationToken;
	import se.stade.flash.dom.query.css.parsing.tokens.NumberToken;
	import se.stade.flash.dom.query.css.parsing.tokens.PercentageToken;
	import se.stade.flash.dom.query.css.parsing.tokens.StringLiteralToken;
	import se.stade.flash.dom.query.css.parsing.tokens.WhitespaceToken;
	import se.stade.flash.dom.query.parsing.GreedyLexer;
	import se.stade.flash.dom.query.parsing.Lexer;
	import se.stade.flash.dom.query.parsing.LexerConfiguration;
	import se.stade.flash.dom.query.parsing.RegExpConfiguration;
	import se.stade.flash.dom.query.parsing.TokenStream;
	
	public class SelectorLexer implements Lexer
	{
		public function SelectorLexer()
		{
			lexer = new GreedyLexer(getConfiguration());
		}
		
		private var lexer:GreedyLexer;
		
		public function scan(stream:*):TokenStream
		{
			var tokens:TokenStream = lexer.scan(stream);
			return tokens;
		}
		
		protected function getConfiguration():LexerConfiguration
		{
			var configuration:RegExpConfiguration = new RegExpConfiguration();
			
			with (configuration)
			{
				addRule(WhitespaceToken,			/{w}+/);
				addRule(AttributeValueToken,		/~=/);
				addRule(AttributeValueToken,		/\^=/);
				addRule(AttributeValueToken,		/\$=/);
				addRule(AttributeValueToken,		/\*=/);
				
				addRule(IdentToken,					/{ident}/);
				addRule(StringLiteralToken,			/{string}/);
				addRule(FunctionToken,				/{ident}\( {w}*/);
				addRule(FunctionEndToken,			/{w}* \)/);
				addRule(NumberToken,				/{num}/);
				addRule(HashToken,					/\#{name}/);
				
				addRule(GroupToken,					/{w}* \, {w}*/);
				addRule(CombinatorToken,			/{w}* ( \+ | \> | \~) {w}*/);
				
				addRule(NegationToken,				/:not\( {w}*/);
				addRule(InvalidToken,				/{invalid}/);
				addRule(PercentageToken,			/{num}%/);
				addRule(DimensionToken,				/{num}{ident}/);
				
				setDefinitions(
				{
					ident:		/[-]?{nmstart}{nmchar}*/,
					name:		/{nmchar}+/,
					nmstart:	/[_a-z] | {nonascii} | {escape}/,
					nonascii:	/[^\0-\177]/,
					unicode:	/\\[0-9a-f]{1,6}(?: \r\n|[ \t\r\n\f] )?/,
					escape:		/{unicode}|\\[^\n\r\f0-9a-f]/,
					nmchar:		/[_a-z0-9-]|{nonascii}|{escape}/,
					num:		/[0-9]+|[0-9]*\.[0-9]+/,
					string:		/{string1}|{string2}/,
					string1:	/{invalid1}\"/,
					string2:	/{invalid2}\'/,
					invalid:	/{invalid1}|{invalid2}/,
					invalid1:	/\"( [^\n\r\f\\"]|\\{nl}|{nonascii}|{escape} )*/,
					invalid2:	/\'( [^\n\r\f\\']|\\{nl}|{nonascii}|{escape} )*/,
					nl:			/\n|\r\n|\r|\f/,
					w:			/[ \t\r\n\f]/
				});
			}
			
			return configuration;
		}
	}
}