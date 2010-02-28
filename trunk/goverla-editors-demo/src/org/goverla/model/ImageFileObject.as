package org.goverla.model {
	
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	
	import org.goverla.collections.ArrayList;
	import org.goverla.controls.properties.classes.PropertiesGroup;
	import org.goverla.controls.properties.classes.PropertiesUtil;
	import org.goverla.interfaces.INamedEntry;
	
	public class ImageFileObject extends FileObject {
		
		[Bindable]
		[Editable(group="General", editor="StringEditor", label="crop left:",
			bindable="true", index="3")]
		public function get cropLeft() : String {
			return _cropLeft;
		}

		public function set cropLeft(value : String) : void {
			_cropLeft = value;
		}
		
		[Bindable]
		[Editable(group="General", editor="StringEditor", label="crop right:",
			bindable="true", index="4")]
		public function get cropRight() : String {
			return _cropRight;
		}

		public function set cropRight(value : String) : void {
			_cropRight = value;
		}
		
		[Bindable]
		[Editable(group="General", editor="StringEditor", label="crop top:",
			bindable="true", index="5")]
		public function get cropTop() : String {
			return _cropTop;
		}

		public function set cropTop(value : String) : void {
			_cropTop = value;
		}
		
		[Bindable]
		[Editable(group="General", editor="StringEditor", label="crop botom:",
			bindable="true", index="6")]
		public function get cropBottom() : String {
			return _cropBottom;
		}

		public function set cropBottom(value : String) : void {
			_cropBottom = value;
		}
		
		[Editable(group="General", editor="CollectionEditor", label="formats:",
			itemsEditor="StringEditor", itemsClass="ImageFormatEntry", itemField="name",
			bindable="true", index="7")]
		public function get formats() : ArrayList {
			if (_formats == null) {
				_formats = new ArrayList();
				_formats.addEventListener(CollectionEvent.COLLECTION_CHANGE, onFormatsChange);
			}
			return _formats;
		}
		
		[Editable()]
		public override function get allowedExtensions() : ArrayList {
			return super.allowedExtensions;
		}
		
		private function onFormatsChange(event : CollectionEvent) : void {
			var item : Object;
			var group : PropertiesGroup;
			
			switch (event.kind) {
				case CollectionEventKind.ADD:
					item = event.items[0];
					group = new PropertiesGroup(INamedEntry(item));
					PropertiesUtil.addPropertiesToGroupByMetadata(group, item);
					propertiesGroups.addItem(group);
					break;
					
				case CollectionEventKind.REMOVE:
					for each (group in propertiesGroups) {
						if (group.nameEntry == item) {
							propertiesGroups.removeItemAt(propertiesGroups.getItemIndex(group));
							break;
						}
					}
					break;
			}
		}
		
		private var _cropLeft : String;
		
		private var _cropRight : String;
		
		private var _cropTop : String;
		
		private var _cropBottom : String;
		
		private var _formats : ArrayList;
		
	}
	
}