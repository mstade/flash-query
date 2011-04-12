package se.stade.flash.dom.query.css.parsing.tokens
{
	import se.stade.flash.dom.query.parsing.StringToken;
	
	public class AttributeValueToken extends StringToken
	{
		public static const Equals:String		= "=";
		public static const IsOneOf:String		= "~=";
		public static const Contains:String		= "*=";
		public static const EndsWith:String		= "$=";
		public static const BeginsWith:String	= "^=";
		
		public function AttributeValueToken(index:int, match:String)
		{
			super(index, match);
		}
	}
}