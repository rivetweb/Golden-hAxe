<?php
/**********************************************
* 	FlippingBook Gallery Component.
*	© Mediaparts Interactive. All rights reserved.
* 	Released under Commercial License.
*	www.page-flip-tools.com
**********************************************/
defined( '_JEXEC' ) or die( 'Restricted access' );

class TOOLBAR_flippingbook {
	
	function _CONFIGURATION() {
		JToolBarHelper::title(  JText::_( 'FlippingBook' ) .': <small> : '.JText::_( 'Configuration' ).'</small>' );
		JToolBarHelper::save( 'save_configuration', 'Save' );
		JToolBarHelper::apply( 'apply_configuration', 'Apply' );
		JToolBarHelper::cancel( 'cancel_configuration', 'Cancel' );
		JToolBarHelper::help( '../help.html', true );
	}
	
	function _EDIT_CATEGORY( $categoryid ) {
		$cid = JRequest::getVar( 'cid', array(0), '', 'array' );
		JArrayHelper::toInteger($cid, array(0));

		$text = ( $cid[0] ? JText::_( 'Edit Category' ) : JText::_( 'New Category' ) );

		JToolBarHelper::title(  JText::_( 'FlippingBook' ).': <small> : '.JText::_( 'Category Manager' ).' : <small>[ ' . $text.' ]</small></small>' );
		JToolBarHelper::save( 'save_category', 'Save' );
		JToolBarHelper::apply( 'apply_category', 'Apply' );
		if ($cid[0]) {
			// for existing items the button is renamed `close`
			JToolBarHelper::cancel( 'cancel_category', 'Close' );
		} else {
			JToolBarHelper::cancel( 'cancel_category', 'Cancel' );
		}
		JToolBarHelper::help( '../help.html', true );
	}
	
	function _CATEGORY_MANAGER() {
		JToolBarHelper::title(  JText::_( 'FlippingBook') .': <small> : '.JText::_( 'Category Manager' ).'</small>' );
		JToolBarHelper::publishList();
		JToolBarHelper::unpublishList();
		JToolBarHelper::deleteList( '', 'remove_category', 'Delete' );
		JToolBarHelper::editListX( 'edit_category', 'Edit' );
		JToolBarHelper::addNewX( 'add_category', 'New' );
		JToolBarHelper::help( '../help.html', true );
	}

	
	function _EDIT_BOOK( $bookid ) {
		$cid = JRequest::getVar( 'cid', array(0), '', 'array' );
		JArrayHelper::toInteger($cid, array(0));

		$text = ( $cid[0] ? JText::_( 'Edit Book' ) : JText::_( 'New Book' ) );

		JToolBarHelper::title(  JText::_( 'FlippingBook' ).': <small> : '.JText::_( 'Book Manager' ).' : <small>[ ' . $text.' ]</small></small>' );
		JToolBarHelper::save( 'save_book', 'Save' );
		JToolBarHelper::apply( 'apply_book', 'Apply' );
		if ($cid[0]) {
			// for existing items the button is renamed `close`
			JToolBarHelper::cancel( 'cancel_book', 'Close' );
		} else {
			JToolBarHelper::cancel( 'cancel_book', 'Cancel' );
		}
		JToolBarHelper::help( '../help.html', true );
	}
	
	function _BOOK_MANAGER() {
		JToolBarHelper::title(  JText::_( 'FlippingBook') .': <small> : '.JText::_( 'Book Manager' ).'</small>' );
		JToolBarHelper::publishList();
		JToolBarHelper::unpublishList();
		JToolBarHelper::deleteList( '', 'remove_book', 'Delete' );
		JToolBarHelper::editListX( 'edit_book', 'Edit' );
		JToolBarHelper::addNewX( 'add_book', 'New' );
		JToolBarHelper::customX( 'clone_book', 'copy.png', 'copy_f2.png', 'Copy' );
		JToolBarHelper::help( '../help.html', true );
	}

	function _EDIT_PAGE( $pageid ) {
		$cid = JRequest::getVar( 'cid', array(0), '', 'array' );
		JArrayHelper::toInteger($cid, array(0));

		$text = ( $cid[0] ? JText::_( 'Edit Page' ) : JText::_( 'New Page' ) );

		JToolBarHelper::title(  JText::_( 'FlippingBook' ).': <small> : '.JText::_( 'Page Manager' ).' : <small>[ ' . $text.' ]</small></small>' );
		JToolBarHelper::save( 'save_page', 'Save' );
		JToolBarHelper::apply( 'apply_page', 'Apply' );
		if ($cid[0]) {
			// for existing items the button is renamed `close`
			JToolBarHelper::cancel( 'cancel_page', 'Close' );
		} else {
			JToolBarHelper::cancel( 'cancel_page', 'Cancel' );
		}
		JToolBarHelper::help( '../help.html', true );
	}
	
	function _PAGE_MANAGER() {
		JToolBarHelper::title(  JText::_( 'FlippingBook') .': <small> : '.JText::_( 'Page Manager' ).'</small>' );
		JToolBarHelper::publishList();
		JToolBarHelper::unpublishList();
		JToolBarHelper::deleteList( '', 'remove_page', 'Delete' );
		JToolBarHelper::editListX( 'edit_page', 'Edit' );
		JToolBarHelper::addNewX( 'add_page', 'New' );
		JToolBarHelper::customX( 'clone_page', 'copy.png', 'copy_f2.png', 'Copy' );
		JToolBarHelper::help( '../help.html', true );
	}
	
	function _BATCH_ADD_PAGES() {
		JToolBarHelper::title(  JText::_( 'FlippingBook') .': <small> : '.JText::_( 'Batch Add Pages' ).'</small>' );
		JToolBarHelper::save( 'batch_add_pages_execute', 'Save' );
		JToolBarHelper::cancel( 'cancel_configuration', 'Cancel' );
		JToolBarHelper::help( '../help.html', true );
	}
	
	function _FILE_MANAGER() {
		JToolBarHelper::title(  JText::_( 'FlippingBook') .': <small> : '.JText::_( 'Simple File Manager' ).'</small>' );
		JToolBarHelper::help( '../help.html', true );
	}
	
	function _DEFAULT() {
		JToolBarHelper::title(  JText::_( 'Виртуальные каталоги' ) );
		JToolBarHelper::help( '../help.html', true );
	}
}
?>