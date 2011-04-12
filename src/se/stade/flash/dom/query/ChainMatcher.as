package se.stade.flash.dom.query
{
	import flash.display.DisplayObject;
	
	public class ChainMatcher implements DisplayObjectMatcher
	{
		public static function FromList(matchers:Vector.<DisplayObjectMatcher>):DisplayObjectMatcher
		{
            switch (matchers.length)
            {
                case 0:
                    return null;
                case 1:
                    return matchers[0];
                default:
                    return new ChainMatcher(matchers);
            }
		}
		
		public function ChainMatcher(matchers:Vector.<DisplayObjectMatcher>)
		{
			selectors = matchers;
		}
		
		protected var selectors:Vector.<DisplayObjectMatcher>;
		
		public function matches(element:DisplayObject):Boolean
		{
			for each (var selector:DisplayObjectMatcher in selectors)
			{
				if (!selector.matches(element))
					return false;
			}
			
			return true;
		}
		
		public function toString():String
		{
			return selectors.join("");
		}
	}
}