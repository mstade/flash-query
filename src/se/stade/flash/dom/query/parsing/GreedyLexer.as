package se.stade.flash.dom.query.parsing
{
	import flash.utils.Dictionary;
	
	import se.stade.stilts.string.formatting.format;

	public class GreedyLexer implements Lexer
	{
		public function GreedyLexer(configuration:LexerConfiguration)
		{
			this.configuration = configuration;
		}
		
		protected var configuration:LexerConfiguration;
		
		public function scan(stream:*):TokenStream
		{
			var input:String = String(stream);
			var tokens:Vector.<Token> = new <Token>[];
			var rules:Vector.<LexerRule> = configuration.getRules();
			
			if (!rules || rules.length == 0)
			{
				tokens.push(new StringToken(0, input));
				return new LastInFirstOutStream(tokens);
			}
			
			var position:int = 0;
			var unmatchedInput:String = "";
			
			while (position < input.length)
			{
				var suggestedMatch:Token = null;
				
				for each (var rule:LexerRule in rules)
				{
					var suggestedLength:int = suggestedMatch ? suggestedMatch.length + 1 : 1;
					
					if (rule.matches(input, position, suggestedLength))
						suggestedMatch = rule.apply();
				}
				
				if (suggestedMatch)
				{
					tokens.push(suggestedMatch);
					position += suggestedMatch.length;
				}
				else
				{
					tokens.push(new StringToken(position, input.charAt(position)));
					position++;
				}
			}
			
			return new LastInFirstOutStream(tokens);
		}
	}
}