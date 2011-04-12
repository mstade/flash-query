package se.stade.flash.dom.construction.mxml.adobe
{
    import se.stade.flash.dom.construction.mxml.MXMLManifest;

    public class AS3Manifest extends MXMLManifest
    {
        public static const instance:AS3Manifest = new AS3Manifest;
        
        public function AS3Manifest()
        {
            super("http://ns.adobe.com/mxml/2009",
                <componentPackage>
                    <!--
                    
                        ADOBE SYSTEMS INCORPORATED
                        Copyright 2008 Adobe Systems Incorporated
                        All Rights Reserved.
                    
                        NOTICE: Adobe permits you to use, modify, and distribute this file
                        in accordance with the terms of the license agreement accompanying it.
                    
                    -->
                    
                    <!--
                    
                        MXML 2009 Components
                    
                    -->
                
                    <!-- AS3 built-ins -->
                    <component id="Array" class="Array" lookupOnly="true"/>
                    <component id="Boolean" class="Boolean" lookupOnly="true"/>
                    <component id="Class" class="Class" lookupOnly="true"/>
                    <component id="Date" class="Date" lookupOnly="true"/>
                    <component id="DesignLayer" class="mx.core.DesignLayer"/>
                    <component id="Function" class="Function" lookupOnly="true"/>
                    <component id="int" class="int" lookupOnly="true"/>
                    <component id="Number" class="Number" lookupOnly="true"/>
                    <component id="Object" class="Object" lookupOnly="true"/>
                    <component id="RegExp" class="RegExp" lookupOnly="true"/>
                    <component id="String" class="String" lookupOnly="true"/>
                    <component id="uint" class="uint" lookupOnly="true"/>
                    <component id="Vector" class="__AS3__.vec.Vector" lookupOnly="true"/>
                    <component id="XML" class="XML" lookupOnly="true"/>
                    <component id="XMLList" class="XMLList" lookupOnly="true"/>
                
                </componentPackage>
            );
        }
    }
}