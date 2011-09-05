package se.stade.flash.dom.querying.css.selectors.type
{
    import flash.display.DisplayObject;
    
    import se.stade.babbla.formatting.format;
    import se.stade.daffodil.types.TypeReflection;
    import se.stade.flash.dom.querying.ElementMatcher;
    import se.stade.parsing.Expression;

    internal class ElementSelectorBase implements ElementMatcher, Expression
    {
        public function ElementSelectorBase(selector:String, type:String, namespace:ElementMatcher = null)
        {
            this.type = type || "*";
            this.namespace = namespace || NamespaceSelector.Any;
            
            this.selector = format(selector || "{type}", {
                type: (namespace && type) ? namespace + type  :
                              (namespace) ? String(namespace) :
                                   (type) ? type : "*"
            });
        }
        
        private var selector:String;
        
        protected var type:String;
        protected var reflection:TypeReflection;
        protected var namespace:ElementMatcher;
        
        public final function matches(element:DisplayObject):Boolean
        {
            return namespace.matches(element) && (type == "*" || reflection.on(element));
        }
        
        public final function toString():String
        {
            return selector;
        }
    }
}