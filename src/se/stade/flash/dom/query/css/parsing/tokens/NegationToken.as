package se.stade.flash.dom.query.css.parsing.tokens
{
	import se.stade.flash.dom.query.parsing.StringToken;
	
	public class NegationToken extends StringToken
	{
		public function NegationToken(index:int, match:String)
		{
			super(index, match);
		}
	}
}