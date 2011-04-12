package se.stade.flash.dom.query.css.parsing.tokens
{
	import se.stade.stilts.string.formatting.utils.trim;
	import se.stade.flash.dom.query.parsing.StringToken;
	
	public class CombinatorToken extends StringToken
	{
		public static const Child:String = ">";
		public static const Descendant:String = " ";
		
		public static const Sibling:String = "~";
		public static const Adjacent:String = "+";
		
		public function CombinatorToken(index:int, match:String)
		{
			match = trim(match);
			super(index, match);
		}
	}
}