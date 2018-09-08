<?php
/**********************************************
* 	FlippingBook Gallery Component.
*	� Mediaparts Interactive. All rights reserved.
* 	Released under Commercial License.
*	www.page-flip-tools.com
**********************************************/
defined('_JEXEC') or die( 'Restricted access' );

jimport('joomla.application.component.controller');

class FlippingBookController extends JController {
	function __construct( $default = array()) {
		parent::__construct( $default );

		//NOTE image info block
		$this->registerTask( 'get_fullimageinfo', 'getFullImageInfo' );
		$this->registerTask( 'get_prodimageinfo', 'getProdImageInfo' );
		$this->registerTask( 'get_scaleinfo', 'getScaleInfo' );
	}

	//NOTE image info block
	function getFullImageInfo(){
		$db	=& JFactory::getDBO();

		$cid = $db->Quote($_REQUEST["cid"]);
		$query = "select images_coords.*,
				#__flippingbook_pages.zoom_url, #__flippingbook_pages.file, #__flippingbook_pages.zoom_height
			from images_coords
			left join #__flippingbook_pages on images_coords.cid = #__flippingbook_pages.id
			where cid = $cid";
		$db->setQuery( $query );
		$rows = $db->loadObjectList();

		$normal_image = getimagesize(JPATH_SITE."/images/flippingbook/".$rows[0]->file);
		$large_image = getimagesize(JPATH_SITE."/images/flippingbook/".$rows[0]->zoom_url);
		$kx = $large_image[0] / $normal_image[0];
		$ky = $large_image[1] / $normal_image[1];

		$kk = $large_image[1] / $rows[0]->zoom_height;

		if(sizeof($rows) > 0){
			$jsondata = str_replace("'", '"', stripslashes($rows[0]->info));
			print '['.
				'"'.$rows[0]->file.'",'.
				'"'.$rows[0]->zoom_url.'",'.
				$kx.','.
				$ky.','.
				$kk.','.
				$jsondata.
			"]";
		}
		else{
			print 0;
		}
		exit();
	}

	function getScaleInfo(){
		$db	=& JFactory::getDBO();

		$cid = $db->Quote($_REQUEST["cid"]);

		$query = "select * from images_coords where cid = $cid";

		$db->setQuery( $query );
		$rows = $db->loadObjectList();

		print_r($rows[0]);

		exit();
	}

	function getProdImageInfo(){
		$db	=& JFactory::getDBO();

		$product_id = $db->Quote($_REQUEST["product_id"]);

		$attr_id = $db->Quote($_REQUEST["attr_id"]);
		$prod_id = $db->Quote($_REQUEST["prod_id"]);

		if($_REQUEST["attr_id"] == "null" || $_REQUEST["attr_id"] = "")
			$query = "SELECT * FROM #__vm_product
				where #__vm_product.product_id = $product_id";		
		else			
			$query = "SELECT #__vm_product_attribute.*, #__vm_product.product_name
				FROM #__vm_product_attribute
				left join #__vm_product
				on #__vm_product_attribute.product_id = #__vm_product.product_id
				where #__vm_product_attribute.product_id = $prod_id and
					#__vm_product_attribute.attribute_id = $attr_id";

		$db->setQuery( $query );
		$rows = $db->loadObjectList();

		if(sizeof($rows) > 0){
			$prod=array();
			foreach(array("product_id", "product_name",
					"attribute_name", "attribute_value") as $k)
				if(isset($rows[0]->{$k}))
					$prod[$k]=$rows[0]->{$k};
				else
					$prod[$k]="";
			print json_encode($prod);
		}
		else{
			print 0;
		}
		exit();
	}

	//--------------------

	function display() {
		if ( ! JRequest::getCmd( 'view' ) ) {
			JRequest::setVar('view', 'categories' );
		}

		if (JRequest::getCmd('view') == 'category') {
			$model =& $this->getModel('category');
		}
		
		if (JRequest::getCmd('view') == 'book') {
			$model =& $this->getModel('book');
		}
		
		parent::display();
	}	
}