package se.stade.flash.dom.querying.css.selectors.type
{
    import flash.display.DisplayObject;
    
    import se.stade.flash.dom.querying.css.selectors.Selector;
    
    public class UniversalSelector implements Selector
    {
        public static const Instance:UniversalSelector = new UniversalSelector;
        
        public function matches(element:DisplayObject):Boolean
        {
            return true;
        }
        
        public function toString():String
        {
            return "*";
        }
    }
}
