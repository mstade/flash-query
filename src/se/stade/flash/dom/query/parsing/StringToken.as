package se.stade.flash.dom.query.parsing
{
	public class StringToken implements Token
	{
		public function StringToken(index:int, match:String)
		{
			_index = index;
			_match = match;
		}
		
		protected var _index:int;
		public function get index():int
		{
			return _index;
		}
		
		public function get length():uint
		{
			return _match.length;
		}
		
		protected var _match:String;
		public function get value():*
		{
			return _match;
		}
		
		public function toString():String
		{
			return "[Token: " + value + "]";
		}
	}
}