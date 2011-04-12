package se.stade.flash.dom.query.css.parsing.tokens
{
	import se.stade.flash.dom.query.parsing.StringToken;
	
	public class WhitespaceToken extends StringToken
	{
		public function WhitespaceToken(index:int, match:String)
		{
			super(index, match);
		}
	}
}