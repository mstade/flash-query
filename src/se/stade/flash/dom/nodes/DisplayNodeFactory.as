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
        
        private static const cache:Dictionary = new Dictionary(true);
        
        public static function from(element:*):DisplayNode
        {
            if (element in cache)
            {
                return cache[element];
            }
            
            var node:DisplayNode;
            
            if (IVisualElementContainer && element is IVisualElementContainer)
            {
                node = new VisualElementContainerNode(element);
            }
            else if (IVisualElement && element is IVisualElement)
            {
                node = new VisualElementNode(element);
            }
            else if (element is DisplayObjectContainer)
            {
                node = new DisplayObjectContainerNode(element as DisplayObjectContainer);
            }
            else if (element is DisplayObject)
            {
                node = new DisplayObjectNode(element as DisplayObject);
            }
            else
            {
                return null;
            }
            
            cache[element] = node;
            return node;
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
