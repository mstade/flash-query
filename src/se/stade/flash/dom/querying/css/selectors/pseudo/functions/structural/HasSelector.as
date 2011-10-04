package se.stade.flash.dom.querying.css.selectors.pseudo.functions.structural
{
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    
    import se.stade.flash.dom.querying.ElementMatcher;
    import se.stade.parsing.Expression;
    import se.stade.flash.dom.querying.css.selectors.pseudo.functions.PseudoFunctionBase;
    
    public class HasSelector extends PseudoFunctionBase implements ElementMatcher, Expression
    {
        public static const Name:String = "has";
        
        public function HasSelector(expression:ElementMatcher)
        {
            super(Name, String(expression));
            this.expression = expression;
        }
        
        private var expression:ElementMatcher;
        
        public function matches(element:DisplayObject):Boolean
        {
            var parent:DisplayObjectContainer = element as DisplayObjectContainer;
            
            if (parent)
            {
                for (var i:int = 0; i < parent.numChildren; i++)
                {
                    var child:DisplayObject = parent.getChildAt(i);
                    
                    if (expression.matches(child))
                        return true;
                }
            }
            
            return false;
        }
    }
}