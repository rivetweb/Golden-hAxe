package ;

import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.Lib;
import flash.display.SimpleButton;
import flash.net.URLRequest;

class CatalogButton extends SimpleButton {
	public function new() {
		super();
		
		addEventListener(
			MouseEvent.CLICK,
			function (e:MouseEvent) {
				var s:String = e.target.name;
				s = StringTools.replace(s, "bcat_", "");
				
				/*
					Марсель - Карта Мира:			bcat_1
					Марсель - Весовой: 				bcat_2
					Марсель - Пакетированный:	bcat_3
					ФС - Элегантная классика:	bcat_4
					ФС - Модерн: 							bcat_5
					ФС - Любимые вкусы: 			bcat_13
					ФР - Коллекция фкусов: 		bcat_7
					ФР - Ароматы мира: 				bcat_8
					ФР - Чаша цейлона: 				bcat_9
					ФР - Англия: 							bcat_10
				*/

				var url = "http://lotos-tea.ru/cat_group.php?id=";
				var u:URLRequest=new URLRequest(url + s);
					
				//untyped __global__["flash.net.navigateToURL"](u);
				Lib.getURL(u);
			});
	}
	
}