package se.stade.flash.dom.querying.css.selectors.pseudo.functions.types
{
    import flash.display.DisplayObject;
    
    import se.stade.daffodil.Reflect;
    import se.stade.daffodil.Reflection;
    import se.stade.flash.dom.querying.ElementMatcher;
    import se.stade.flash.dom.querying.css.selectors.pseudo.functions.PseudoFunctionBase;
    
    public class ExtendsSelector extends PseudoFunctionBase implements ElementMatcher
    {
        public static const Name:String = "ext";
        
        public function ExtendsSelector(base:String)
        {
            super(Name, base);
            reflection = Reflect.first.type.extending(base);
        }
        
        private var reflection:Reflection;
        
        public function matches(element:DisplayObject):Boolean
        {
            return reflection.on(element);
        }
    }
}