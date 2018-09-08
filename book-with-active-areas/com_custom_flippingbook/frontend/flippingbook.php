<?php
/**********************************************
* 	FlippingBook Gallery Component.
*	� Mediaparts Interactive. All rights reserved.
* 	Released under Commercial License.
*	www.page-flip-tools.com
**********************************************/
defined('_JEXEC') or die('Restricted access');

	// Require the base controller
	require_once (JPATH_COMPONENT.DS.'controller.php');

	// Require specific controller if requested
	
 	if($controller = JRequest::getWord('controller')) {
		$path = JPATH_COMPONENT.DS.'controllers'.DS.$controller.'.php';
		if (file_exists($path)) {
			require_once $path;
		} else {
			$controller = '';
		}
	}

	// Create the controller
	$classname	= 'FlippingBookController'.ucfirst($controller);
	$controller = new $classname( );

	// Perform the Request task
	$controller->execute(JRequest::getCmd('task'));

	// Redirect if set by the controller
	$controller->redirect();