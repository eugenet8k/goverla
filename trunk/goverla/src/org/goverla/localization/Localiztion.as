package org.goverla.localization
{
	import mx.utils.StringUtil;
	
	import org.goverla.localization.interfaces.IResourceBundleFactory;
	
	// Deprecated. Use Flex 3 localization
	public class Localiztion
	{
		public static var urlPrefix : String = "";

		public static var messagesObject : Object = new Object();

		private static var bundles : Object = new Object();
		
		private static var _bundlesFactory : IResourceBundleFactory;
		private static var _locale : String = "enUS";
		
	
		public static function get locale():String
		{
			return _locale;
		}

		public static function set locale(value:String):void
		{
			if(locale != value)
			{
				_locale = value;
				for each(var bundle : ResourceBundle in bundles)
				{
					bundle.locale = value;
				}
			}
		}

		public static function getBundle(id : String) : ResourceBundle
		{
			if(bundles[id] != null)
			{
				return bundles[id];
			}
			else
			{
				var bundle : ResourceBundle = new ResourceBundle(id);
				bundles[id] = bundle;
				bundle.locale = locale;
				return bundle;
			}
			
		}
		public static function getUrl(bundleId : String, locale : String) : String
		{
			return StringUtil.substitute("{0}{1}.{2}.xml", urlPrefix, bundleId, locale);
		}
		
		public static function loadMessages(url : String = "messages.enUS.xml", messagesObject : Object = null) : void
		{
			var messages : Object = Localiztion.messagesObject;
			if(messagesObject != null)
			{
				messages = messagesObject;
			}
			var action : LoadMessagesAction = new LoadMessagesAction(url, messages);
			action.execute();
		}

		public static function loadLocale(locale : String = "enUS", urlPrefix : String = "messages", messagesObject : Object = null) : void
		{
			loadMessages(StringUtil.substitute("{0}.{1}.xml", urlPrefix, locale), messagesObject);
			
		}
		
		public static function loadLocaleToObject(locale : String, messagesObject : Object) : void
		{
			loadLocale(locale, "messages", messagesObject);
		}
		
		public static function loadToObject(messagesObject : Object) : void
		{
			loadMessages("messages.enUS.xml", messagesObject);
		}
	}
}