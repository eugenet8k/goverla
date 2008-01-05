package org.goverla.utils.common
{
	import org.flex2unit.framework.TestCase;
	
	public class TestClass
	{

		public function get testClassProperty() : TestClass {
			return _testClassProperty;
		}
		
		public function set testClassProperty(value : TestClass) : void {
			_testClassProperty = value;
		}
		
		public function get arrayProperty() : Array {
			return _arrayProperty;
		}
		
		public function set arrayProperty(value : Array) : void {
			_arrayProperty = value;
		}
		
		public function get intProperty() : int {
			return _intProperty;
		}
		
		public function set intProperty(value : int) : void {
			_intProperty = value;
		}
		
		public function get numberProperty() : Number {
			return _numberProperty;
		}
		
		public function set numberProperty(value : Number) : void {
			_numberProperty = value;
		}
		
		public function get classProperty() : Class {
			return _classProperty;
		}
		
		public function set classProperty(value : Class) : void {
			_classProperty = value;
		}
		
		public function get booleanProperty() : Boolean {
			return _booleanProperty;
		}
		
		public function set booleanProperty(value : Boolean) : void {
			_booleanProperty = value;
		}
		
		public function get testProperty() : String {
			return _testProperty;
		}
		
		public function set testProperty(value : String) : void {
			_testProperty = value;
		}
		
		public function setDefaultValue() : void {
			_testProperty = "Kovalyov is cool programmer, A.P. is poor motherfuckerlamer!";
		}
		
		public var testField : Object;
		
		private var _testProperty : String;
		private var _booleanProperty : Boolean;
		private var _classProperty : Class;
		private var _numberProperty : Number;
		private var _intProperty : int;
		private var _arrayProperty : Array;
		private var _testClassProperty : TestClass;
	}
}