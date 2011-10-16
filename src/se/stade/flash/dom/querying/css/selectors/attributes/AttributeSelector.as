package se.stade.flash.dom.querying.css.selectors.attributes
{
    import flash.display.DisplayObject;
    import flash.system.ApplicationDomain;
    
    import se.stade.babbla.formatting.format;
    import se.stade.flash.dom.querying.css.selectors.Selector;
    import se.stade.flash.dom.querying.css.selectors.attributes.operators.AnyAttribute;
    import se.stade.flash.dom.querying.css.selectors.attributes.operators.AttributeOperator;

    public class AttributeSelector implements Selector
    {
        public function AttributeSelector(name:String,
                                          operator:AttributeOperator = null,
                                          ns:String = null)
        {
            this.name = name;
            this.operator = operator || AnyAttribute.Instance;
            
            if (ns && ns != "*")
            {
                try
                {
                    this.namespace = ApplicationDomain
                                     .currentDomain
                                     .getDefinition(ns) as Namespace;
                }
                catch (e:ReferenceError)
                {
                    this.namespace = null;
                }
            }
            else
                this.namespace = null;
            
            ns = ns ? ns + "|" : "";
            
            selector = format("[{name}{operator}]", {
               name: ns + name,
               operator: operator || ""
            });
        }
        
        private var name:String;
        private var selector:String;
        private var namespace:Namespace;
        private var operator:AttributeOperator;
        
        public function matches(element:DisplayObject):Boolean
        {
            if (namespace)
            {
                try
                {
                    var value:* = element.namespace::[name];
                    return operator.matches(value);
                }
                catch (e:Error)
                {
                    return false;
                }
            }
            
            value = element[name];
            return operator.matches(value);
        }
        
        public function toString():String
        {
            return selector;
        }
    }
}
