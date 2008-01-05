package org.goverla.utils
{
	import flash.events.Event;
	import flash.net.NetConnection;
	
	import mx.collections.ArrayCollection;
	
	import org.flex2unit.framework.TestCase;
	import org.goverla.collections.ArrayList;
	import org.goverla.events.DynamicEvent;
	import org.goverla.utils.common.TestClass;
	import org.goverla.utils.common.TestClassDynamic;

	public class ReflectUtilTest extends TestCase
	{
		
   		public function testIsDynamic() : void 
   		{
			assertTrue(ReflectUtil.isDynamic(new DynamicEvent("aaa")));
			assertFalse(ReflectUtil.isDynamic(new Event("aaa")));

   		}   		
   		
   		public function testGetEvents() : void {
   			var events : ArrayList = ReflectUtil.getEvents(NetConnection);
   			assertTrue(events.contains("netStatus"));
   			assertTrue(events.contains("ioError"));
   		}
   		public function testGetType() : void {
			var type : Class = ReflectUtil.getType(this);
			assertEquals(type, ReflectUtilTest); 

   		}

   		public function testGetTypeName() : void {
			var typeName : String = ReflectUtil.getTypeName(this);
			assertEquals(typeName, "ReflectUtilTest"); 

   		}
   		
   		public function testGetProperties() : void {
   			var testClass : TestClass = new TestClass();
   			var testClassDynamic : TestClassDynamic = new TestClassDynamic();
   			
   			var properties : ArrayCollection = ReflectUtil.getPropertiesByInstance(testClass);
   			var propertiesForDynamic : ArrayCollection = ReflectUtil.getPropertiesByInstance(testClassDynamic);
   			
   			assertTrue(properties.contains("testProperty"));
   			assertTrue(propertiesForDynamic.contains("testProperty"));
   		}

   		public function testGetFields() : void {
   			var testClass : TestClass = new TestClass();
   			var testClassDynamic : TestClassDynamic = new TestClassDynamic();
   			var obj : Object = {x:20, y:30};
   			
   			var fields : ArrayCollection = ReflectUtil.getFieldsByInstance(testClass);
   			var fieldsForDynamic : ArrayCollection = ReflectUtil.getFieldsByInstance(testClassDynamic);
   			var fieldsObj : ArrayCollection = ReflectUtil.getFieldsByInstance(obj);
   			
   			assertTrue(fields.contains("testField"));
   			assertTrue(fieldsForDynamic.contains("testField1"));
   			assertTrue(fieldsObj.contains("x"));
   		}
   		
		public function testGetMethods() : void {
   			var testClass : TestClass = new TestClass();
   			var testClassDynamic : TestClassDynamic = new TestClassDynamic();
   			
   			var methods : ArrayCollection = ReflectUtil.getMethodsByInstance(testClass);
   			var methodsForDynamic : ArrayCollection = ReflectUtil.getMethodsByInstance(testClassDynamic);
   			
   			assertTrue(methods.contains("setDefaultValue"));
   			assertTrue(methodsForDynamic.contains("setDefaultValue"));
   		}		

   		public function testHasProperty() : void {
   			var testClass : TestClass = new TestClass();
   			
   			assertTrue(ReflectUtil.hasPropertyByInstance(testClass, "testProperty"));
   		}

   		public function testHasField() : void {
   			var testClass : TestClass = new TestClass();
   			
   			assertTrue(ReflectUtil.hasFieldByInstance(testClass, "testField"));
   		}
   		
		public function testHasMethod() : void {
   			var testClass : TestClass = new TestClass();
   			
   			assertTrue(ReflectUtil.hasMethodByInstance(testClass, "setDefaultValue"));
   		}		

	}
}