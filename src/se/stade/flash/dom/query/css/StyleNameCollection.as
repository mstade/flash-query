package se.stade.flash.dom.query.css
{
	import se.stade.colligo.lists.LinearSet;
	
	public dynamic class StyleNameCollection extends LinearSet
	{
		public function StyleNameCollection(names:String)
		{
			names = names.replace(/\./g, " "); //Replace dots with whitespace
			var parts:Array = names.split(" ");
			
			if (!parts[0])
				parts = parts.slice(1);
			
			super(parts);
		}
		
		private namespace dirty;
		private namespace clean;
		private var declaration:Namespace = dirty;
		
		private var cached:String;
		
		override public function add(styleName:*):void
		{
			super.add(styleName);
			declaration = dirty;
		}
		
		override public function remove(styleName:*):void
		{
			super.remove(styleName);
			declaration = dirty;	
		}
		
		override public function clear():void
		{
			super.clear();
			declaration = dirty;
		}
		
		dirty function getString():String
		{
			cached = toArray().join(" ");
			declaration = clean;
			
			return cached;
		}
		
		clean function getString():String
		{
			return cached;
		}
		
		public function toString():String
		{
			return declaration::getString();
		}
	}
}