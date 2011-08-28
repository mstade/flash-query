package se.stade.flash.dom.traversals
{
    import flash.display.DisplayObject;
    
    import org.flexunit.assertThat;
    import org.hamcrest.core.isA;
    
    import spark.components.Button;
    import spark.components.ButtonBar;
    import spark.components.CheckBox;
    import spark.components.Group;
    import spark.components.List;
    import spark.components.RadioButton;
    import spark.components.Scroller;
    
    public class DepthFirstTraversalTest extends TraversalTest
    {
        private var traverser:DepthFirstTraversal;
        
        [Before]
        public function setUp():void
        {
            traverser = new DepthFirstTraversal(new <DisplayObject>[createDOM()]);
        }
        
        [Test]
        public function shouldTraverseWholeDocument():void
        {
            assertThat(traverser.getNext(), isA(Group))
            
            assertThat(traverser.getNext(), isA(Button))
            assertThat(traverser.getNext(), isA(List))
            
            assertThat(traverser.getNext(), isA(Group))

            assertThat(traverser.getNext(), isA(Group))
            assertThat(traverser.getNext(), isA(CheckBox))
            assertThat(traverser.getNext(), isA(ButtonBar))
            
            assertThat(traverser.getNext(), isA(Group))
            assertThat(traverser.getNext(), isA(RadioButton))
            assertThat(traverser.getNext(), isA(Scroller))
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