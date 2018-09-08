<?php
/**********************************************
* 	FlippingBook Gallery Component.
*	© Mediaparts Interactive. All rights reserved.
* 	Released under Commercial License.
*	www.page-flip-tools.com
**********************************************/

defined('_JEXEC') or die( 'Restricted access' );

class JElementBook extends JElement {
	var	$_name = 'Book';

	function fetchElement($name, $value, &$node, $control_name) {
		$db =& JFactory::getDBO();

		$query = 'SELECT a.id, a.title'
		. ' FROM #__flippingbook_books AS a'
		. ' WHERE a.published = 1'
		. ' ORDER BY a.title'
		;
		$db->setQuery( $query );
		$options = $db->loadObjectList();
		
		return JHTML::_('select.genericlist',  $options, ''.$control_name.'['.$name.']', 'class="inputbox"', 'id', 'title', $value, $control_name.$name );
	}
}