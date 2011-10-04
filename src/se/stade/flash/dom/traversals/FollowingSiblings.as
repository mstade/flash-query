package se.stade.flash.dom.traversals
{
    import se.stade.flash.dom.DisplayNode;
    
    public class FollowingSiblings extends Linear
    {
        public static function of(nodes:Vector.<DisplayNode>):FollowingSiblings
        {
            return new FollowingSiblings(nodes);
        }
        
        public function FollowingSiblings(nodes:Vector.<DisplayNode>)
        {
            var siblings:Vector.<DisplayNode> = new <DisplayNode>[];
            
            for each (var node:DisplayNode in nodes)
            {
                var firstSibling:int = node.index + 1;
                var parent:DisplayNode = node.parent;
                
                for (var i:int = firstSibling; i < parent.children.length; i++)
                {
                    siblings.push(parent.children.itemAt(i));
                }
            }
            
            super(siblings);
        }
    }
}