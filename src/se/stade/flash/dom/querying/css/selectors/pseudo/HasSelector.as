package se.stade.flash.dom.querying.css.selectors.pseudo
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	import se.stade.flash.dom.querying.ElementMatcher;
	import se.stade.parsing.Expression;
    
    public class HasSelector implements ElementMatcher, Expression
    {
        public function HasSelector(child:ElementMatcher)
        {
            this.child = child;
        }
        
        private var child:ElementMatcher;
        
        public function matches(element:DisplayObject):Boolean
        {
            var parent:DisplayObjectContainer = element as DisplayObjectContainer;
            
            if (parent)
            {
                for (var i:int = 0; i < parent.numChildren; i++)
                {
                    if (child.matches(parent.getChildAt(i)))
                        return true;
                }
            }
            
            return false;
        }
        
        public function toString():String
        {
            return ":has(" + child + ")";
        }
    }
}