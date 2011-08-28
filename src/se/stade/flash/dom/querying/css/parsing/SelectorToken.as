package se.stade.flash.dom.querying.css.parsing
{
    public class SelectorToken
    {
        public static const Id:String               = "id";
        public static const Num:String              = "num";
        public static const Str:String              = "str";
        public static const Name:String             = "name";
        public static const Class:String            = "class";
        public static const AttributeStart:String   = "attributeStart";
        public static const AttributeEnd:String     = "attributeEnd";
        public static const Namespace:String        = "namespace";
        public static const Whitespace:String       = "whitespace";
        
        public static const Equals:String           = "equals";
        public static const IsOneOf:String          = "isOneOf";
        public static const Contains:String         = "contains";
        public static const BeginsWith:String       = "beginsWith";
        public static const EndsWith:String         = "endsWith";
        
        public static const Group:String            = "group";
        public static const Child:String            = "child";
        public static const Sibling:String          = "sibling";
        
        public static const Dimension:String        = "dimension";
        public static const Percentage:String       = "percentage";
        
        public static const Function:String         = "function";
        public static const FunctionEnd:String      = "functionEnd";
        
        // Pseudo selector tokens
        public static const Not:String              = ":not";
        public static const Has:String              = ":has";
        public static const Extends:String          = ":extd";
        public static const Implements:String       = ":impl";
        public static const PseudoClass:String      = ":class";
    }
}