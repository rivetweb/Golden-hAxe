<?php
/**********************************************
* 	FlippingBook Gallery Component.
*	© Mediaparts Interactive. All rights reserved.
* 	Released under Commercial License.
*	www.page-flip-tools.com
**********************************************/
defined( '_JEXEC' ) or die( 'Restricted access' );

require_once( JPATH_COMPONENT.DS.'controller.php' );

// Set the table directory
JTable::addIncludePath( JPATH_COMPONENT.DS.'tables' );

$controller = new FlippingBookController( array('default_task' => 'showMain') );

$controller->execute( JRequest::getCmd( 'task' ) );
$controller->redirect();
?>