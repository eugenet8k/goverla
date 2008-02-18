package org.goverla.localization
{
	import mx.utils.StringUtil;
	
	// Deprecated. Use Flex 3 localization
	public class Localiztion
	{
		public static var messagesObject : Object = new Object();
		
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