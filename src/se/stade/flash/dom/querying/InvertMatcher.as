package se.stade.flash.dom.querying
{
    import flash.display.DisplayObject;
    
    public class InvertMatcher implements ElementMatcher
    {
        public static function from(matcher:ElementMatcher):InvertMatcher
        {
            return new InvertMatcher(matcher);
        }
        
        public function InvertMatcher(matcher:ElementMatcher)
        {
            this.matcher = matcher;
        }
        
        private var matcher:ElementMatcher;
        
        public function matches(element:DisplayObject):Boolean
        {
            return !matcher.matches(element);
        }
    }
}
