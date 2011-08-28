package se.stade.flash.dom.traversals
{
    import flash.display.DisplayObject;
    
    import flexunit.framework.Assert;
    
    import org.flexunit.assertThat;
    import org.hamcrest.core.isA;
    
    import spark.components.Button;
    import spark.components.Group;
    
    public class AncestorTraversalTest extends TraversalTest
    {		
        private var traverser:AncestorTraversal;
        
        [Before]
        public function setUp():void
        {
            var dom:Object = createDOM(); 
            var start1:DisplayObject = dom.getElementAt(2).getElementAt(0).getElementAt(0);
            var start2:DisplayObject = dom.getElementAt(2).getElementAt(1).getElementAt(0);
            
            traverser = new AncestorTraversal(new <DisplayObject>[start1, start2]);
        }
        
        [Test]
        public function shouldReturnAncestorsForBothStarts():void
        {
            assertThat(traverser.getNext(), isA(Group));
            assertThat(traverser.getNext(), isA(Group));
            assertThat(traverser.getNext(), isA(Group));
            
            assertThat(traverser.getNext(), isA(Group));
            assertThat(traverser.getNext(), isA(Group));
            assertThat(traverser.getNext(), isA(Group));
        }
        
        [Test]
        public function shouldReturnHasNextSixTimes():void
        {
            assertHasNext(traverser, 6);
        }
        
        [Test]
        public function shouldReturnHasNextSixTimesAfterReset():void
        {
            assertReset(traverser, 6);
        }
    }
}