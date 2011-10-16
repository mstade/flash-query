package se.stade.flash.dom.querying.css.selectors
{
    import flash.display.DisplayObject;
    
    import se.stade.flash.dom.querying.ElementMatcher;

    public class SelectorGroup implements Selector
    {
        public static function named(name:String, selector:ElementMatcher, ...selectors):SelectorGroup
        {
            var list:Vector.<ElementMatcher> = Vector.<ElementMatcher>([selector].concat(selectors));
            var sequence:SelectorGroup = new SelectorGroup(list);
            sequence.name = name;
            
            return sequence;
        }
        
        public static function from(selector:ElementMatcher, ...selectors):SelectorGroup
        {
            selectors = [selector].concat(selectors);
            return named.apply(null, [selectors.join("")].concat(selectors));
        }
        
        public function SelectorGroup(selectors:Vector.<ElementMatcher>)
        {
            this.selectors = selectors || new Vector.<ElementMatcher>;
            this.name = this.selectors.join(", ");
        }
        
        private var name:String;
        private var selectors:Vector.<ElementMatcher>;
        
        public function matches(element:DisplayObject):Boolean
        {
            for each (var selector:ElementMatcher in selectors)
            {
                if (selector.matches(element))
                    return true;
            }
            
            return false;
        }
        
        public function toString():String
        {
            return name;
        }
    }
}
