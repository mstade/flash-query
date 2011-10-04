package se.stade.flash.dom
{
    public interface DisplayNodeList
    {
        function get length():uint;
        
        function itemAt(index:int):DisplayNode;
        
        function has(node:DisplayNode):Boolean;
        function indexOf(node:DisplayNode):int;
        
        function append(node:DisplayNode):DisplayNode;
        function insert(node:DisplayNode, index:int):DisplayNode;
        function replace(oldNode:DisplayNode, newNode:DisplayNode):DisplayNode; 
        function remove(node:DisplayNode):DisplayNode;
    }
}