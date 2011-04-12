package se.stade.flash.dom.query.css.parsing.tokens
{
	import se.stade.flash.dom.query.parsing.StringToken;
	
	public class NumberToken extends StringToken
	{
		public function NumberToken(index:int, match:String)
		{
			super(index, match);
		}
	}
}