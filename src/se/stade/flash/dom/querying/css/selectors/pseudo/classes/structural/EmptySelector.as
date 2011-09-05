package se.stade.flash.dom.querying.css.selectors.pseudo.classes.structural
{
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    
    import se.stade.flash.dom.querying.ElementMatcher;
    import se.stade.flash.dom.querying.css.selectors.pseudo.classes.PseudoClassBase;
    import se.stade.parsing.Expression;
    
    public class EmptySelector extends PseudoClassBase implements ElementMatcher, Expression
    {
        public static const Name:String = "empty";
        
        public function EmptySelector()
        {
            super(Name);
        }
        
        public function matches(element:DisplayObject):Boolean
        {
            var container:DisplayObjectContainer = element as DisplayObjectContainer;
            
            if (container)
                return container.numChildren == 0;
            
            return true;
        }
    }
}