package se.stade.flash.dom.querying.css.selectors.type
{
    import flash.display.DisplayObject;
    
    import se.stade.flash.dom.querying.ElementMatcher;
    import se.stade.parsing.Expression;
    
    public class UniversalSelector implements ElementMatcher, Expression
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