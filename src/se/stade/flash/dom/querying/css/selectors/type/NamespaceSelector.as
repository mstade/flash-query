package se.stade.flash.dom.querying.css.selectors.type
{
    import flash.display.DisplayObject;
    
    import se.stade.daffodil.Reflect;
    import se.stade.flash.dom.querying.css.selectors.Selector;
    
    public class NamespaceSelector implements Selector
    {
        public static const Any:NamespaceSelector = new NamespaceSelector("*");
        
        public function NamespaceSelector(name:String)
        {
            this.name = name || "*";
        }
        
        private var name:String;
        
        public function matches(element:DisplayObject):Boolean
        {
            if (name == "*")
                return true;
            
            return Reflect.first.type.inPackage(name).on(element);
        }
        
        public function toString():String
        {
            return name + "|";
        }
    }
}
