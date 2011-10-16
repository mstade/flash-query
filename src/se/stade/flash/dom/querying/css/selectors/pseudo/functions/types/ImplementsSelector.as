package se.stade.flash.dom.querying.css.selectors.pseudo.functions.types
{
    import flash.display.DisplayObject;
    
    import se.stade.daffodil.Reflect;
    import se.stade.daffodil.Reflection;
    import se.stade.flash.dom.querying.css.selectors.Selector;
    import se.stade.flash.dom.querying.css.selectors.pseudo.functions.PseudoFunctionBase;
    
    public class ImplementsSelector extends PseudoFunctionBase implements Selector
    {
        public static const Name:String = "impl";
        
        public function ImplementsSelector(innerface:String)
        {
            super(Name, innerface);
            reflection = Reflect.first.type.implementing(innerface);
        }
        
        private var reflection:Reflection;
        
        public function matches(element:DisplayObject):Boolean
        {
            return reflection.on(element);
        }
    }
}
