<?php
/**********************************************
* 	FlippingBook Gallery Component.
*	© Mediaparts Interactive. All rights reserved.
* 	Released under Commercial License.
*	www.page-flip-tools.com
**********************************************/
defined('_JEXEC') or die();

class TableFlippingBook extends JTable {

	var $id = null;
	var $alias = null;
	var $allow_pages_unload = null;
	var $always_opened = null;
	var $auto_flip_size= null;
	var $background_color = null;
	var $background_image = null;
	var $background_image_placement = null;
	var $book_height = null;
	var $book_width = null;
	var $category_id = null;
	var $center_book = null;
	var $checked_out = null;
	var $checked_out_time = null;
	var $created = null;
	var $description = null;
	var $download_size = null;
	var $download_title = null;
	var $download_url = null;
	var $dynamic_shadows_depth = null;
	var $emailIcon = null;
	var $first_last_buttons = null;
	var $first_page = null;
	var $flash_height = null;
	var $flash_width = null;
	var $flip_corner_style = null;
	var $fullscreen_enabled = null;
	var $go_to_page_field = null;
	var $hardcover = null;
	var $hits = null;
	var $modified = null;
	var $navigation_bar = null;
	var $navigation_bar_placement = null;
	var $new_window_height = null;
	var $new_window_width = null;
	var $open_book_in = null;
	var $ordering = null;
	var $page_background_color = null;
	var $preview_image = null;
	var $print_enabled = null;
	var $printIcon = null;
	var $published = null;
	var $scale_content = null;
	var $show_book_description = null;
	var $show_book_title = null;
	var $show_pages_description = null;
	var $show_slide_show_button = null;
	var $slideshow_auto_play = null;
	var $slideshow_button = null;
	var $slideshow_display_duration = null;
	var $static_shadows_depth = null;
	var $static_shadows_type = null;
	var $title = null;
	var $zoom_enabled = null;
	var $zoom_image_height = null;
	var $zoom_image_width = null;
	var $zooming_method = null;
	var $zoom_ui_color = null;

	function __construct( &$_db ) {
		parent::__construct( '#__flippingbook_books', 'id', $_db );
	}

	function check() {
		if(empty($this->alias)) {
			$this->alias = $this->title;
		}
		$this->alias = JFilterOutput::stringURLSafe($this->alias);
		if(trim(str_replace('-','',$this->alias)) == '') {
			$datenow =& JFactory::getDate();
			$this->alias = $datenow->toFormat("%Y-%m-%d-%H-%M-%S");
		}
		return true;
	}
}
?>