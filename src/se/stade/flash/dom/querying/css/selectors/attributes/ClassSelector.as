package se.stade.flash.dom.querying.css.selectors.attributes
{
    import flash.display.DisplayObject;
    import flash.utils.Dictionary;
    
    import se.stade.flash.dom.querying.ElementMatcher;
    import se.stade.parsing.Expression;
    
    public class ClassSelector implements ElementMatcher, Expression
    {
        private static const StyleName:String = "styleName";
        
        public function ClassSelector(names:Array)
        {
            selector = getSelector(names);
        }
        
        private var selector:String;
        
        private function getSelector(names:Array):String
        {
            var styleSet:Dictionary = new Dictionary;
            var sortedNames:Array = [];
            
            for each (var name:String in names)
            {
                if (name in styleSet)
                    continue;
                
                styleSet[name] = name;
                sortedNames.push(name);
            }
            
            sortedNames.sort();
            return "." + sortedNames.join(".");
        }
        
        public function matches(element:DisplayObject):Boolean
        {
            if (StyleName in element && element[StyleName] is String)
            {
                var names:Array = String(element[StyleName]).split(" ");
                return getSelector(names).indexOf(selector) >= 0;
            }
            
            return false;
        }
        
        public function toString():String
        {
            return selector;
        }
    }
}