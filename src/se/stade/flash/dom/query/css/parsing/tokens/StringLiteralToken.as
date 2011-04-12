package se.stade.flash.dom.query.css.parsing.tokens
{
	import se.stade.flash.dom.query.parsing.StringToken;
	
	public class StringLiteralToken extends StringToken
	{
		public function StringLiteralToken(index:int, match:String)
		{
			super(index, match);
		}
	}
}