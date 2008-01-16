package org.goverla.utils
{
	import mx.core.UIComponent;
	
	import org.flex2unit.framework.TestCase;
	import flash.text.TextFormat;
	import mx.utils.ObjectUtil;
	import org.goverla.converting.ObjectCopyConverter;

	public class ObjectsTest extends TestCase
	{
		
		public function testIsPrimitive() : void {
			assertTrue(Objects.isPrimitive(1));
			assertTrue(Objects.isPrimitive(true));
			assertTrue(Objects.isPrimitive("sss"));
			assertTrue(Objects.isPrimitive(new int()));
			assertTrue(Objects.isPrimitive(new Number()));
			assertTrue(Objects.isPrimitive(new String()));
			assertTrue(Objects.isPrimitive(ObjectsTest));
			assertFalse(Objects.isPrimitive(new Object()));
			assertFalse(Objects.isPrimitive([]));
			assertFalse(Objects.isPrimitive(new Date()));


		}		
		
		public function testCopyTextFormat() : void {
			var format : TextFormat = new TextFormat("aa", 10, 10, true);
			var newFormat : TextFormat = TextFormat(new ObjectCopyConverter().convert(format));
			assertEquals(format.bold, newFormat.bold);
			assertEquals(format.font, newFormat.font);
			assertEquals(format.size, newFormat.size);
		}
		
		public function testGetFieldName() : void {
			
			var field : String = "bla1.bla2.blafield";
			
			var result : String = Objects.getFieldName(field);
			
			assertEquals(result, "blafield");
		}
		
		public function testGetTarget() : void {
			
			var object : UIComponent = new UIComponent();
			var field : String = "enabled.property";
			
			var result : Object = Objects.getProperty(object, field);
			
			assertTrue("Objects.getTarget()", result);
		}
		
		public function testGetPropertiesCount() : void {
			
			var obj : Object = new Object();
			var count : Number = 10;
			
			for (var i : Number = 0; i < count; i++) {
				obj["property" + i] = "valueForProperty" + i;
			}
			
			var result : Number = Objects.getPropertiesCount(obj);
			
			assertEquals(result, count);
		}
		
		public function testCastToString() : void {
			
			var str : String = "some string";
			
			var obj : Object = str;
			
			assertEquals(str, Objects.castToString(obj));
		}
		
		public function testCastToNumber() : void {
			
			var n1 : Number = 567;
			var n2 : Number = 5.67;
			var n3 : Number = -67;
			
			var obj1 : Object = n1;
			var obj2 : Object = n2;
			var obj3 : Object = n3;
			
			assertEquals(n1, Objects.castToNumber(obj1));
			assertEquals(n2, Objects.castToNumber(obj2));
			assertEquals(n3, Objects.castToNumber(obj3));
		}
		
		public function testCastToArray() : void {
			
			var arr : Array = [1, "2", 5];
			
			var obj : Object = arr;
			
			assertEquals(arr, Objects.castToArray(obj));
		}
		
		public function testCastToBoolean() : void {
			
			var b1 : Boolean = true;
			var b2 : Boolean = false;
			
			var obj1 : Object = b1;
			var obj2 : Object = b2;
			
			assertEquals(b1, Objects.castToBoolean(obj1));
			assertEquals(b2, Objects.castToBoolean(obj2));
		}

	}
}