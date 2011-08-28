package se.stade.flash.dom.querying.css.selectors.attributes
{
	import avmplus.getQualifiedClassName;
	
	import flash.display.DisplayObject;
	
	import se.stade.babbla.formatting.format;
	import se.stade.flash.dom.querying.ElementMatcher;
	import se.stade.flash.dom.querying.css.selectors.attributes.operators.AnyAttribute;
	import se.stade.flash.dom.querying.css.selectors.attributes.operators.AttributeOperator;
	import se.stade.flash.dom.querying.css.selectors.type.NamespaceSelector;
	import se.stade.parsing.Expression;

	public class AttributeSelector implements ElementMatcher, Expression
	{
		public function AttributeSelector(name:String, operator:AttributeOperator = null, namespace:ElementMatcher = null)
		{
			this.name = name;
			this.operator = operator || AnyAttribute.instance;
			this.namespace = namespace || NamespaceSelector.Any;
            
            selector = format("[{name}{operator}]", {
               name: (namespace || "") + name,
               operator: operator || ""
            });
		}
		
		private var name:String;
        private var selector:String;
		private var namespace:ElementMatcher;
		private var operator:AttributeOperator;
		
		public function matches(element:DisplayObject):Boolean
		{
            try
            {
                var value:*;
                
                if (namespace)
                {
                    var className:String = getQualifiedClassName(element).replace("::", ":");
                    var ns:Namespace = new Namespace(className + "/" + String(namespace).slice(0, -1));
                    value = element.ns::[name];
                }
                else
                    value = element[name];
                
                return operator.matches(value);
            }
            catch (e:Error)
            {
                return false;
            }
			
			return false;
		}
		
		public function toString():String
		{
            return selector;
		}
	}
}