package org.goverla.model {
	
	import org.goverla.collections.ArrayList;

	public class FileObject extends EditableObject {
		
		[Bindable]
		[Editable(group="General", editor="StringEditor", label="maximum filesize:",
			bindable="true", index="1")]
		public function get maxFileSize() : String {
			return _maxFileSize;
		}
		
		public function set maxFileSize(value : String) : void {
			_maxFileSize = value;
		}
		
		[Editable(group="General", editor="CollectionEditor", label="allowed extensions:",
			itemsEditor="StringEditor", itemsClass="FileExtensionEntry", itemField="name",
			bindable="true", index="2")]
		public function get allowedExtensions() : ArrayList {
			if (_allowedExtensions == null) {
				_allowedExtensions = new ArrayList();
			}
			return _allowedExtensions;
		}
		
		private var _maxFileSize : String;
		
		private var _allowedExtensions : ArrayList;
		
	}
	
}