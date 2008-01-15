package org.goverla {

 	import org.flex2unit.framework.TestSuite;
 	import org.goverla.collections.HashMapTest;
 	import org.goverla.collections.LinearQueueTest;
 	import org.goverla.collections.ListCollectionViewIteratorTest;
 	import org.goverla.collections.StringMapTest;
 	import org.goverla.collections.TypedArrayCollectionTest;
 	import org.goverla.command.CommandsPoolTest;
 	import org.goverla.css.CSSParserTest;
 	import org.goverla.serialization.SerializerTest;
 	import org.goverla.serialization.XMLSerializerTest;
 	import org.goverla.utils.ArrayListTest;
 	import org.goverla.utils.ArraysTest;
 	import org.goverla.utils.CommandHistoryTest;
 	import org.goverla.utils.DatesTest;
 	import org.goverla.utils.EventSenderTest;
 	import org.goverla.utils.LevenshteinTest;
 	import org.goverla.utils.MethodsPoolTest;
 	import org.goverla.utils.ObjectsTest;
 	import org.goverla.utils.OverloadHandlerTest;
 	import org.goverla.utils.OverloadTest;
 	import org.goverla.utils.ReflectUtilTest;
 	import org.goverla.utils.SortingTest;
 	import org.goverla.utils.StackTest;
 	import org.goverla.utils.StringsTest;
 	import org.goverla.utils.comparing.ArrayMapValueCompareRequirementTest;
 	import org.goverla.utils.comparing.DateComparerTest;
 	import org.goverla.utils.comparing.MethodResultCompareRequirementTest;
 	import org.goverla.utils.comparing.NotRequirementTest;
 	import org.goverla.utils.comparing.NumberComparerTest;
 	import org.goverla.utils.comparing.PropertyCompareRequirementTest;
 	import org.goverla.utils.comparing.StringComparerTest;

	public class GoverlaTests {

  		public static function get suite() : TestSuite {
   			var suite : TestSuite = new TestSuite("GO!!!Verla");
 			  			
   			suite.addTest(ArrayListTest);
   			suite.addTest(StackTest);
   			
   			suite.addTest(HashMapTest);
   			suite.addTest(LinearQueueTest);
   			suite.addTest(ListCollectionViewIteratorTest);
   			suite.addTest(StringMapTest);
   			suite.addTest(TypedArrayCollectionTest);
   			
   			suite.addTest(PropertyCompareRequirementTest);
   			suite.addTest(NotRequirementTest);
   			suite.addTest(MethodResultCompareRequirementTest);
   			suite.addTest(ArrayMapValueCompareRequirementTest);
   			
   			
   			
   			suite.addTest(DateComparerTest);
   			suite.addTest(NumberComparerTest);
   			suite.addTest(StringComparerTest);
   			
   			suite.addTest(ArraysTest);
   			suite.addTest(SortingTest);
   			suite.addTest(OverloadTest);
   			suite.addTest(OverloadHandlerTest);
   			suite.addTest(DatesTest);
   			
   			suite.addTest(CommandsPoolTest);
   			
   			suite.addTest(MethodsPoolTest);
   			suite.addTest(ObjectsTest);
   			suite.addTest(SerializerTest);
   			suite.addTest(CommandHistoryTest);
   			suite.addTest(EventSenderTest);
   			suite.addTest(ReflectUtilTest);
  			suite.addTest(StringsTest);
   			suite.addTest(LevenshteinTest);
   			suite.addTest(CSSParserTest);
   			
   			suite.addTest(XMLSerializerTest);
   			
   			return suite;
   		}		

	}

}