package se.stade.flash.dom.events
{
    import flash.events.Event;
    import flash.events.EventDispatcher;
    
    import org.flexunit.assertThat;
    import org.flexunit.runners.Parameterized;
    import org.hamcrest.collection.hasItems;
    import org.hamcrest.object.equalTo;
    
    Parameterized;
    [RunWith("org.flexunit.runners.Parameterized")]
    public class SingleTargetBinderTest
    {
        private var target:EventDispatcher;
        private var events:SingleTargetBinder;
        
        [Before]
        public function setUp():void
        {
            target = new EventDispatcher;
            events = new SingleTargetBinder(target);
        }
        
        public static var singleEvent:Array = [
            ["test"],
            ["test", "payload"],
            ["test", 1, 2, 3, 4]
        ];
        
        [Test(dataProvider="singleEvent")]
        public function shouldBindSingleEvent(type:String, ... payload):void
        {
            var dispatchedEvent:String;
            
            var handler:Function = function(event:Event, ... data):void
            {
                dispatchedEvent = event.type;
                assertThat(event.target, equalTo(target));
                
                assertThat(data.length, equalTo(payload.length));
                assertThat(data, hasItems.apply(payload));
            }
            
            events.bind(type, handler, {parameters: payload});
            
            target.dispatchEvent(new Event(type));
            
            type = type.split(".", 1)[0];
            assertThat(dispatchedEvent, equalTo(type));
        }
        
        public static var multipleEvents:Array = [
            ["foo bar baz"],
            ["foo bar baz", "payload"],
            ["foo bar baz", 1, 2, 3, 4]
        ];
        
        [Test(dataProvider="multipleEvents")]
        public function shouldBindMultipleEvents(types:String, ... payload):void
        {
            var dispatchedEvent:String;
            
            var handler:Function = function(event:Event, ... data):void
            {
                dispatchedEvent = event.type;
                assertThat(event.target, equalTo(target));
                
                assertThat(data.length, equalTo(payload.length));
                assertThat(data, hasItems.apply(payload));
            }
            
            events.bind(types, handler, {parameters: payload});
            
            var list:Array = types.replace(/\s+/g, " ").split(" ");
            
            for each (var type:String in list)
            {
                target.dispatchEvent(new Event(type));
                
                type = type.split(".", 1)[0];
                assertThat(dispatchedEvent, equalTo(type));
            }
        }
    }
}
