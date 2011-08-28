package se.stade.flash.dom.traversals
{
    import flash.display.DisplayObject;
    
    import flexunit.framework.Assert;
    
    import org.flexunit.assertThat;
    import org.hamcrest.core.isA;
    
    import spark.components.ButtonBar;
    import spark.components.CheckBox;
    import spark.components.Scroller;
    
    public class FollowingSiblingTraversalTest extends TraversalTest
    {		
        private var traverser:FollowingSiblingTraversal;
        
        [Before]
        public function setUp():void
        {
            var dom:Object = createDOM(); 
            var start1:DisplayObject = dom.getElementAt(2).getElementAt(0).getElementAt(0);
            var start2:DisplayObject = dom.getElementAt(2).getElementAt(1).getElementAt(0);
            
            traverser = new FollowingSiblingTraversal(new <DisplayObject>[start1, start2]);
        }
        
        [Test]
        public function shouldReturnCheckBoxAndScroller():void
        {
            assertThat(traverser.getNext(), isA(ButtonBar));
            assertThat(traverser.getNext(), isA(Scroller));
        }
        
        [Test]
        public function shouldReturnHasNextTwice():void
        {
            assertHasNext(traverser, 2);
        }
        
        [Test]
        public function shouldReturnHasNextTwiceAfterReset():void
        {
            assertReset(traverser, 2);
        }
    }
}