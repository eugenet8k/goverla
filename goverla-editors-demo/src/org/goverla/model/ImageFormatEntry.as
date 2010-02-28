package org.goverla.model {
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import org.goverla.interfaces.INamedEntry;
	
	[Unique(properties="name")]
	public class ImageFormatEntry extends EventDispatcher implements INamedEntry {
		
		[Bindable]
		[Serializable]
		[Unique(defaultValue="imageFormat")]
		public function get name() : String {
			return _name;
		}

		public function set name(value : String) : void {
			_name = value;
		}
		
		[Bindable]
		[Serializable]
		[Editable(editor="StringEditor", label="width:", 
			enabledField="widthEnabled", bindable="true", index="0")]
		public function get width() : String {
			return _width;
		}

		public function set width(value : String) : void {
			_width = value;
			dispatchEvent(new Event("widthChange"));
		}
		
		[Bindable(event="widthChange")]
		public function get widthEnabled() : Boolean {
			return (minWidth == null || minWidth == "") &&
				(maxWidth == null || maxWidth == "");
		}
		
		[Bindable]
		[Serializable]
		[Editable(editor="StringEditor", label="minimum width:", 
			enabledField="minWidthEnabled", bindable="true", index="1")]
		public function get minWidth() : String {
			return _minWidth;
		}

		public function set minWidth(value : String) : void {
			_minWidth = value;
			dispatchEvent(new Event("widthChange"));
		}
		
		[Bindable(event="widthChange")]
		public function get minWidthEnabled() : Boolean {
			return width == null || width == "";
		}
		
		[Bindable]
		[Serializable]
		[Editable(editor="StringEditor", label="maximum width:", 
			enabledField="maxWidthEnabled", bindable="true", index="2")]
		public function get maxWidth() : String {
			return _maxWidth;
		}

		public function set maxWidth(value : String) : void {
			_maxWidth = value;
			dispatchEvent(new Event("widthChange"));
		}
		
		[Bindable(event="widthChange")]
		public function get maxWidthEnabled() : Boolean {
			return width == null || width == "";
		}
		
		[Bindable]
		[Serializable]
		[Editable(editor="StringEditor", label="height:",
			enabledField="heightEnabled", bindable="true", index="3")]
		public function get height() : String {
			return _height;
		}

		public function set height(value : String) : void {
			_height = value;
			dispatchEvent(new Event("heightChange"));
		}
		
		[Bindable(event="heightChange")]
		public function get heightEnabled() : Boolean {
			return (minHeight == null || minHeight == "") &&
				(maxHeight == null || maxHeight == "");
		}
		
		[Bindable]
		[Serializable]
		[Editable(editor="StringEditor", label="minimum height:",
			enabledField="minHeightEnabled", bindable="true", index="4")]
		public function get minHeight() : String {
			return _minHeight;
		}

		public function set minHeight(value : String) : void {
			_minHeight = value;
			dispatchEvent(new Event("heightChange"));
		}
		
		[Bindable(event="heightChange")]
		public function get minHeightEnabled() : Boolean {
			return height == null || height == "";
		}
		
		[Bindable]
		[Serializable]
		[Editable(editor="StringEditor", label="maximum height:",
			enabledField="maxHeightEnabled", bindable="true", index="5")]
		public function get maxHeight() : String {
			return _maxHeight;
		}

		public function set maxHeight(value : String) : void {
			_maxHeight = value;
			dispatchEvent(new Event("heightChange"));
		}
		
		[Bindable(event="heightChange")]
		public function get maxHeightEnabled() : Boolean {
			return height == null || height == "";
		}
		
		[Bindable]
		[Serializable]
		[Editable(editor="ComboBoxEditor", label="scale method:", dataProvider="crop,fit", index="11")]
		public function get scaleMethod() : String {
			return _scaleMethod;
		}

		public function set scaleMethod(value : String) : void {
			_scaleMethod = value;
		}
		
		[Bindable]
		[Serializable]
		[Editable(editor="ComboBoxEditor", label="file type:", dataProvider="jpeg,png,gif", index="12")]
		public function get fileType() : String {
			return _fileType;
		}

		public function set fileType(value : String) : void {
			_fileType = value;
		}
		
		[Bindable]
		[Serializable]
		[Editable(editor="StringEditor", label="compression:", bindable="true", index="13")]
		public function get compression() : String {
			return _compression;
		}

		public function set compression(value : String) : void {
			_compression = value;
		}
		
		[Bindable]
		[Serializable]
		[Editable(editor="StringEditor", label="background color:", bindable="true", index="14")]
		public function get backgroundColor() : String {
			return _backgroundColor;
		}

		public function set backgroundColor(value : String) : void {
			_backgroundColor = value;
		}
		
		[Bindable]
		[Serializable]
		[Editable(editor="StringEditor", label="background image:", bindable="true", index="15")]
		public function get backgroundImage() : String {
			return _backgroundImage;
		}

		public function set backgroundImage(value : String) : void {
			_backgroundImage = value;
		}
		
		[Bindable]
		[Serializable]
		[Editable(editor="StringEditor", label="overlay image:", bindable="true", index="16")]
		public function get overlayImage() : String {
			return _overlayImage;
		}

		public function set overlayImage(value : String) : void {
			_overlayImage = value;
		}
		
		private var _name : String;
		
		private var _width : String;
		
		private var _minWidth : String;
		
		private var _maxWidth : String;
		
		private var _height : String;
		
		private var _minHeight : String;
		
		private var _maxHeight : String;
		
		private var _scaleMethod : String;
		
		private var _fileType : String;
		
		private var _compression : String;
		
		private var _backgroundColor : String;
		
		private var _backgroundImage : String;
		
		private var _overlayImage : String;

	}
	
}