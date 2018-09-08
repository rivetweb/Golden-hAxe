<?php
/**********************************************
* 	FlippingBook Gallery Component.
*	© Mediaparts Interactive. All rights reserved.
* 	Released under Commercial License.
*	www.page-flip-tools.com
**********************************************/
defined('_JEXEC') or die();

class TableFlippingCategory extends JTable {

	var $id = null;
	var $title = null;
	var $alias = null;
	var $description = null;
	var $published = null;
	var $ordering = null;
	var $checked_out_time = null;
	var $checked_out = null;
	var $emailIcon = null;
	var $printIcon = null;
	var $columns = null;
	var $preview_image = null;
	var $show_title = null;

	function __construct( &$_db ) {
		parent::__construct( '#__flippingbook_categories', 'id', $_db );
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