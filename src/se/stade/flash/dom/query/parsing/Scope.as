package se.stade.flash.dom.query.parsing
{
	public final class Scope
	{
		public function Scope(start:int, end:int)
		{
			_start = start;
			_end = end;
		}
		
		private var _start:int;
		public function get start():int
		{
			return _start;
		}
		
		private var _end:int;
		public function get end():int
		{
			return _end;
		}
	}
}