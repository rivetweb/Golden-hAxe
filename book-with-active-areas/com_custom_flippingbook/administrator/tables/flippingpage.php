<?php
/**********************************************
* 	FlippingBook Gallery Component.
*	© Mediaparts Interactive. All rights reserved.
* 	Released under Commercial License.
*	www.page-flip-tools.com
**********************************************/
defined('_JEXEC') or die();

class TableFlippingPage extends JTable {
	
	var $id = null;
	var $file = null;
	var $book_id = null;
	var $description = null;
	var $ordering = null;
	var $published = null;
	var $link_url = null;
	var $zoom_url = null;
	var $zoom_height = null;
	var $zoom_width = null;
	var $checked_out_time = null;
	var $checked_out = null;
 
	function __construct( &$_db ) {
		parent::__construct( '#__flippingbook_pages', 'id', $_db );
	}

	function check() {
		return true;
	}
}
?>
