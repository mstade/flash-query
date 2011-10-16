package se.stade.flash.dom
{
    import flash.display.DisplayObject;
    import flash.events.IEventDispatcher;

    public interface DisplayNode extends IEventDispatcher
    {
        function get element():*;
        
        function get index():int;
        
        function get parent():DisplayNode;
        
        function get children():DisplayNodeList;
        
        function get prevSiblings():DisplayNodeList;
        function get nextSiblings():DisplayNodeList;
    }
}
