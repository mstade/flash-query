package se.stade.flash.dom.querying
{
    import flash.display.DisplayObject;
    
    public class InvalidExpressionMatcher implements ElementMatcher
    {
        public static function from(expression:String):InvalidExpressionMatcher
        {
            return new InvalidExpressionMatcher(expression);
        }
        
        public function InvalidExpressionMatcher(expression:String):void
        {
            this.expression = expression;
        }
        
        private var expression:String;
        
        public function matches(element:DisplayObject):Boolean
        {
            return false;
        }
        
        public function toString():String
        {
            return "<<INVALID: " + expression + ">>";
        }
    }
}
