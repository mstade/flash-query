package se.stade.flash.dom.querying.css.selectors.pseudo.functions.structural
{
    import flash.display.DisplayObject;
    
    import se.stade.babbla.formatting.format;
    import se.stade.flash.dom.querying.ElementMatcher;
    import se.stade.parsing.Expression;
    import se.stade.flash.dom.querying.css.selectors.pseudo.functions.PseudoFunctionBase;
    
    public class NthChildOfTypeSelector extends PseudoFunctionBase implements ElementMatcher, Expression
    {
        public static const Name:String = "nth-of-type";
        
        public function NthChildOfTypeSelector(type:ElementMatcher, a:int, b:int)
        {
            super(Name, format("{0}n+{1}", a, b));
            
            this.type = type;
            this.a = a;
            this.b = b;
        }
        
        private var type:ElementMatcher
        private var a:int;
        private var b:int;
        
        public function matches(element:DisplayObject):Boolean
        {
            if (!type)
                return false;
            
            if (type.matches(element) && element.parent)
            {
                try
                {
                    var children:Vector.<DisplayObject> = new <DisplayObject>[];
                    
                    for (var i:int = 0; i < element.parent.numChildren; i++)
                    {
                        var child:DisplayObject = element.parent.getChildAt(i);
                        
                        if (child == element)
                            children.push(child);
                        else if (type.matches(child))
                            children.push(child);
                    }
                    
                    var index:int = children.indexOf(element);
                    return isNth(a, b, index);
                }
                catch (error:SecurityError)
                {
                    return false;
                }
            }
            
            return false;
        }
    }
}