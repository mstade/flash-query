package se.stade.flash.dom.query.css.parsing.tokens
{
	import se.stade.flash.dom.query.parsing.StringToken;
	
	public class InvalidToken extends StringToken
	{
		public function InvalidToken(index:int, match:String)
		{
			super(index, match);
		}
	}
}