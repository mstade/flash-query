package se.stade.flash.dom.traversals
{
    import flash.display.DisplayObject;
    
    import org.flexunit.assertThat;
    import org.hamcrest.core.isA;
    
    import se.stade.flash.dom.nodes.DisplayNodeFactory;
    
    import spark.components.Button;
    import spark.components.ButtonBar;
    import spark.components.CheckBox;
    import spark.components.Group;
    import spark.components.List;
    import spark.components.RadioButton;
    import spark.components.Scroller;
    
    public class DepthFirstTraversalTest extends TraversalTest
    {
        private var traverser:DepthFirst;
        
        [Before]
        public function setUp():void
        {
            traverser = new DepthFirst(DisplayNodeFactory.list(createDOM()));
        }
        
        [Test]
        public function shouldTraverseWholeDocument():void
        {
            assertThat(traverser.getNext().element, isA(Group))
            
            assertThat(traverser.getNext().element, isA(Button))
            assertThat(traverser.getNext().element, isA(List))
            
            assertThat(traverser.getNext().element, isA(Group))

            assertThat(traverser.getNext().element, isA(Group))
            assertThat(traverser.getNext().element, isA(CheckBox))
            assertThat(traverser.getNext().element, isA(ButtonBar))
            
            assertThat(traverser.getNext().element, isA(Group))
            assertThat(traverser.getNext().element, isA(RadioButton))
            assertThat(traverser.getNext().element, isA(Scroller))
        }
        
        [Test]
        public function shouldReturnHasNextTenTimes():void
        {
            assertHasNext(traverser, 10);
        }
        
        [Test]
        public function shouldReturnHasNextTenTimesAfterReset():void
        {
            assertReset(traverser, 10);
        }
    }
}