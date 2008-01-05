package org.goverla.serialization
{
	import org.goverla.collections.ParentedArrayList;
	import org.goverla.collections.ArrayList;
	import org.goverla.utils.Objects;
	import org.goverla.utils.common.TestClass;
	import org.goverla.utils.comparing.EqualsRequirement;
	
	import flash.media.Camera;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.net.SharedObject;
	import flash.utils.describeType;
	import flash.xml.XMLNode;
	
	import org.flex2unit.framework.TestCase;

	public class XMLSerializerTest extends TestCase
	{
		public function XMLSerializerTest()
		{
			super();
		}
		
		
		private function get testObject() : Object {
			var result : TestClass = new TestClass();
			result.testProperty = "aaa>";
			result.booleanProperty = false;
			result.numberProperty = 2.354;
			result.classProperty = TestClass;
			result.intProperty = 3;
			result.arrayProperty = [1,2,3];
			return result;
		}
		
   		public function testDynamicObject() : void
   		{
   			var obj : Object = new Object();
   			obj.a = "aaa";
   			obj.obj = obj;
   			var serialization : XML = new XMLSerializer().serialize(obj);
   			var newObject : Object = new XMLSerializer().deserialize(serialization);
   			assertEquals(newObject.a, "aaa");
   			assertEquals(newObject.obj, newObject);
   			
   		}
   		
		public function testBoolean() : void {
			var serializer : XMLSerializer = new XMLSerializer();
			assertTrue(serializer.deserialize(serializer.serialize(true)));
			assertFalse(serializer.deserialize(serializer.serialize(false)));
		}
		
		public function testCircularReference() : void {
			var obj : TestClass = new TestClass();
			obj.testClassProperty = obj;
			var serializer : XMLSerializer = new XMLSerializer();
			var xml : XML = serializer.serialize(obj);
			var result : TestClass = TestClass(serializer.deserialize(xml));
			
			assertEquals(result, result.testClassProperty);
			
			
			
		}
		
		
		public function testToFromXml() : void {
			var serializer : XMLSerializer = new XMLSerializer();
			var xml : XML = serializer.serialize(testObject);
			var object : TestClass = TestClass(serializer.deserialize(xml));
			assertEquals(object.testProperty, "aaa>");
			assertEquals(object.booleanProperty, false);
			assertEquals(object.numberProperty, 2.354);
			assertEquals(object.classProperty, TestClass);
			assertEquals(object.intProperty, 3);
			assertEquals(object.arrayProperty[0], 1);
			assertEquals(object.arrayProperty[1], 2);
			assertEquals(object.arrayProperty[2], 3);
			
			assertTrue(object.intProperty is int);
			assertTrue(object.arrayProperty is Array);
		}
		
		public function testCollection() : void {
			var serializer : XMLSerializer = new XMLSerializer();
			var collection : ArrayList = new ArrayList([1,2,3, true, new Object()]);
			var xml : XML = serializer.serialize(collection);
			var result : ArrayList = ArrayList(serializer.deserialize(xml));
			assertEquals(result.getItemAt(0), 1);
			assertEquals(result.getItemAt(1), 2);
			assertEquals(result.getItemAt(2), 3);
			assertEquals(result.getItemAt(3), true);
			
			var list : ParentedArrayList = new ParentedArrayList(1);
			assertEquals(ParentedArrayList(serializer.deserialize(serializer.serialize(list))).parent, 1);
		}
		
		public function testComma() : void {
			var serializer : XMLSerializer = new XMLSerializer();
			var xml : XML = <root type='Number'>6,2222</root>;
			var result : Object = serializer.deserialize(xml);
			assertEquals(result, 6.2222);
			
		}
		
		public function testNull() : void {
			var serializer : XMLSerializer = new XMLSerializer();
			var xml : XML = serializer.serialize(null);
			trace(xml);
			var result : Object = serializer.deserialize(xml);
			assertNull(result);
		}
		
		public function testXML() : void {
			var serializer : XMLSerializer = new XMLSerializer();
			var xml : XML = 
			<root>
				<hujna type="huj">
					hujna
				</hujna>
			</root>;
			var result : XML = XML(serializer.deserialize(serializer.serialize(xml)));
			assertEquals(result.name(), "root");
			assertEquals(result.hujna.@type, "huj");
			
		}
	}
}