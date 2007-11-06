package org.goverla.utils {
	
	import flash.system.ApplicationDomain;
	import flash.utils.describeType;
	import flash.utils.getQualifiedClassName;
	
	import mx.collections.ArrayCollection;
	import mx.utils.ObjectUtil;
	import mx.utils.StringUtil;
	
	import org.goverla.constants.MetadataNames;
	import org.goverla.errors.ReflectionError;
	import org.goverla.utils.common.FieldDescription;
	
	public class ReflectUtil {
		
		public static function getType(instance : Object, applicationDomain : ApplicationDomain = null) : Class {
			if (applicationDomain == null) {
				applicationDomain = ApplicationDomain.currentDomain;
			}
			return getTypeByName(getQualifiedClassName(instance), applicationDomain);	
		}		

		public static function getTypeByName(typeName : String, applicationDomain : ApplicationDomain = null) : Class {
			if (applicationDomain == null) {
				applicationDomain = ApplicationDomain.currentDomain;
			}

			var result : Class;
			if (typeName == "null") {
				result = null;
			} else {
				result = applicationDomain.getDefinition(typeName) as Class;
			}
			return result;	
		}		
		
		public static function getTypeName(instance : Object) : String {
			var nameWithContext : String = getQualifiedClassName(instance);
			return nameWithContext.substr(nameWithContext.lastIndexOf(":") + 1);
		}
		
		public static function hasFieldByInstance(instance : Object, name : String) : Boolean {
			return getFieldsByInstance(instance).contains(name);
		}

		public static function hasPropertyByInstance(instance : Object, name : String) : Boolean {
			return getPropertiesByInstance(instance).contains(name);
		}		
		
		public static function hasMethodByInstance(instance : Object, name : String) : Boolean {
			return getMethodsByInstance(instance).contains(name);
		}
		
		public static function getFieldsDescriptionsByInstance(instance : Object, applicationDomain : ApplicationDomain = null) : ArrayCollection {
			if(applicationDomain == null) {
				applicationDomain = ApplicationDomain.currentDomain;
			}

			var result : ArrayCollection = new ArrayCollection();
			 
			if (!ObjectUtil.isSimple(instance)) {
				var description : XML = describeType(instance);
				result = new ArrayCollection(getFieldsDescriptions(instance, description, applicationDomain));
			}
			
			return result;
		}
		
		public static function getFieldsByInstance(instance : Object) : ArrayCollection {
			var result : ArrayCollection = new ArrayCollection();
			 
			if (!ObjectUtil.isSimple(instance)) {
				var description : XML = describeType(instance);
				result = new ArrayCollection(getFields(instance, description));
			}
			
			return result;
		}
		
		public static function getPropertiesByInstance(instance : Object) : ArrayCollection {
			var result : ArrayCollection = new ArrayCollection();
			 
			if (!ObjectUtil.isSimple(instance)) {
				var description : XML = describeType(instance);
				result = new ArrayCollection(getAccessors(instance, description));
			}
			
			return result;
		}
		
		public static function getMethodsByInstance(instance : Object) : ArrayCollection {
			var result : ArrayCollection = new ArrayCollection();
			 
			if (!ObjectUtil.isSimple(instance)) {
				var description : XML = describeType(instance);
				result = new ArrayCollection(getMethods(instance, description));
			}
			
			return result;
		}
		
		public static function getMetadata(obj : Object, propName : String, metadataName : String) : Object {
			var result : Object = null;			
			
			var exists : Boolean = ObjectUtil.hasMetadata(obj, propName, metadataName);
			if (exists) {
				var metadata : Object = ObjectUtil.getClassInfo(obj)[MetadataNames.METADATA][propName];
				result = metadata[metadataName];
			}
			
			return result;
		}

		public static function getMethodName(instance : Object, method : Function) : String {
			var result : String;
			var methods : ArrayCollection = getMethodsByInstance(instance);
			for (var i : int = 0; i < methods.length; i++) {
				if(instance[methods.getItemAt(i)] == method) {
					result = methods.getItemAt(i) as String;
					break;
				}
			}
			if (result == null) {
				throw new ReflectionError(StringUtil.substitute("No method [{0}] in object [{1}]"
					, method
					, instance.toString()));
			}
			
			return result;
		}

		private static function getFieldsDescriptions(instance : Object, description : XML, applicationDomain : ApplicationDomain = null) : Array {
			if(applicationDomain == null) {
				applicationDomain = ApplicationDomain.currentDomain;
			}

			var result : Array = new Array();
			
			if (XMLList(description.@name).toString() != "Object") {
				for each (var variable : XML in description.variable) {
					var name : String = XMLList(variable.@name).toString();
					var className : String = XMLList(variable.@type).toString();
					result.push(new FieldDescription(name, getTypeByName(className, applicationDomain)));
				}
	
				for each (var factory : XML in description.factory) {
					result.concat(getFieldsDescriptions(instance, factory, applicationDomain));
				}
			} 
			for (var field : String in instance) {
				result.push(new FieldDescription(field, getType(instance[field], applicationDomain)));
			}

			return result;
		}
		
		private static function getFields(instance : Object, description : XML) : Array {
			var result : Array = new Array();
			
			if (XMLList(description.@name).toString() != "Object") {
				for each (var variable : XML in description.variable) {
					result.push(XMLList(variable.@name).toString());
				}
	
				for each (var factory : XML in description.factory) {
					result.concat(getFields(instance, factory));
				}
			} 

			for (var field : String in instance) {
				result.push(field);
			}

			return result;
		}

		private static function getAccessors(instance : Object, description : XML) : Array {
			var result : Array = new Array();
			
			for each (var accessor : XML in description.accessor) {
				result.push(XMLList(accessor.@name).toString());
			}
			
			for each (var factory : XML in description.factory) {
				result.concat(getAccessors(instance, factory));
			}
			return result;
		}
		
		private static function getMethods(instance : Object, description : XML) : Array {
			var result : Array = new Array();
			
			for each (var method : XML in description.method) {
				result.push(XMLList(method.@name).toString());
			}
			
			for each (var factory : XML in description.factory) {
				result.concat(getMethods(instance, factory));
			}
			
			return result;
		}	
			
	}

}