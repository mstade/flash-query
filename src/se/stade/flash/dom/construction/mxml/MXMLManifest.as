package se.stade.flash.dom.construction.mxml
{
    import flash.utils.Dictionary;

    public class MXMLManifest implements Manifest
    {
        public function MXMLManifest(uri:String, componentPackage:XML)
        {
            _uri = uri;
            this.componentPackage = componentPackage;
        }
        
        private var componentPackage:XML;
        
        private var _uri:String;
        public function get uri():String
        {
            return _uri;
        }
        
        private var cache:Dictionary = new Dictionary;
        
        public final function qualify(tag:String):QName
        {
            if (tag in cache)
                return cache[tag];
            
            var type:String = componentPackage.component.(@id == tag).attribute("class");
            var namespace:String = type.split(".").slice(0, -1).join(".");
            var classname:String = type.substr(namespace.length + 1);
            
            return cache[tag] = new QName(namespace, classname);
        }
    }
}