package se.stade.flash.dom.querying.css.selectors.type
{
    import flash.display.DisplayObject;
    
    import se.stade.babbla.formatting.format;
    import se.stade.daffodil.types.TypeReflection;
    import se.stade.flash.dom.querying.ElementMatcher;
    import se.stade.parsing.Expression;

    internal class ElementSelectorBase implements ElementMatcher, Expression
    {
        public function ElementSelectorBase(selector:String, name:String, namespace:ElementMatcher = null)
        {
            this.name = name || "*";
            this.namespace = namespace || NamespaceSelector.Any;
            
            this.selector = format(selector || "{type}", {
                type: (namespace && name) ? namespace + name  :
                              (namespace) ? String(namespace) :
                                   (name) ? name : "*"
            });
        }
        
        private var selector:String;
        
        protected var name:String;
        protected var reflection:TypeReflection;
        protected var namespace:ElementMatcher;
        
        public final function matches(element:DisplayObject):Boolean
        {
            return namespace.matches(element) && reflection.on(element);
        }
        
        public final function toString():String
        {
            return selector;
        }
    }
}