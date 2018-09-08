<?php
/**********************************************
* 	FlippingBook Gallery Component.
*	© Mediaparts Interactive. All rights reserved.
* 	Released under Commercial License.
*	www.page-flip-tools.com
**********************************************/
defined( '_JEXEC' ) or die( 'Restricted access' );

require_once( JApplicationHelper::getPath( 'toolbar_html' ) );

switch ($task) {
	case 'configuration':
		TOOLBAR_flippingbook::_CONFIGURATION();
		break;
	case 'category_manager':
		TOOLBAR_flippingbook::_CATEGORY_MANAGER();
		break;
	case 'add_category':
		$id = JRequest::getVar( 'id', 0, '', 'int' );
		TOOLBAR_flippingbook::_EDIT_CATEGORY( $id );
		break;
	case 'edit_category':
		$cid = JRequest::getVar( 'cid', array(0), '', 'array' );
		JArrayHelper::toInteger($cid, array(0));
		TOOLBAR_flippingbook::_EDIT_CATEGORY( $cid[0] );
		break;
	case 'book_manager':
		TOOLBAR_flippingbook::_BOOK_MANAGER();
		break;
	case 'add_book':
		$id = JRequest::getVar( 'id', 0, '', 'int' );
		TOOLBAR_flippingbook::_EDIT_BOOK( $id );
		break;
	case 'edit_book':
		$cid = JRequest::getVar( 'cid', array(0), '', 'array' );
		JArrayHelper::toInteger($cid, array(0));
		TOOLBAR_flippingbook::_EDIT_BOOK( $cid[0] );
		break;
	case 'page_manager':
		TOOLBAR_flippingbook::_PAGE_MANAGER();
		break;
	case 'add_page':
		$id = JRequest::getVar( 'id', 0, '', 'int' );
		TOOLBAR_flippingbook::_EDIT_PAGE( $id );
		break;
	case 'edit_page':
		$cid = JRequest::getVar( 'cid', array(0), '', 'array' );
		JArrayHelper::toInteger($cid, array(0));
		TOOLBAR_flippingbook::_EDIT_PAGE( $cid[0] );
		break;
	case 'batch_add_pages':
		TOOLBAR_flippingbook::_BATCH_ADD_PAGES();
		break;
	case 'file_manager':
	case 'upload_file':
	case 'remove_files':
		TOOLBAR_flippingbook::_FILE_MANAGER();
		break;
	default:
		TOOLBAR_flippingbook::_DEFAULT();
		break;
}
?>