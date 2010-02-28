package org.goverla.controls.properties.editors {
	
	public class TwoStringsEditorBase extends BaseEditor {
		
		public function get label1() : String {
			return _label1;
		}
		
		public function set label1(value : String) : void {
			 _label1 = value;
		}
		
		public function get label2() : String {
			return _label2;
		}
		
		public function set label2(value : String) : void {
			 _label2 = value;
		}
		
		public function get itemField1() : String {
			return _itemField1;
		}
		
		public function set itemField1(value : String) : void {
			 _itemField1 = value;
		}
		
		public function get itemField2() : String {
			return _itemField2;
		}
		
		public function set itemField2(value : String) : void {
			 _itemField2 = value;
		}
		
		private var _label1 : String;
		
		private var _label2 : String;
		
		private var _itemField1 : String;
		
		private var _itemField2 : String;
		
	}
	
}