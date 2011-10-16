# Flash Query
## A little less conversation, a little more action please

Flash Query is a library that heavily draws inspiration from [jQuery](http://jquery.com/), the write less do more framework for JavaScript. Flash Query is not a port of jQuery, although in many cases it shares the same kind of interfaces.

The focus of Flash Query is much the same as jQuery, get rid of the boilerplate involved in working with the Flash display list. The idea is to stop thinking about the nitty gritty details and focus on the semantics of it instead.

## Enough jibba jabba, show me the code already

Given a view, this is the most convenient way of creating a Flash Query instance:

    var $:FlashQuery = FlashQuery.from(view);

The Flash Query object can now be used to traverse the display list, using `view` as a root. It can also be used to set properties, bind event handlers and all sorts of crazy things. For instance, here's a snippet to fix a pet peeve of mine, that Buttons in Flex never have hand cursors by default:

    $.find("Buttons").set({
        buttonMode:    true,
        useHandCursor: true
    });

With a concise expression we managed to set all buttons descendant from the view to have hand cursors. Ain't that something. Although, this is only affecting all buttons currently on screen. If we modify the sample slightly, we can make the query affect all buttons currently on screen, as well as any future buttons added:

    $.find("Buttons").subscribe().set({
        buttonMode:    true,
        useHandCursor: true
    });
    
With the simple addition of the call `subscribe()`, the query is transformed into a live query that will affect all buttons currently on screen, as well as any future buttons.

Flash Query supports almost all CSS3 selectors and doesn't rely on Flex what so ever to do its work. In fact, Flash Query doesn't even have any flex bindings and will work with any AS3 project running under the Flash Player runtime.

# Caveats
Flash Query is not yet production ready. More documentation on Flash Query will follow, including an API reference. Until then, be aware that this library is under active development and may change under your feet. You have been warned.
