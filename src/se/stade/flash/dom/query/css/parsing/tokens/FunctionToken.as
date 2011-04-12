package se.stade.flash.dom.query.css.parsing.tokens
{
	import se.stade.flash.dom.query.parsing.StringToken;
	
	public class FunctionToken extends StringToken
	{
		public function FunctionToken(index:int, match:String)
		{
			super(index, match);
		}
	}
}