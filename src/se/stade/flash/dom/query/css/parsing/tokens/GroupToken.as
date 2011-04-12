package se.stade.flash.dom.query.css.parsing.tokens
{
	import se.stade.stilts.string.formatting.utils.trim;
	import se.stade.flash.dom.query.parsing.StringToken;
	
	public class GroupToken extends StringToken
	{
		public function GroupToken(index:int, match:String)
		{
			match = trim(match);
			super(index, match);
		}
	}
}