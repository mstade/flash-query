package se.stade.flash.dom.nodes
{
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.events.Event;
    import flash.events.EventPhase;
    import flash.events.IEventDispatcher;
    import flash.utils.Dictionary;
    import flash.utils.getDefinitionByName;
    
    import se.stade.daffodil.define;
    import se.stade.flash.dom.DisplayNode;

    public final class DisplayNodeFactory
    {
        private static const IVisualElement:Class           = define("mx.core.IVisualElement");
        private static const IVisualElementContainer:Class  = define("mx.core.IVisualElementContainer");
        
        public static function from(element:IEventDispatcher):DisplayNode
        {
            if (IVisualElementContainer && element is IVisualElementContainer)
            {
                return new VisualElementContainerNode(element);
            }
            else if (IVisualElement && element is IVisualElement)
            {
                return new VisualElementNode(element);
            }
            else if (element is DisplayObjectContainer)
            {
                return new DisplayObjectContainerNode(element as DisplayObjectContainer);
            }
            else if (element is DisplayObject)
            {
                return new DisplayObjectNode(element as DisplayObject);
            }
            else
            {
                return null;
            }
        }
        
        public static function list(element:DisplayObject, ... elements):Vector.<DisplayNode>
        {
            elements = [element].concat(elements);
            return convert(Vector.<DisplayObject>(elements));
        }
        
        public static function convert(elements:Vector.<DisplayObject>):Vector.<DisplayNode>
        {
            var list:Vector.<DisplayNode> = new <DisplayNode>[];
            
            for each (var element:DisplayObject in elements)
            {
                list.push(from(element));
            }
            
            return list;
        }
    }
}