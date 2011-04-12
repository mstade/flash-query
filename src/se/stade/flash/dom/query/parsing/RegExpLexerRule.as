package se.stade.flash.dom.query.parsing
{
	public class RegExpLexerRule implements LexerRule
	{
		public function RegExpLexerRule(expression:RegExp, TokenClass:Class)
		{
			this.TokenClass = TokenClass;
			this.expression = expression;
		}
		
		protected var expression:RegExp;
		protected var lastMatch:Array;
		
		public function matches(input:String, position:int, minLength:int):Boolean
		{
			expression.lastIndex = position;
			lastMatch = expression.exec(input);
			
			return (lastMatch && lastMatch.index == position && lastMatch[0].length >= minLength)
		}
		
		private var TokenClass:Class;
		public function apply():Token
		{
			return lastMatch ? new TokenClass(lastMatch.index, lastMatch[0]) : null;
		}
	}
}