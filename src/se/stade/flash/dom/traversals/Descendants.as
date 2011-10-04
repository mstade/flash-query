package se.stade.flash.dom.traversals
{
    import se.stade.flash.dom.DisplayNode;
    
    public class Descendants extends DepthFirst
    {
        public static function of(nodes:Vector.<DisplayNode>):Descendants
        {
            return new Descendants(nodes);
        }
        
        public function Descendants(nodes:Vector.<DisplayNode>)
        {
            var children:Children = Children.of(nodes);
            
            var start:Vector.<DisplayNode> = new Vector.<DisplayNode>;
            while (children.hasNext)
            {
                start.push(children.getNext());
            }
            
            super(start);
        }
    }
}