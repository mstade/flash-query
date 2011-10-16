package se.stade.flash.dom.querying.css.selectors.pseudo.classes.states
{
    import flash.display.DisplayObject;
    
    import se.stade.flash.dom.querying.css.selectors.Selector;
    import se.stade.flash.dom.querying.css.selectors.pseudo.classes.PseudoClassBase;
    
    public class PositiveStateSelector extends PseudoClassBase implements Selector
    {
        public function PositiveStateSelector(name:String)
        {
            super(name);
        }
        
        public function matches(element:DisplayObject):Boolean
        {
            return name in element && element[name];
        }
    }
}
