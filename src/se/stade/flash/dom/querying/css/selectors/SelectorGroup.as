package se.stade.flash.dom.querying.css.selectors
{
	import flash.display.DisplayObject;
	
	import se.stade.flash.dom.querying.ElementMatcher;
	import se.stade.parsing.Expression;

	public class SelectorGroup implements ElementMatcher, Expression
	{
        public static function Named(name:String, selector:ElementMatcher, ...selectors):SelectorGroup
        {
            var list:Vector.<ElementMatcher> = Vector.<ElementMatcher>([selector].concat(selectors));
            var sequence:SelectorGroup = new SelectorGroup(list);
            sequence.name = name;
            
            return sequence;
        }
        
        public static function Sequence(selector:ElementMatcher, ...selectors):SelectorGroup
        {
            selectors = [selector].concat(selectors);
            return Named.apply(null, [selectors.join("")].concat(selectors));
        }
        
        public function SelectorGroup(selectors:Vector.<ElementMatcher>)
        {
            this.selectors = selectors || new Vector.<ElementMatcher>;
            this.name = this.selectors.join(", ");
        }
        
        private var name:String;
        private var matchAny:Boolean = true;
        private var selectors:Vector.<ElementMatcher>;
		
		public function matches(element:DisplayObject):Boolean
		{
            if (matchAny)
            {
                for each (var selector:ElementMatcher in selectors)
                {
                    if (selector.matches(element))
                        return true;
                }
                
                return false;
            }
            else
            {
                for each (selector in selectors)
                {
                    if (!selector.matches(element))
                        return false;
                }
                
                return true;
            }
		}
		
		public function toString():String
		{
            return name;
		}
	}
}