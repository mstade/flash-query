package se.stade.flash.dom.query.css.parsing.tokens
{
	import se.stade.flash.dom.query.parsing.StringToken;
	
	public class IdentToken extends StringToken
	{
		public function IdentToken(index:int, match:String)
		{
			super(index, match);
		}
	}
}