package se.stade.flash.dom.traversals
{
    import flash.display.DisplayObject;
    
    import org.flexunit.assertThat;
    import org.hamcrest.core.isA;
    
    import se.stade.flash.dom.nodes.DisplayNodeFactory;
    
    import spark.components.ButtonBar;
    import spark.components.RadioButton;
    
    public class SiblingTraversalTest extends TraversalTest
    {       
        private var traverser:DisplayListTraversal;
        
        [Before]
        public function setUp():void
        {
            var dom:Object = createDOM(); 
            var start1:DisplayObject = dom.getElementAt(2).getElementAt(0).getElementAt(0);
            var start2:DisplayObject = dom.getElementAt(2).getElementAt(1).getElementAt(1);
            
            traverser = Siblings.fromListOf(DisplayNodeFactory.list(start1, start2), SiblingDirection.Both);
        }
        
        [Test]
        public function shouldReturnButtonBarAndRadioButton():void
        {
            assertThat(traverser.getNext().element, isA(ButtonBar));
            assertThat(traverser.getNext().element, isA(RadioButton));
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
