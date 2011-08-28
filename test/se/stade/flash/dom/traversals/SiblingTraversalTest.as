package se.stade.flash.dom.traversals
{
    import flash.display.DisplayObject;
    
    import flexunit.framework.Assert;
    
    import org.flexunit.assertThat;
    import org.hamcrest.core.isA;
    
    import spark.components.ButtonBar;
    import spark.components.RadioButton;
    
    public class SiblingTraversalTest extends TraversalTest
    {		
        private var traverser:SiblingTraversal;
        
        [Before]
        public function setUp():void
        {
            var dom:Object = createDOM(); 
            var start1:DisplayObject = dom.getElementAt(2).getElementAt(0).getElementAt(0);
            var start2:DisplayObject = dom.getElementAt(2).getElementAt(1).getElementAt(1);
            
            traverser = new SiblingTraversal(new <DisplayObject>[start1, start2]);
        }
        
        [Test]
        public function shouldReturnButtonBarAndRadioButton():void
        {
            assertThat(traverser.getNext(), isA(RadioButton));
            assertThat(traverser.getNext(), isA(ButtonBar));
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