package se.stade.flash.dom.construction.mxml
{
    import flash.utils.Dictionary;
    import flash.utils.getDefinitionByName;
    
    import se.stade.daffodil.Reflect;
    import se.stade.daffodil.properties.Property;
    import se.stade.flash.dom.construction.DisplayTreeBuilder;
    import se.stade.flash.dom.construction.mxml.adobe.AS3Manifest;
    import se.stade.flash.dom.construction.mxml.adobe.HaloManifest;
    import se.stade.flash.dom.construction.mxml.adobe.SparkManifest;

    public class MXMLBuilder implements DisplayTreeBuilder
    {
        public function MXMLBuilder(description:XML, ... manifestList)
        {
            this.description = description;
            manifests = new Dictionary;
            
            manifestList = [
                AS3Manifest.instance,
                HaloManifest.instance,
                SparkManifest.instance
            ].concat(manifestList);
            
            for each (var manifest:Manifest in manifestList)
            {
                manifests[manifest.uri] = manifest;
            }
        }
        
        private var description:XML;
        private var manifests:Dictionary;
        
        private function qualify(name:QName):String
        {
            if (name.uri in manifests)
                return String(manifests[name.uri].qualify(name.localName).toString());
            
            return String(name);
        }
        
        private function construct(node:XML):*
        {
            var instance:*;
            var name:QName = node.name();
            var definition:Class = getDefinitionByName(qualify(name)) as Class;
            
            if (name.uri == AS3Manifest.instance.uri)
            {
                return new definition(node.children().toXMLString());
            }
            else
            {
                instance = new definition();
                
                if (node.children().length())
                {
                    var defaultProperty:Property = Reflect.defaultProperty.on(instance)[0];
                    var values:Array = [];
                    
                    for each (var child:XML in node.children())
                    {
                        if (child.localName() in instance)
                        {
                            trace("Ignoring property", child.localName(), "for now");
                        }
                        else
                        {
                            values.push(construct(child));
                        }
                    }
                
                    defaultProperty.value = values;
                }
            }
            
            return instance;
        }
        
        public function build():*
        {
            return construct(description);
        }
    }
}