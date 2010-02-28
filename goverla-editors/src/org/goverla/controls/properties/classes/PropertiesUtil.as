package org.goverla.controls.properties.classes {

	import flash.utils.getDefinitionByName;
	
	import mx.utils.ObjectUtil;
	
	import org.goverla.constants.CustomMetadataKeyNames;
	import org.goverla.constants.CustomMetadataNames;
	import org.goverla.errors.IllegalArgumentError;
	import org.goverla.utils.Objects;
	import org.goverla.utils.ReflectUtil;
	
	public class PropertiesUtil {
		
		protected static var EDITORS_PACKAGE_NAME : String = "org.goverla.controls.properties.editors.";
		
		protected static var ENTRIES_PACKAGE_NAME : String = "org.goverla.model.";
		
		public static function getEditorClassByName(className : String) : Class {
			return getClassByName(className, EDITORS_PACKAGE_NAME);
		}
		
		public static function getEntryClassByName(className : String) : Class {
			return getClassByName(className, ENTRIES_PACKAGE_NAME);
		}
		
		public static function setUniqueProperty(object : Object, collection : Array) : void {
			var objectMetadata : Object = ReflectUtil.getClassMetadata(object);
			if (objectMetadata[CustomMetadataNames.UNIQUE] != null) {
				if (objectMetadata[CustomMetadataNames.UNIQUE][CustomMetadataKeyNames.PROPERTIES] != null) {
					var properties : Array = String(objectMetadata[CustomMetadataNames.UNIQUE]
						[CustomMetadataKeyNames.PROPERTIES]).split(",");
					for each (var property : String in properties) {
						if (object[property] == null) {
							var defaultValue : String = PropertiesUtil.getPropertyMetadataKeyValue(object, property, 
								CustomMetadataNames.UNIQUE, CustomMetadataKeyNames.DEFAULT_VALUE);
							if (defaultValue != null) {
								var maxNumber : int = 0;
								for each (var item : Object in collection) {
									var itemNumber : int = parseInt(String(item[property]).replace(/[A-Za-z]*/g, ""));
									if (itemNumber > maxNumber) {
										maxNumber = itemNumber;
									}
								}
								object[property] = defaultValue + (maxNumber + 1).toString();
							}
						}
					}
				}
			}
		}
		
		public static function getObjectMetadata(object : Object) : Object {
			var classInfo : Object = ObjectUtil.getClassInfo(object, null, 
					{includeReadOnly : true, includeTransient : false});
			return classInfo.metadata;
		}
		
		public static function getPropertyMetadataKeyValue(object : Object, property : String, metadataName : String, key : String) : String {
			var result : String;
			
			var metadata : Object = getObjectMetadata(object);
			if (metadata != null) {
				var propertyMetadata : Object = metadata[property][metadataName];
				result = propertyMetadata[key] as String;
			}
			
			return result;
		}
		
		private static function getClassByName(className : String, packageName : String) : Class {
			var result : Class;
			
			if (className.indexOf(".") > 0 || Objects.isPrimitiveClassName(className)) {
				result = Class(getDefinitionByName(className));
			} else {
				result = Class(getDefinitionByName(packageName + className));
			}

			return result;
		}
		
		public static function getPropertiesGroupsByMetadata(object : Object) : PropertiesGroupCollection {
			var result : PropertiesGroupCollection = new PropertiesGroupCollection();
			processMetadata(object, result);
			return result;
		}
		
		public static function addPropertiesToGroupByMetadata(group : PropertiesGroup, object : Object) : void {
			processMetadata(object, null, group);
		}
		
		public static function getCDATA(string : String) : XML {
			return new XML("<![CDATA[" + string + "]]>");
		}
		
		public static function restoreStringPropertyByXMLAttribute(xml : XML, attribute : String, host : Object, property : String = null) : void {
			if (String(xml.@[attribute]) != null && String(xml.@[attribute]) != "") {
				host[property == null ? attribute : property] = String(xml.@[attribute]);
			}
		}

		public static function serializeStringPropertyByXMLAttribute(xml : XML, attribute : String, host : Object, property : String = null) : void {
			if (host[property == null ? attribute : property] != null) {
				xml.@[attribute] = String(host[property == null ? attribute : property]);
			}
		}
		
		private static function processMetadata(object : Object, propertiesGroups : PropertiesGroupCollection = null, group : PropertiesGroup = null) : void {
			var metadata : Object = getObjectMetadata(object);
			if (metadata != null) {
				for (var property : String in metadata) {
					var propertyMetadata : Object = metadata[property][CustomMetadataNames.EDITABLE];
					if (propertyMetadata != null) {
						proccessEditableMetadata(propertiesGroups, group, object, property, propertyMetadata);
					}
				}
			}
		}
		
		private static function proccessEditableMetadata(propertiesGroups : PropertiesGroupCollection, 
				group : PropertiesGroup, object : Object, property : String, metadata : Object) : void {
			var editorClassName : String = metadata[CustomMetadataKeyNames.EDITOR] as String;
			if (editorClassName != null) {
				var editorClass : Class = PropertiesUtil.getEditorClassByName(editorClassName);
				
				var propertyGroup : String = metadata[CustomMetadataKeyNames.GROUP] as String;
				if ((propertyGroup == null || propertyGroup == "") && group == null) {
					throw new IllegalArgumentError("There is no 'group' for property editor inside Editable metadata!");
				}
				
				var propertyDependentGroup : String = metadata[CustomMetadataKeyNames.DEPENDENT_GROUP] as String;
				var propertyLabel : String = metadata[CustomMetadataKeyNames.LABEL] as String;
				var propertyDescription : String = metadata[CustomMetadataKeyNames.DESCRIPTION] as String;
				var propertyIndex : int = parseInt(metadata[CustomMetadataKeyNames.INDEX] as String);
				var propertyBindable : Boolean = Objects.parseToRightType(metadata[CustomMetadataKeyNames.BINDABLE]) as Boolean;

				var propertyDefinition : PropertyDefinition = new PropertyDefinition(property, object, editorClass, metadata,
						propertyDependentGroup, 
						propertyLabel, 
						propertyDescription,
						propertyIndex,
						propertyBindable);
						
				if (group != null) {
					group.properties.addItem(propertyDefinition);
				} 
				
				if (propertiesGroups != null) {
					propertiesGroups.addProperty(propertyGroup,	propertyDefinition);
				}
			}
		}
		
		private static var _foo : LinkClasses;

	}
	
}