<?php
/**********************************************
* 	FlippingBook Gallery Component.
*	© Mediaparts Interactive. All rights reserved.
* 	Released under Commercial License.
*	www.page-flip-tools.com
**********************************************/
defined('_JEXEC') or die( 'Restricted access' );

jimport('joomla.application.component.model');

class FlippingBookModelBook extends JModel {

	function getBook( &$options ) {
		$db =& JFactory::getDBO();
		$id = @$options['id'];
		$query = 'SELECT c.*, ' .
				' CASE WHEN CHAR_LENGTH(c.alias) THEN CONCAT_WS(\':\', c.id, c.alias) ELSE c.id END as slug '.
				' FROM #__flippingbook_books AS c' .
				' WHERE c.id = '. $id;
		$result = $this->_getList( $query );
		return $result[0];
	}
	
	function countPages ( &$options ) {
		$db =& JFactory::getDBO();
		$id = @$options['id'];
		$db->setQuery( "SELECT COUNT(*) FROM #__flippingbook_pages WHERE book_id = " . $id . " AND published = 1" );
		$total_pages = $db->loadResult();
		return $total_pages;
	}
	
	function loadGlobalVars () {
		//ONLY ONE BOOK CAN BE DISPLAYED ON PAGE
		if ( defined( "FB_categoryListTitle" ) ) return; 

		$db	=& JFactory::getDBO();
		$query = "SELECT name, value FROM #__flippingbook_config";
		$db->setQuery($query);
		$rows = $db->loadObjectList();
		foreach ( $rows as $row ) {
			eval ( "DEFINE('FB_" . $row->name . "', '" . $row->value . "');" );
		}
	}
}