package se.stade.flash.dom.traversals
{
    import flash.display.DisplayObjectContainer;
    
    import org.flexunit.assertThat;
    import org.hamcrest.core.isA;
    
    import se.stade.flash.dom.nodes.DisplayNodeFactory;
    
    import spark.components.ButtonBar;
    import spark.components.CheckBox;
    import spark.components.RadioButton;
    import spark.components.Scroller;
    
    public class ImmediateChildTraversalTest extends TraversalTest
    {               
        private var traverser:Children;
        
        [Before]
        public function setUp():void
        {
            var dom:Object = createDOM(); 
            var root1:DisplayObjectContainer = dom.getElementAt(2).getElementAt(0);
            var root2:DisplayObjectContainer = dom.getElementAt(2).getElementAt(1);
            
            traverser = new Children(DisplayNodeFactory.list(root1, root2));
        }
        
        [Test]
        public function shouldReturnChildrenFromBothRoots():void
        {
            assertThat(traverser.getNext().element, isA(CheckBox));
            assertThat(traverser.getNext().element, isA(ButtonBar));
            
            assertThat(traverser.getNext().element, isA(RadioButton));
            assertThat(traverser.getNext().element, isA(Scroller));
        }
        
        [Test]
        public function shouldReturnHasNextFourTimes():void
        {
            assertHasNext(traverser, 4);
        }
        
        [Test]
        public function shouldReturnHasNextFourTimesAfterReset():void
        {
            assertReset(traverser, 4);
        }
    }
}