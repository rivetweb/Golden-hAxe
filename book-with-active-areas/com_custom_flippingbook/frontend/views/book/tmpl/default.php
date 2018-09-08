<?php 
/**********************************************
* 	FlippingBook Gallery Component.
*	� Mediaparts Interactive. All rights reserved.
* 	Released under Commercial License.
*	www.page-flip-tools.com
**********************************************/

defined('_JEXEC') or die('Restricted access');

//ONLY ONE BOOK CAN BE DISPLAYED ON PAGE
if ( defined("FB_BOOK_DISPLAYED") ) 
	echo '<div class="fb_errorMessage">FlippingBook: Only one book can be displayed on page.</div>' . "\n";
else {
	//GET BOOK ID
	$book_id = intval(JRequest::getVar( 'id', 0, 'get', 'int'));
	if ( isset($book_id_for_module) ) $book_id = $book_id_for_module;

	//LOAD BOOK PARAMETERS
	$db	=& JFactory::getDBO();
	$db->setQuery("SELECT * FROM #__flippingbook_books WHERE id=" . $book_id);
	$bookRow = $db->loadObjectList();
	$bookParams = $bookRow[0];

	if (count($bookParams) == 0)
		echo '<div class="fb_errorMessage">FlippingBook: The requested book was not found.</div>' . "\n";
	else { 
		//SHOW BOOK
		
		//UPDATE COUNTER
		$db->setQuery("UPDATE #__flippingbook_books SET hits=(hits+1) WHERE id=" . $book_id );
		$db->query();
		
		$firstPageNumber = intval(JRequest::getVar( 'firstPageNumber', '', 'get', 'int'));
		if ($firstPageNumber == '') $firstPageNumber = $bookParams->first_page;
		if ($firstPageNumber == 0) $firstPageNumber = 1;

		//CSS STYLES
		$document=& JFactory::getDocument();
		$headerTad='<link rel="stylesheet" href="' . JURI::base(true) . '/components/com_flippingbook/css/' . FB_theme . '" type="text/css" />';
		$document->addCustomTag($headerTad);

		//JS LIBRARIES
		$headerTad='<script type="text/javascript" src="' . JURI::base(true) . '/components/com_flippingbook/js/swfobject.js"></script>';
		$document->addCustomTag($headerTad);
		$headerTad='<script type="text/javascript" src="' . JURI::base(true) . '/components/com_flippingbook/js/flippingbook.js"></script>';
		$document->addCustomTag($headerTad);
		$headerTad='<script type="text/javascript" src="' . JURI::base(true) . '/components/com_flippingbook/js/jquery-1.2.6.pack.js"></script>';
		$document->addCustomTag($headerTad);
		if ($bookParams->zooming_method == 1) {
			$headerTad='<script type="text/javascript" src="' . JURI::base(true) . '/components/com_flippingbook/js/ajax-zoom.js"></script>';
			$document->addCustomTag($headerTad);
			$headerTad='<link rel="stylesheet" href="' . JURI::base(true) . '/components/com_flippingbook/js/ajax-zoom.css" type="text/css" />';
			$document->addCustomTag($headerTad);
		}

		//NOTE image info block
		/*$headerTad='<script type="text/javascript" src="' .
			JURI::base(true) .
			'/components/com_virtuemart/fetchscript.php?gzip=0&subdir[0]=/themes/default&file[0]=theme.js&subdir[1]=/js&file[1]=sleight.js&subdir[2]=/js/mootools&file[2]=mootools-release-1.11.js&subdir[3]=/js/mootools&file[3]=mooPrompt.js"></script>';
		$document->addCustomTag($headerTad);*/
		$headerTad='<script type="text/javascript" src="' .
			JURI::base(true) .
			'/components/com_flippingbook/js/dynamic_page.js"></script>';
		$document->addCustomTag($headerTad);

		// FLASH OBJECT
		$output_html = '<div id="fbContainer">' . "\n";
		$output_html .= '	<a id="altmsg" class="altlink" href="http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash" target="_blank">Download Adobe Flash Player.</a>' . "\n";
		$output_html .= '</div>' . "\n";
		
		// JS BOOK SETTINGS
		$output_html .= '<script language="JavaScript" type="text/javascript">' . "\n";
		$db->setQuery("SELECT * FROM #__flippingbook_pages WHERE book_id = " . $book_id . " AND published = 1 ORDER BY ordering");
		$rows = $db->loadObjectList();
		
		//PAGES
		$output_html .= 'flippingBook.pages = [' . "\n";
		for ($i = 0; $i < count($rows); $i++ ) {
			
			//NOTE image info block
			$_tmp_fname = "cid".$rows[$i]->id.".swf";
			if (!file_exists("images/flippingbook/".$_tmp_fname))
				$_tmp_fname = $rows[$i]->file;
			
			$output_html .= '"' . JURI::base(true) . "/images/flippingbook/" . 
				//$rows[$i]->file;
				$_tmp_fname;
			
			if ( $i != (count($rows)-1) ) 
				$output_html .= '|",' . "\n";
			else 
				$output_html .= '"' . "\n";
		}
		$output_html .= '];' . "\n\n";
		
		// ZOOMED IMAGES
		$output_html .= 'flippingBook.enlargedImages = [' . "\n";
		for ( $i = 0; $i < count($rows); $i++ ) {
			if ( $rows[$i]->zoom_url == "" ) 
				$rows[$i]->zoom_url = $rows[$i]->file;

			//NOTE image info block
			$_tmp_fname = "zoom_cid".$rows[$i]->id.".swf";
			if (!file_exists("images/flippingbook/".$_tmp_fname))
				$_tmp_fname = $rows[$i]->zoom_url;
			
			$output_html .= '"' . JURI::base(true) . "/images/flippingbook/" .
				//$rows[$i]->zoom_url;
				$_tmp_fname;

			if ( $i != (count($rows)-1) ) 
				$output_html .= '|",' . "\n";
			else 
				$output_html .= '"' . "\n";
		}
		$output_html .= '];' . "\n\n";
		
		// PAGE LINKS
		$output_html .= 'flippingBook.pageLinks = [' . "\n";
		for ( $i = 0; $i < count($rows); $i++ ) {
			// replace & symbol in url with %26
			$rows[$i]->link_url = str_replace ('&', '%26', $rows[$i]->link_url );
			
			$output_html .= '"' . $rows[$i]->link_url;
			if ( $i != (count($rows)-1) ) 
				$output_html .= '|",' . "\n";
			else 
				$output_html .= '"' . "\n";
		}
		$output_html .= '];' . "\n\n";
		
		// SWF FILES SIZES FOR AJAX ZOOMING
		if ($bookParams->zooming_method == 1) {
			$output_html .= 'flippingBook.swfHeight = [' . "\n";
			for ( $i = 0; $i < count($rows); $i++ ) {
				$output_html .= '"' . $rows[$i]->zoom_height;
				if ( $i != (count($rows)-1) ) 
					$output_html .= '|",' . "\n";
				else 
					$output_html .= '"' . "\n";
			}
			$output_html .= '];' . "\n\n";
			$output_html .= 'flippingBook.swfWidth = [' . "\n";
			for ( $i = 0; $i < count($rows); $i++ ) {
				$output_html .= '"' . $rows[$i]->zoom_width;
				if ( $i != (count($rows)-1) ) 
					$output_html .= '|",' . "\n";
				else 
					$output_html .= '"' . "\n";
			}
			$output_html .= '];' . "\n\n";
		}

		//BOOK PARAMETERS
		$output_html .= 'flippingBook.stageWidth = "' . $bookParams->flash_width . '";' . "\n";
		$output_html .= 'flippingBook.stageHeight = "' . $bookParams->flash_height . '";' . "\n";
		$output_html .= 'flippingBook.settings.bookWidth = "' . $bookParams->book_width*2 . '";' . "\n";
		$output_html .= 'flippingBook.settings.bookHeight = "' . $bookParams->book_height . '";' . "\n";
		$output_html .= 'flippingBook.settings.firstPageNumber = "' . $firstPageNumber . '";' . "\n";
		if ( $bookParams->navigation_bar != "" )
			$output_html .= 'flippingBook.settings.navigationBar = "' . JURI::base(true) . '/components/com_flippingbook/navigationbars/' . $bookParams->navigation_bar . '";' . "\n";
		$output_html .= 'flippingBook.settings.navigationBarPlacement = "' . $bookParams->navigation_bar_placement . '";' . "\n";
		$output_html .= 'flippingBook.settings.pageBackgroundColor = 0x' . $bookParams->page_background_color . ';' . "\n";
		$output_html .= 'flippingBook.settings.backgroundColor = "' . $bookParams->background_color . '";' . "\n";
		$output_html .= 'flippingBook.settings.backgroundImage = "' . JURI::base(true) . '/images/flippingbook/' . $bookParams->background_image . '";' . "\n";
		$output_html .= 'flippingBook.settings.backgroundImagePlacement = "' . $bookParams->background_image_placement . '";' . "\n";
		$output_html .= 'flippingBook.settings.staticShadowsType = "' . $bookParams->static_shadows_type . '";' . "\n";
		$output_html .= 'flippingBook.settings.staticShadowsDepth = "' . $bookParams->static_shadows_depth . '";' . "\n";
		$output_html .= 'flippingBook.settings.autoFlipSize = "' . $bookParams->auto_flip_size . '";' . "\n";
		$center_book = $bookParams->center_book == 1 ? "true" : "false";
		$output_html .= 'flippingBook.settings.centerBook = ' . $center_book . ';' . "\n";
		$scale_content = $bookParams->scale_content == 1 ? "true" : "false";
		$output_html .= 'flippingBook.settings.scaleContent = ' . $scale_content . ';' . "\n";
		$always_opened = $bookParams->always_opened == 1 ? "true" : "false";
		$output_html .= 'flippingBook.settings.alwaysOpened = ' . $always_opened . ';' . "\n";
		$output_html .= 'flippingBook.settings.flipCornerStyle = "' . $bookParams->flip_corner_style . '";' . "\n";
		$hardcover = $bookParams->hardcover == 1 ? "true" : "false";
		$output_html .= 'flippingBook.settings.hardcover = ' . $hardcover . ';' . "\n";
		$output_html .= 'flippingBook.settings.downloadURL = "' . $bookParams->download_url . '";' . "\n";
		$output_html .= 'flippingBook.settings.downloadTitle = "' . $bookParams->download_title . '";' . "\n";
		$output_html .= 'flippingBook.settings.downloadSize = "' . $bookParams->download_size . '";' . "\n";
		$allow_pages_unload = $bookParams->allow_pages_unload == 1 ? "true" : "false";
		$output_html .= 'flippingBook.settings.allowPagesUnload = ' . $allow_pages_unload . ';' . "\n";
		$fullscreen_enabled = $bookParams->fullscreen_enabled == 1 ? "true" : "false";
		$output_html .= 'flippingBook.settings.fullscreenEnabled = ' . $fullscreen_enabled . ';' . "\n";
		$zoom_enabled = $bookParams->zoom_enabled == 1 ? "true" : "false";
		$output_html .= 'flippingBook.settings.zoomEnabled = ' . $zoom_enabled . ';' . "\n";
		$output_html .= 'flippingBook.settings.zoomImageWidth = "' . $bookParams->zoom_image_width . '";' . "\n";
		$output_html .= 'flippingBook.settings.zoomImageHeight = "' . $bookParams->zoom_image_height . '";' . "\n";
		$output_html .= 'flippingBook.settings.zoomUIColor = 0x' . $bookParams->zoom_ui_color . ';' . "\n";
		$slideshow_button = $bookParams->slideshow_button == 1 ? "true" : "false";
		$output_html .= 'flippingBook.settings.slideshowButton = ' . $slideshow_button . ';' . "\n";
		$slideshow_auto_play = $bookParams->slideshow_auto_play == 1 ? "true" : "false";
		$output_html .= 'flippingBook.settings.slideshowAutoPlay = ' . $slideshow_auto_play . ';' . "\n";
		$output_html .= 'flippingBook.settings.slideshowDisplayDuration = "' . $bookParams->slideshow_display_duration . '";' . "\n";
		$go_to_page_field = $bookParams->go_to_page_field == 1 ? "true" : "false";
		$output_html .= 'flippingBook.settings.goToPageField = ' . $go_to_page_field . ';' . "\n";
		$first_last_buttons = $bookParams->first_last_buttons == 1 ? "true" : "false";
		$output_html .= 'flippingBook.settings.firstLastButtons = ' . $first_last_buttons . ';' . "\n";
		$print_enabled = $bookParams->print_enabled == 1 ? "true" : "false";
		$output_html .= 'flippingBook.settings.printEnabled = ' . $print_enabled . ';' . "\n";
		$zooming_method = $bookParams->zooming_method == 1 ? '"ajax"' : '"flash"';
		$output_html .= 'flippingBook.settings.zoomingMethod = ' . $zooming_method . ';' . "\n";

		// GLOBAL SETTINGS	
		FB_zoomOnClick == 1 ? $zoomOnClick = "true" : $zoomOnClick = "false";
		$output_html .= 'flippingBook.settings.zoomOnClick = ' . $zoomOnClick . ';' . "\n";
		$output_html .= 'flippingBook.settings.moveSpeed = "' . FB_moveSpeed . '";' . "\n";
		$output_html .= 'flippingBook.settings.closeSpeed = "' . FB_closeSpeed . '";' . "\n";
		$output_html .= 'flippingBook.settings.gotoSpeed = "' . FB_gotoSpeed . '";' . "\n";
		$output_html .= 'flippingBook.settings.rigidPageSpeed = "' . FB_rigidPageSpeed . '";' . "\n";
		$output_html .= 'flippingBook.settings.zoomHint = "' . FB_zoomHint . '";' . "\n";
		$output_html .= 'flippingBook.settings.printTitle = "' . FB_printTitle . '";' . "\n";
		$output_html .= 'flippingBook.settings.downloadComplete = "' . FB_downloadComplete . '";' . "\n";
		FB_dropShadowEnabled == 1 ? $dropShadowEnabled = "true" : $dropShadowEnabled = "false";
		$output_html .= 'flippingBook.settings.dropShadowEnabled = ' . $dropShadowEnabled . ';' . "\n";
		if ( FB_flipSound != "")
			$output_html .= 'flippingBook.settings.flipSound = "' . JURI::base(true) . '/components/com_flippingbook/sounds/' . FB_flipSound . '";' . "\n";
		if ( FB_hardcoverSound != "")
			$output_html .= 'flippingBook.settings.hardcoverSound = "' . JURI::base(true) . '/components/com_flippingbook/sounds/' . FB_hardcoverSound . '";' . "\n";
		$output_html .= 'flippingBook.settings.preloaderType = "' . FB_preloaderType . '";' . "\n";
		$output_html .= 'flippingBook.settings.Ioader = true;' . "\n";

		// SHOW FLASH OBJECT
		$output_html .= 'flippingBook.create("' . JURI::base(true) . '/components/com_flippingbook/flippingbook.swf");' . "\n";
		$output_html .= 'jQuery.noConflict();' . "\n";
		
		// PREPARE AJAX ZOOMING
		if ($bookParams->zooming_method == 1) {
			$output_html .= 'jQuery(document).ready(function() {' . "\n";
			$output_html .= '	zoom_init("' . JURI::root() . '");' . "\n";
			$output_html .= '});' . "\n";
		}
		
		$output_html .= '</script>' . "\n";

		//PAGE DESCRIPTION BLOCK
		if ( $bookParams->show_pages_description == 1 ) {
			$output_html .= '<div id="fb_pageDescription"><div id="fb_leftPageDescription"></div>' . "\n";
			$output_html .= '<div id="fb_rightPageDescription"></div></div>' . "\n";
		}

		//BOOK DESCRIPTION BLOCK
		if ( $bookParams->show_book_description == 1 ) {
			$output_html .= '<div id="fb_bookDescription">' . $bookParams->description . "</div>\n\n";
		}

		//LOADING PAGES DESCRIPTION IN HIDDEN DIVS
		if ( $bookParams->show_pages_description == 1 ) { 
			$page_decriptions = '';
			$db->setQuery("SELECT * FROM #__flippingbook_pages WHERE book_id = " . $book_id . " AND published = 1 ORDER BY ordering");
			$rows = $db->loadObjectList();
			$i = 1;
			foreach ( $rows as $row ) {
				$page_decriptions .= '<div id="fb_page_' . $i . '">' . $row->description . "</div>\n";
				$i++;
			}
			$output_html .= '<div id="fb_hidden" style="position: absolute; visibility: hidden; display: none;">' . "\n" . $page_decriptions . "</div>\n";
		}

		$output_html .= "\n<!-- FlippingBook Gallery Component. End. -->\n\n";

		define("FB_BOOK_DISPLAYED", "1");
		if ( empty($call_from_plugin) )
			echo $output_html;
	}
}
?>