<?php
/**********************************************
* 	FlippingBook Gallery Component.
*	� Mediaparts Interactive. All rights reserved.
* 	Released under Commercial License.
*	www.page-flip-tools.com
**********************************************/
defined('_JEXEC') or die();

jimport( 'joomla.application.component.controller' );

$lang = & JFactory::getLanguage();
$lang->load('flippingbook', JPATH_COMPONENT);

function checkVersion() {
	$db	=& JFactory::getDBO();
	require_once( JPATH_COMPONENT . DS . 'updatescript.php' );
}
checkVersion();

class FlippingBookController extends JController {
	function __construct( $default = array()) {
		parent::__construct( $default );
		$this->registerTask( 'main', 'showMain' );
		
		$this->registerTask( 'configuration', 'showConfiguration' );
		$this->registerTask( 'save_configuration', 'saveConfiguration' );
		$this->registerTask( 'apply_configuration', 'saveConfiguration' );
		$this->registerTask( 'cancel_configuration', 'cancelConfiguration' );
		
		$this->registerTask( 'category_manager', 'showCategories' );
		$this->registerTask( 'add_category' , 'editCategory' );
		$this->registerTask( 'edit_category', 'editCategory' );
		$this->registerTask( 'save_category', 'saveCategory' );
		$this->registerTask( 'apply_category', 'saveCategory' );
		$this->registerTask( 'cancel_category', 'cancelCategory');
		$this->registerTask( 'orderup_category', 'reorderCategories' );
		$this->registerTask( 'orderdown_category', 'reorderCategories' );
		$this->registerTask( 'remove_category', 'removeCategory' );
		
		$this->registerTask( 'book_manager', 'showBooks' );
		$this->registerTask( 'add_book' , 'editBook' );
		$this->registerTask( 'edit_book', 'editBook' );
		$this->registerTask( 'save_book', 'saveBook' );
		$this->registerTask( 'apply_book', 'saveBook' );
		$this->registerTask( 'clone_book', 'cloneBook' );
		$this->registerTask( 'cancel_book', 'cancelBook' );
		$this->registerTask( 'orderup_book', 'reorderBooks' );
		$this->registerTask( 'orderdown_book', 'reorderBooks' );
		$this->registerTask( 'remove_book', 'removeBook');
		
		$this->registerTask( 'page_manager', 'showPages' );
		$this->registerTask( 'add_page' , 'editPage' );
		$this->registerTask( 'edit_page', 'editPage' );
		$this->registerTask( 'save_page', 'savePage' );
		$this->registerTask( 'apply_page', 'savePage' );
		$this->registerTask( 'clone_page', 'clonePage' );
		$this->registerTask( 'cancel_page', 'cancelPage');
		$this->registerTask( 'orderup_page', 'reorderPages' );
		$this->registerTask( 'orderdown_page', 'reorderPages' );
		$this->registerTask( 'remove_page', 'removePage' );
		
		$this->registerTask( 'publish', 'publish' );
		$this->registerTask( 'unpublish', 'publish' );
		
		$this->registerTask( 'batch_add_pages', 'batchAddPages' );
		$this->registerTask( 'batch_add_pages_execute', 'batchAddPagesExecute' );
		
		$this->registerTask( 'file_manager', 'manageFiles' );
		$this->registerTask( 'upload_file', 'saveUploadedFiles' );
		$this->registerTask( 'delete_file', 'removeRenameFile' );
		$this->registerTask( 'rename_file', 'removeRenameFile' );
		$this->registerTask( 'create_folder', 'createFolder' );
		$this->registerTask( 'rename_folder', 'renameFolder' );
		$this->registerTask( 'delete_folder', 'deleteFolder' );

		//NOTE image info block
		$this->registerTask( 'get_categs', 'getCategories' );
		$this->registerTask( 'get_products', 'getProducts' );
		$this->registerTask( 'save_imageinfo', 'saveImageInfo' );
		$this->registerTask( 'get_imageinfo', 'getImageInfo' );
		$this->registerTask( 'get_fullimageinfo', 'getFullImageInfo' );
		$this->registerTask( 'get_prodattr', 'getProductAttr' );
		$this->registerTask( 'generate_swf_page', 'generateSwfPage' );
		$this->registerTask( 'remove_swf_page', 'removeSwfPage' );
		$this->registerTask( 'get_scaleinfo', 'getScaleInfo' );

		$this->registerTask( 'generate_all_swf', 'generateAllSwf' );

		//$document = &JFactory::getDocument();
		//$document->addScript("js/some-script.js");
	}

	//NOTE image info block
	function getProducts(){
		$db	=& JFactory::getDBO();

		$where = !isset($_REQUEST["categ_id"])?
			"" : (" and #__vm_category.category_id = ".(int)$_REQUEST["categ_id"]);
		$query = 'SELECT * FROM #__vm_category
			left join #__vm_product_category_xref on #__vm_category.category_id = #__vm_product_category_xref.category_id
			left join #__vm_product on #__vm_product.product_id = #__vm_product_category_xref.product_id
			where #__vm_product.product_id '.$where;

		$db->setQuery( $query );

		$rows = $db->loadObjectList();

		print "<option value=''>-----</option>";
		foreach($rows as $row){
			print "<option value='{$row->product_id}'>".$row->product_name."</option>";
		}

		exit();
	}

	function getCategories(){
		$db	=& JFactory::getDBO();

		$whereArt = !isset($_REQUEST["art"])? "" :
			(" and #__vm_product.product_sku like ".$db->Quote($_REQUEST["art"]."%"));

		$query = 'SELECT * FROM #__vm_category
			left join #__vm_product_category_xref on #__vm_category.category_id = #__vm_product_category_xref.category_id
			left join #__vm_product on #__vm_product.product_id = #__vm_product_category_xref.product_id
			where #__vm_product.product_id '.$whereArt.
			' ORDER BY #__vm_category.category_id';

		$db->setQuery( $query );

		$rows = $db->loadObjectList();

		print "<option disabled value=''>----------</option>";
		$categ="";
		foreach($rows as $row){
			if($categ != $row->category_name){
				print "<option disabled value='' 
					style='background-color:lightgray; color: #777777;'>{$row->category_name}</option>";
				$categ = $row->category_name;
			}
			print "<option value='{$row->category_id},{$row->product_id}'> - ".stripslashes($row->product_name).
				" - [".$row->product_sku."]</option>";
		}
		
		exit();
	}
	
	function saveImageInfo(){
		$db	=& JFactory::getDBO();
		
		$image = $db->Quote($_REQUEST["image"]);
		$cid = $db->Quote($_REQUEST["cid"]);
		$info = $db->Quote($_REQUEST["info"]);

		if($_REQUEST["info"] == ""){
			$query = "delete from images_coords
				where cid = $cid";
			$db->Execute($query);
			exit();
		}

		$tmp = "[".stripslashes($_REQUEST["info"])."]";
		$tmp = str_replace("'", '"', $tmp);
		$res = json_decode($tmp);
		if($res == null)
			print "error 1";
		else{
			$s = array();
			foreach($res as $i => $row){
				//check product exists
				$query = "select product_id from #__vm_product
					where product_id = ".(int)$row[sizeof($row) - 2];
				$is_exists = $db->GetCol($query);
				if($is_exists[0] == null)
					$s[] = $i + 1;
			}
			
			if(sizeof($s) > 0)
				print "error in ".implode(", ", $s);
			else{
				$query = "insert into images_coords (cid, image, info)
					values($cid, $image, $info)
					ON DUPLICATE KEY UPDATE image=$image, info=$info";
				$db->Execute($query);
			}
		}
		exit();
	}

	function getImageInfo(){
		$db	=& JFactory::getDBO();

		$cid = $db->Quote($_REQUEST["cid"]);
		
		$query = "select * from images_coords where cid = $cid";

		$db->setQuery( $query );
		$rows = $db->loadObjectList();

		print "[".str_replace("'", '"', stripslashes($rows[0]->info))."]";
		
		exit();
	}

	/*function getProductAttr(){
		$db	=& JFactory::getDBO();

		$product_id = $db->Quote($_REQUEST["product_id"]);

		$query = "SELECT * FROM #__vm_product
			where #__vm_product.product_id = $product_id";

		$db->setQuery( $query );
		$rows = $db->loadObjectList();

		$props = "";
		if($rows[0]->attribute != "")
			foreach(explode(";", $rows[0]->attribute) as $p){
				$tmp = explode(",", $p);
				$v=array_shift($tmp);
				foreach($tmp as $t){
					$props.="<option value='$v:$t'>$v: $t</option>";
				}
			}

		print "<option disabled value=''>----------</option>";
		print $props;

		exit();
	}*/

	function getProductAttr(){
		$db	=& JFactory::getDBO();

		$product_id = $db->Quote($_REQUEST["product_id"]);

		$query = "SELECT #__vm_product_attribute.*, #__vm_product.product_name
			FROM #__vm_product
			left join #__vm_product_attribute
			on #__vm_product.product_id = #__vm_product_attribute.product_id
			where #__vm_product.product_parent_id = $product_id";

		$db->setQuery( $query );
		$rows = $db->loadObjectList();

		$props = "";
		if(sizeof($rows) > 0)
			foreach($rows as $p){
				$props.="<option
					value='{$p->product_id}:{$p->attribute_id}'>
						{$p->product_name} - {$p->attribute_name} ({$p->attribute_value})</option>";
			}
		print "<option disabled value=''>----------</option>";
		print $props;

		exit();
	}

	/*function generate_swf($id, $src, $dest, $n = 1){
		$cmd = "haxe -swf {filename} -swf-lib resource.swf -swf-header {width}:{height}:20:000000 -lib hxJson2 -main Main";
		$size = getimagesize("../images/flippingbook/".$src);
		$path = JPATH_COMPONENT."/images/";

		$current_path = realpath(".");

		print "<pre>";
		var_dump($path, "../images/flippingbook/".$src,
			$current_path);

		chdir($path."flash_src_new/src");

		var_dump(realpath("."));

		print $cmd."\n";

		//$cmd = str_replace("{filename}", $dest, $cmd);
		$cmd = str_replace("{filename}", basename($dest), $cmd);
		$cmd = str_replace("{width}", $size[0], $cmd);
		$cmd = str_replace("{height}", $size[1], $cmd);

		print $cmd."\n";

		print exec($cmd);

		chdir($current_path);
		
		var_dump(realpath("."));
	}*/

	function generate_swf($id, $src, $dest, $zoom = false){
		$cmd = "swfmill swf2xml ";
		$xml_name = ($zoom? "zoom" : "").$id.".xml";
		$template = ($zoom? "_zoom" : "")."_dynamic_template.swf";

		$size = getimagesize("../images/flippingbook/".$src);
		$width = $size[0];
		$height = $size[1];
		$size[0] = $size[0]*20; // 20 - framerate
		$size[1] = $size[1]*20;
		$path = JPATH_COMPONENT."/images/";

		$cmd .= "{$path}{$template} {$path}{$xml_name}";
		if(file_exists($path.$xml_name))
			unlink($path.$xml_name);
		exec($cmd);

		$contents = file_get_contents($path.$xml_name);
		$contents = preg_replace(
			'{<Rectangle left="0" right="\d+" top="0" bottom="\d+"/>}i',
			'<Rectangle left="0" right="'.$size[0].'" top="0" bottom="'.$size[1].'"/>',
			$contents, 1);
		file_put_contents($path.$xml_name, $contents);

		if(file_exists($dest))
			unlink($dest);
		$cmd = "swfmill xml2swf ".$path.$xml_name." ".$dest;
		exec($cmd);

		//insert image to swf
		$s = file_get_contents($path."create_swf.xml");
		$s = str_replace("{width}", $width, $s);
		$s = str_replace("{height}", $height, $s);
		$s = str_replace("{filename}", "../images/flippingbook/".$src, $s);
		$s = str_replace("{template}", $dest, $s);
		file_put_contents($path.basename($dest).".xml", $s);
		
		$cmd = "swfmill simple ".$path.basename($dest).".xml ".$dest.".tmp";
		exec($cmd);

		unlink($dest);
		rename($dest.".tmp", $dest);
	}

	function generateSwfPage(){
		$db	=& JFactory::getDBO();

		$cid = (int)$_REQUEST["cid"];
		$name1 = "../images/flippingbook/cid".$cid.".swf";
		$name2 = "../images/flippingbook/zoom_cid".$cid.".swf";

		$query = "select * from #__flippingbook_pages where id = $cid";
		$db->setQuery( $query );
		$rows = $db->loadObjectList();
		$row = $rows[0];
		
		$this->generate_swf($cid, $row->file, $name1, false); //normal swf
		$this->generate_swf($cid, $row->zoom_url, $name2, true); //zoom swf

		if(file_exists($name1) && file_exists($name2))
			print 0;
		else
			print 1;
		exit();
	}

	function generateAllSwf(){
		$db	=& JFactory::getDBO();

		$query = "select * from images_coords";
		$db->setQuery( $query );
		$rows = $db->loadObjectList();

		$ids = array();
		foreach($rows as $row)
			$ids[] = $row->cid;		
		$s = "[".implode(",", $ids)."]";
		?>
<head>
	<script type='text/javascript' src='/media/system/js/jquery.min.js'></script>
</head>
<body>
	<h3>Generate swf pages</h3>
	<div id='result'>&nbsp;</div>
	<script>
		var ids = <?php print $s ?>;

		var generate_next = function(){
			if (ids.length == 0)
				return;
			var id = ids.shift();
			$.get('/administrator/index.php?option=com_flippingbook&task=generate_swf_page&cid=' + id,
				function(data){
					$('#result').append(id + ' - ' + data + '<br>');
					generate_next();
				});
		};
		
		generate_next();
	</script>
</body>
</html><?
		exit();
	}

	function removeSwfPage(){
		unlink("../images/flippingbook/cid".$_REQUEST["cid"].".swf");
		unlink("../images/flippingbook/zoom_cid".$_REQUEST["cid"].".swf");
		exit();
	}

	//--------------------
	
	function showMain() {
		$db	=& JFactory::getDBO();
		$query = 'SELECT * FROM #__flippingbook_books ORDER BY id DESC LIMIT 5';
		$db->setQuery( $query );
		$rows = $db->loadObjectList();
		
		$params['version'] = $this->getVersion();
		
		require_once( JPATH_COMPONENT . DS . 'views' . DS . 'main.php' );
		Main::showMain( $rows, $params );
	}
	
	function showConfiguration() {
		$db	=& JFactory::getDBO();
		$query = "SELECT name, value FROM #__flippingbook_config";
		$db->setQuery($query);
		$db->query() or die($db->stderr());
		$rows = $db->loadObjectList();
		foreach ( $rows as $row )
			eval ('$FlippingBook_config->' . $row->name . " = '" . $row->value . "';");
		
		$folder = JPATH_SITE . DS . 'components' . DS . 'com_flippingbook' . DS . 'css';
		$files = JFolder::files($folder);
		if (count($files) > 0) {
			foreach ($files as $file)
				$filecss[] = JHTML::_('select.option', $file, $file);
		} else
			$filecss[] = JHTML::_('select.option', '', JText::_( 'None' ));
		$lists['themes_list'] = JHTML::_('select.genericlist',  $filecss, 'theme', 'class="inputbox" size="1"', 'value', 'text', $FlippingBook_config->theme);
		
		$folderMP3 = JPATH_SITE . DS . 'components' . DS . 'com_flippingbook' . DS . 'sounds';
		$filesMP3 = JFolder::files( $folderMP3, '.mp3$' );
		if ( count( $filesMP3 ) > 0 ) {
			foreach ( $filesMP3 as $file )
				$fileMP3[] = JHTML::_( 'select.option', $file, $file );
		}
		$fileMP3[] = JHTML::_( 'select.option', '', JText::_( 'None' ) );
		$lists['pageFlipSound'] = JHTML::_( 'select.genericlist',  $fileMP3, 'flipSound', 'class="inputbox" size="1"', 'value', 'text', $FlippingBook_config->flipSound );
		$lists['hardcoverFlipSound'] = JHTML::_( 'select.genericlist',  $fileMP3, 'hardcoverSound', 'class="inputbox" size="1"', 'value', 'text', $FlippingBook_config->hardcoverSound );
		
		for ($i = 1; $i < 11; $i++) {
			$columns[] = JHTML::_( 'select.option', $i, $i );
			$lists['columns'] = JHTML::_( 'select.genericlist',  $columns, 'columns', 'class="inputbox" size="1"', 'value', 'text', $FlippingBook_config->columns );
		}

		$preloader[] = JHTML::_( 'select.option', 'None', JText::_( 'None' ) );
		$preloader[] = JHTML::_( 'select.option', 'Progress Bar', JText::_( 'Progress Bar' ) );
		$preloader[] = JHTML::_( 'select.option', 'Round', JText::_( 'Round' ) );
		$preloader[] = JHTML::_( 'select.option', 'Thin', JText::_( 'Thin' ) );
		$preloader[] = JHTML::_( 'select.option', 'Gradient Wheel', JText::_( 'Gradient Wheel' ) );
		$preloader[] = JHTML::_( 'select.option', 'Gear Wheel', JText::_( 'Gear Wheel' ) );
		$preloader[] = JHTML::_( 'select.option', 'Line', JText::_( 'Line' ) );
		$preloader[] = JHTML::_( 'select.option', 'Animated Book', JText::_( 'Animated Book' ) );
		$lists['preloader'] = JHTML::_( 'select.genericlist',  $preloader, 'preloaderType', 'class="inputbox" size="1"', 'value', 'text', $FlippingBook_config->preloaderType );
		
		require_once( JPATH_COMPONENT . DS . 'views' . DS . 'configuration.php' );
		Config::Configuration( $FlippingBook_config, $lists );
	}
	
	function saveConfiguration() {
		global $option, $task, $mainframe;
		$db	=& JFactory::getDBO();
		$query = array();
		
		$query[] = "UPDATE #__flippingbook_config SET value = '" . JRequest::getVar ( 'closeSpeed', 0, 'post', 'int' ) . "' WHERE name = 'closeSpeed'";
		$query[] = "UPDATE #__flippingbook_config SET value = '" . JRequest::getVar ( 'columns', 0, 'post', 'int' ) . "' WHERE name = 'columns'";
		$query[] = "UPDATE #__flippingbook_config SET value = '" . JRequest::getVar ( 'dropShadowEnabled', 0, 'post', 'int' ) . "' WHERE name = 'dropShadowEnabled'";
		$query[] = "UPDATE #__flippingbook_config SET value = '" . JRequest::getVar ( 'emailIcon', 0, 'post', 'int' ) . "' WHERE name = 'emailIcon'";
		$query[] = "UPDATE #__flippingbook_config SET value = '" . JRequest::getVar ( 'flipSound', 0, 'post', 'string' ) . "' WHERE name = 'flipSound'";
		$query[] = "UPDATE #__flippingbook_config SET value = '" . JRequest::getVar ( 'gotoSpeed', 0, 'post', 'int' ) . "' WHERE name = 'gotoSpeed'";
		$query[] = "UPDATE #__flippingbook_config SET value = '" . JRequest::getVar ( 'hardcoverSound', 0, 'post', 'string' ) . "' WHERE name = 'hardcoverSound'";
		$query[] = "UPDATE #__flippingbook_config SET value = '" . JRequest::getVar ( 'moveSpeed', 0, 'post', 'int' ) . "' WHERE name = 'moveSpeed'";
		$query[] = "UPDATE #__flippingbook_config SET value = '" . JRequest::getVar ( 'preloaderType', 0, 'post', 'string' ) . "' WHERE name = 'preloaderType'";
		$query[] = "UPDATE #__flippingbook_config SET value = '" . JRequest::getVar ( 'printIcon', 0, 'post', 'int' ) . "' WHERE name = 'printIcon'";
		$query[] = "UPDATE #__flippingbook_config SET value = '" . JRequest::getVar ( 'rigidPageSpeed', 0, 'post', 'int' ) . "' WHERE name = 'rigidPageSpeed'";
		$query[] = "UPDATE #__flippingbook_config SET value = '" . JRequest::getVar ( 'theme', 0, 'post', 'string' ) . "' WHERE name = 'theme'";
		$query[] = "UPDATE #__flippingbook_config SET value = '" . JRequest::getVar ( 'zoomOnClick', 0, 'post', 'string' ) . "' WHERE name = 'zoomOnClick'";
		$query[] = "UPDATE #__flippingbook_config SET value = '" . urlencode ( JRequest::getVar ( 'categoryListTitle', '', 'POST', 'string', JREQUEST_ALLOWRAW ) ) . "' WHERE name = 'categoryListTitle'";
		$query[] = "UPDATE #__flippingbook_config SET value = '" . urlencode ( JRequest::getVar ( 'zoomHint', '', 'post', 'string' ) ) . "' WHERE name = 'zoomHint'";
		$query[] = "UPDATE #__flippingbook_config SET value = '" . urlencode ( JRequest::getVar ( 'printTitle', '', 'post', 'string' ) ) . "' WHERE name = 'printTitle'";
		$query[] = "UPDATE #__flippingbook_config SET value = '" . urlencode ( JRequest::getVar ( 'downloadComplete', '', 'post', 'string' ) ) . "' WHERE name = 'downloadComplete'";

		foreach ( $query as $query_string ) {
			$db->setQuery( $query_string );
			$db->query() or die( $db->stderr() );
		}
		switch ( $this->_task ) {
			case 'apply_configuration':
				$msg = JText::_( 'Configuration saved' );
				$link = 'index.php?option=com_flippingbook&task=configuration';
			break;
			case 'save_configuration':
			default:
				$msg = JText::_( 'Configuration saved' );
				$link = 'index.php?option=com_flippingbook&task=main';
			break;
		}
		$mainframe->redirect( $link, $msg );
	}
	
	function cancelConfiguration() {
		$this->showMain();
	}

	function showCategories () {
		global $mainframe, $option;

		$db					=& JFactory::getDBO();
		$filter_order		= $mainframe->getUserStateFromRequest( "$option.filter_order_catgories",		'filter_order',		'm.ordering',	'cmd' );
		$filter_order_Dir	= $mainframe->getUserStateFromRequest( "$option.filter_order_Dir_catgories",	'filter_order_Dir',	'',		'word' );

		$limit		= $mainframe->getUserStateFromRequest( 'global.list.limit', 'limit', $mainframe->getCfg('list_limit'), 'int' );
		$limitstart	= $mainframe->getUserStateFromRequest( $option.'limitstart_book', 'limitstart', 0, 'int' );

		$orderby 	= ' ORDER BY '. $filter_order .' '. $filter_order_Dir;

		$query = 'SELECT COUNT(m.id)'
		. ' FROM #__flippingbook_categories AS m';
		$db->setQuery( $query );
		$total = $db->loadResult();

		jimport('joomla.html.pagination');
		$pageNav = new JPagination( $total, $limitstart, $limit );

		$query = 'SELECT m.*, COUNT(d.id) AS numoptions'
		. ' FROM #__flippingbook_categories AS m'
		. ' LEFT JOIN #__flippingbook_books AS d ON d.category_id = m.id'
		. ' GROUP BY m.id'
		. $orderby;
		$db->setQuery( $query, $pageNav->limitstart, $pageNav->limit );
		$rows = $db->loadObjectList();

		if ($db->getErrorNum())
		{
			echo $db->stderr();
			return false;
		}

		// table ordering
		$lists['order_Dir']	= $filter_order_Dir;
		$lists['order']		= $filter_order;
		
		require_once( JPATH_COMPONENT.DS.'views'.DS.'category_manager.php' );
		CategoryManager::showCategories( $rows, $pageNav, $option, $lists );
	}
	
	function editCategory() {
		$db		=& JFactory::getDBO();
		$user 	=& JFactory::getUser();
		$cid 	= JRequest::getVar( 'cid', array(0), '', 'array' );
		$option = JRequest::getCmd( 'option');
		$uid 	= (int) @$cid[0];
		$row =& JTable::getInstance( 'flippingcategory', 'Table' );
		$row->load( $uid );
		$javascript = ' ';

		$lists['preview_image'] = $this->getFilesSelectBox ( 'preview_image', $row->preview_image, 1, 'jpg|jpeg|gif|png|JPG|JPEG|GIF|PNG', '' );
		
		for ($i=1; $i<11; $i++) {
			$columns[] = JHTML::_('select.option', $i, $i);
			$lists['columns'] = JHTML::_( 'select.genericlist',  $columns, 'columns', 'class="inputbox" size="1"', 'value', 'text', $row->columns );
		}
		
		require_once( JPATH_COMPONENT . DS . 'views' . DS . 'category_manager.php' );
		CategoryManager::editCategory( $row, $lists );
	}
	
	function saveCategory() {
		global $mainframe;
		$db =& JFactory::getDBO();
		$row =& JTable::getInstance( 'flippingcategory', 'Table' );
		$post = JRequest::get( 'post' );
		$post['title'] = JRequest::getVar( 'title', '', 'POST', 'string', JREQUEST_ALLOWRAW );
		$post['description'] = JRequest::getVar( 'description', '', 'POST', 'string', JREQUEST_ALLOWRAW );
		
		if ( !$row->bind( $post ) )
			JError::raiseError( 500, $row->getError() );
		$isNew = ( $row->id == 0 );
		if ( !$row->check() )
			JError::raiseError( 500, $row->getError() );
		if ( !$row->store() )
			JError::raiseError( 500, $row->getError() );

		switch ($this->_task) {
			case 'apply_category':
				$msg = JText::_( 'Category saved' );
				$link = 'index.php?option=com_flippingbook&task=edit_category&cid[]='. $row->id .'';
				break;
			case 'save_category':
			default:
				$msg = JText::_( 'Category saved' );
				$link = 'index.php?option=com_flippingbook&task=category_manager';
				break;
		}
		$this->reorderCategories();
		$mainframe->redirect( $link, $msg );
	}

	function cancelCategory() {
		global $option;
		$this->setRedirect( 'index.php?option='. $option .'&task=category_manager' );
	}
	
	function reorderCategories() {
		global $mainframe;
		$db =& JFactory::getDBO();
		$this->setRedirect( 'index.php?option=com_flippingbook&task=category_manager' );

		$cid = JRequest::getVar( 'cid', array(), 'post', 'array' );
		JArrayHelper::toInteger($cid);

		$task = $this->getTask();
		$inc = ($task == 'orderup_category' ? -1 : 1);

		if (empty( $cid )) {
			return JError::raiseWarning( 500, 'No items selected' );
		}

		$row =& JTable::getInstance('flippingcategory', 'Table');
		$row->load( (int) $cid[0] );
		$row->move( $inc );
		$row->reorder();
	}

	function removeCategory() {
		global $mainframe;
		$db		=& JFactory::getDBO();
		$cid	= JRequest::getVar( 'cid', array(), '', 'array' );
		JArrayHelper::toInteger($cid);
		
		for ($i=0, $n=count($cid); $i < $n; $i++) {
		
			$query = 'SELECT * FROM #__flippingbook_books WHERE category_id = '.(int) $cid[$i];
			$db->setQuery( $query );
			$books_in_category = $db->loadObjectList();
			if (count($books_in_category) > 0) {
				$msg = JText::_( 'Category can\'t be deleted. It contains book(s).' ) . "<br>";
			} else {
				$category =& JTable::getInstance('flippingcategory', 'Table');
				if (!$category->delete( $cid[$i] )) {
					$msg .= $category->getError();
				} else {
					$query = 'DELETE FROM #__flippingbook_categories WHERE id = '.(int) $cid[$i];
					$db->setQuery( $query );
					if (!$db->query()) {
						return JError::raiseWarning( 500, $row->getError() );
					}
					$msg .= JText::_( 'Category(ies) was deleted' );
				}
			}
		}
		$mainframe->redirect('index.php?option=com_flippingbook&task=category_manager', $msg);
	}
	
	function showBooks() {
		global $mainframe, $option;
		$db					=& JFactory::getDBO();
		$filter_order		= $mainframe->getUserStateFromRequest( "$option.filter_order_books",		'filter_order',		'b.title',	'cmd' );
		$filter_order_Dir	= $mainframe->getUserStateFromRequest( "$option.filter_order_Dir_books",	'filter_order_Dir',	'',			'word' );
		$filter_state		= $mainframe->getUserStateFromRequest( "$option.filter_state_books",		'filter_state',		'',			'word' );
		$filter_category	= $mainframe->getUserStateFromRequest( "$option.filter_category_books",	'filter_category',	'-1',		'string' );
		$search				= $mainframe->getUserStateFromRequest( "$option.search_books",			'search',			'',			'string' );
		$search				= JString::strtolower( $search );

		$limit		= $mainframe->getUserStateFromRequest( 'global.list.limit', 'limit', $mainframe->getCfg('list_limit'), 'int' );
		$limitstart	= $mainframe->getUserStateFromRequest( $option.'limitstart_page', 'limitstart', 0, 'int' );

		$where = array();

		if ( $filter_state ) {
			if ( $filter_state == 'P' )
			{
				$where[] = 'm.published = 1';
			}
			else if ($filter_state == 'U' )
			{
				$where[] = 'm.published = 0';
			}
		}
		
		if ( $filter_category > -1) {
			$where[] = '(m.category_id = ' . $filter_category . ')';
		}
		
		if ($search) {
			$where[] = '(LOWER(m.title) LIKE '.$db->Quote('%'.$search.'%').' OR LOWER(m.description) LIKE '.$db->Quote('%'.$search.'%').')';
		}

		$where 		= ( count( $where ) ? ' WHERE ' . implode( ' AND ', $where ) : '' );
		$orderby 	= ' ORDER BY '. $filter_order .' '. $filter_order_Dir . ', m.ordering';

		$query = 'SELECT COUNT(m.id)'
		. ' FROM #__flippingbook_books AS m'
		. $where;
		
		$db->setQuery( $query );
		$total = $db->loadResult();

		jimport('joomla.html.pagination');
		$pageNav = new JPagination( $total, $limitstart, $limit );
		
		$query = 'SELECT m.*, m.title AS book_title, b.title AS category_title'
		. ' FROM #__flippingbook_books AS m'
		. ' LEFT JOIN #__flippingbook_categories AS b ON m.category_id=b.id'
		. $where
		. $orderby;
		
		$db->setQuery( $query, $pageNav->limitstart, $pageNav->limit );
		$rows = $db->loadObjectList();

		if ($db->getErrorNum()) {
			echo $db->stderr();
			return false;
		}

		$lists['state']	= JHTML::_('grid.state',  $filter_state );

		$lists['order_Dir']	= $filter_order_Dir;
		$lists['order']		= $filter_order;
		
		$query = 'SELECT id, title FROM #__flippingbook_categories ORDER BY title';
		$db->setQuery( $query );
		$rows2 = $db->loadObjectList();
		$book_filter[] = JHTML::_('select.option', -1, '- '. JText::_( 'Select Category' ) .' -' );
		foreach ( $rows2 as $row ) {
			$book_filter[] = JHTML::_('select.option', $row->id, $row->title );
		}
		$lists['category'] = JHTML::_('select.genericlist',   $book_filter, 'filter_category', 'class="inputbox" size="1" onchange="submitform( );"', 'value', 'text', $filter_category );

		$lists['search']= $search;
		
		require_once( JPATH_COMPONENT . DS . 'views' . DS . 'book_manager.php' );
		BookManager::showBooks( $rows, $pageNav, $option, $lists ); 
	}
	
	function editBook() {
		global $mainframe, $option;
		$db =& JFactory::getDBO();
		$user =& JFactory::getUser();

		$cid = JRequest::getVar( 'cid', array(0), '', 'array' );
		$option = JRequest::getCmd( 'option');
		$uid = ( int ) @$cid[0];

		$javascript = ' ';

		$row =& JTable::getInstance( 'flippingbook', 'Table' );
		$row->load( $uid );

		if (JRequest::getCmd('task') == 'add_book') {
			//Default values for a new book
			$row->id = "";
			$row->alias = "";
			$row->allow_pages_unload = 0;
			$row->always_opened = 0;
			$row->auto_flip_size = 50;
			$row->background_color = "FFFFFF";
			$row->background_image_placement = "center";
			$row->background_image = "";
			$row->book_height = 400;
			$row->book_width = 300;
			$row->category_id = "";
			$row->center_book = 1;
			$row->checked_out_time = "0000-00-00 00:00:00";
			$row->checked_out = "0";
			$row->created = gmdate('Y-m-d H:i:s');
			$row->description = "";
			$row->download_size = "0 Kb";
			$row->download_title = "Download Book";
			$row->download_url = "";
			$row->dynamic_shadows_depth = 1;
			$row->emailIcon = 1;
			$row->first_last_buttons = 1;
			$row->first_page = 1;
			$row->flash_height = 500;
			$row->flash_width = "100%";
			$row->flip_corner_style = "manually";
			$row->fullscreen_enabled = 1;
			$row->go_to_page_field = 1;
			$row->hardcover = 1;
			$row->hits = 0;
			$row->modified = gmdate('Y-m-d H:i:s');
			$row->navigation_bar_placement = "bottom";
			$row->navigation_bar = "navigation.swf";
			$row->new_window_height = 600;
			$row->new_window_width = 500;
			$row->open_book_in = 1;
			$row->ordering = 0;
			$row->page_background_color = "EEEEEE";
			$row->preview_image = "";
			$row->print_enabled = 1;
			$row->printIcon = 1;
			$row->published = 1;
			$row->scale_content = 1;
			$row->show_book_description = 1;
			$row->show_book_title = 1;
			$row->show_pages_description = 1;
			$row->slideshow_auto_play = 0;
			$row->slideshow_button = 1;
			$row->slideshow_display_duration = 5000;
			$row->static_shadows_depth = 1;
			$row->static_shadows_type = "Asymmetric";
			$row->title = "New Book";
			$row->zoom_enabled = 1;
			$row->zoom_image_height = 800;
			$row->zoom_image_width = 600;
			$row->zoom_ui_color = "8f9ea6";
			$row->zooming_method = 0;
		}
		
		$query = 'SELECT id FROM #__flippingbook_categories';
		$db->setQuery( $query );
		if ( count($db->loadObjectList() ) < 1 ) {
			$msg = JText::_( 'CREATE A CATEGORY FIRST' );
			$link = 'index.php?option=com_flippingbook&task=category_manager';
			$mainframe->redirect( $link, $msg );
			return;
		}
		
		$lists['background_image'] = $this->getFilesSelectBox ( 'background_image', $row->background_image, 1, 'jpg|jpeg|gif|png|swf|JPG|JPEG|GIF|PNG|SWF|', '' );
		$lists['preview_image'] = $this->getFilesSelectBox ( 'preview_image', $row->preview_image, 1, 'jpg|jpeg|gif|png|JPG|JPEG|GIF|PNG', '' );
		
		$query = 'SELECT id, title FROM #__flippingbook_categories ORDER BY title';
		$db->setQuery( $query );
		$book_rows = $db->loadObjectList();
		$book_filter[] = JHTML::_('select.option', -1, '- '. JText::_( 'Select Category' ) .' -' );
		foreach ( $book_rows as $book_row )
			$book_option[] = JHTML::_( 'select.option', $book_row->id, $book_row->title );
		$lists['categories'] = JHTML::_( 'select.genericlist', $book_option, 'category_id', 'class="inputbox" size="1"', 'value', 'text', $row->category_id );
		
		$backgroundImagePlacement[] = JHTML::_( 'select.option', 'center', JText::_( 'Center' ) );
		$backgroundImagePlacement[] = JHTML::_( 'select.option', 'fit', JText::_( 'Fit' ) );
		$backgroundImagePlacement[] = JHTML::_( 'select.option', 'top left', JText::_( 'Top Left' ) );
		$lists['backgroundImagePlacement'] = JHTML::_( 'select.genericlist', $backgroundImagePlacement, 'background_image_placement', 'class="inputbox" size="1"', 'value', 'text', $row->background_image_placement );
		
		$flipCornerStyle[] = JHTML::_( 'select.option', 'first page only', JText::_( 'First Page Only' ) );
		$flipCornerStyle[] = JHTML::_( 'select.option', 'manually', JText::_( 'Manually' ) );
		$lists['flipCornerStyle'] = JHTML::_( 'select.genericlist', $flipCornerStyle, 'flip_corner_style', 'class="inputbox" size="1"', 'value', 'text', $row->flip_corner_style );
		
		$staticShadowsType[] = JHTML::_( 'select.option', 'Asymmetric', JText::_( 'Asymmetric' ) );
		$staticShadowsType[] = JHTML::_( 'select.option', 'Symmetric', JText::_( 'Symmetric' ) );
		$lists['staticShadowsType'] = JHTML::_( 'select.genericlist', $staticShadowsType, 'static_shadows_type', 'class="inputbox" size="1"', 'value', 'text', $row->static_shadows_type );
		
		$navigationBarFolder = JPATH_SITE . DS . 'components' . DS . 'com_flippingbook' . DS . 'navigationbars';
		$navigationBarFiles = JFolder::files( $navigationBarFolder, '.swf$' );
		if ( count( $navigationBarFiles ) > 0 ) {
			foreach ( $navigationBarFiles as $file )
				$navigationBarFile[] = JHTML::_( 'select.option', $file, $file );
		}
		$navigationBarFile[] = JHTML::_( 'select.option', "", JText::_( 'None' ) );
		$lists['navigationBarFiles'] = JHTML::_( 'select.genericlist',  $navigationBarFile, 'navigation_bar', 'class="inputbox" size="1"', 'value', 'text', $row->navigation_bar );

		$navigationBarPlacement[] = JHTML::_( 'select.option', 'bottom', JText::_( 'Bottom' ) );
		$navigationBarPlacement[] = JHTML::_( 'select.option', 'top', JText::_( 'Top' ) );
		$lists['navigationBarPlacement'] = JHTML::_( 'select.genericlist', $navigationBarPlacement, 'navigation_bar_placement', 'class="inputbox" size="1"', 'value', 'text', $row->navigation_bar_placement );
		
		$zoomingMethod[] = JHTML::_( 'select.option', '0', JText::_( 'Zoom in Flash' ) );
		$zoomingMethod[] = JHTML::_( 'select.option', '1', JText::_( 'AJAX window' ) );
		$lists['zoomingMethod'] = JHTML::_( 'select.genericlist', $zoomingMethod, 'zooming_method', 'class="inputbox" size="1" onchange="check_method();"', 'value', 'text', $row->zooming_method);
		
		require_once( JPATH_COMPONENT . DS . 'views' . DS . 'book_manager.php' );
		BookManager::editBook( $row, $lists );
	}

	function saveBook() {
		global $mainframe;
		$db =& JFactory::getDBO();
		$row =& JTable::getInstance('flippingbook', 'Table');
		$post = JRequest::get( 'post' );
		$post['title'] = JRequest::getVar('title', '', 'POST', 'string', JREQUEST_ALLOWRAW);
		$post['description'] = JRequest::getVar('description', '', 'POST', 'string', JREQUEST_ALLOWRAW);
		if (!$row->bind( $post )) {
			JError::raiseError(500, $row->getError() );
		}
		$isNew = ($row->id == 0);
		if (!$row->check()) {
			JError::raiseError(500, $row->getError() );
		}
		if (!$row->store()) {
			JError::raiseError(500, $row->getError() );
		}
		//$row->checkin();
		$row->reorder('category_id = '.(int) $row->category_id);
		
		$db->setQuery("UPDATE #__flippingbook_books SET modified='" . gmdate('Y-m-d H:i:s') . "' WHERE id=" . $row->id );
		$db->query();                                             

		switch ($this->_task) {
			case 'apply_book':
				$msg = JText::_( 'Book saved' );
				$link = 'index.php?option=com_flippingbook&task=edit_book&cid[]='. $row->id .'';
				break;

			case 'save_book':
			default:
				$msg = JText::_( 'Book saved' );
				$link = 'index.php?option=com_flippingbook&task=book_manager';
				break;
		}
		$mainframe->redirect($link, $msg);
	}
	
	function cloneBook() {
		$db =& JFactory::getDBO();
		$user =& JFactory::getUser();

		$cid = JRequest::getVar( 'cid', array(0), '', 'array' );
		$option = JRequest::getCmd( 'option');
		$uid = ( int ) @$cid[0];

		$total = count($cid);
			for ($i = 0; $i < $total; $i ++) {
			$row =& JTable::getInstance( 'flippingbook', 'Table' );
			$row->load( $cid[$i] );
			
			$row->id = 0; 
			$row->title .= "_copy";
			$row->published = 0;
			$row->created = gmdate('Y-m-d H:i:s');
			$row->modified = gmdate('Y-m-d H:i:s');
			
			if (!$row->check()) {
				JError::raiseError(500, $row->getError() );
			}
			if (!$row->store()) {
				JError::raiseError(500, $row->getError() );
			}
			
			$row->reorder("category_id = $row->category_id");
		}
		
		$msg = JText::_( 'Book(s) successfully cloned' );
		$this->setRedirect( 'index.php?option='. $option .'&task=book_manager', $msg);
	}
	
	function cancelBook() {
		global $option;
		$this->setRedirect( 'index.php?option='. $option .'&task=book_manager' );
	}

	function reorderBooks() {
		global $mainframe;
		$db =& JFactory::getDBO();
		$this->setRedirect( 'index.php?option=com_flippingbook&task=book_manager' );

		$cid = JRequest::getVar( 'cid', array(), 'post', 'array' );
		JArrayHelper::toInteger($cid);

		$task = $this->getTask();
		$inc = ($task == 'orderup_book' ? -1 : 1);

		if (empty( $cid )) {
			return JError::raiseWarning( 500, 'No items selected' );
		}

		$row =& JTable::getInstance('flippingbook', 'Table');
		$row->load( (int) $cid[0] );
		$row->move( $inc, "category_id = $row->category_id"  );
		$row->reorder("category_id = $row->category_id");
	}
	
	function removeBook() {
		global $mainframe;
		$db		=& JFactory::getDBO();
		$cid	= JRequest::getVar( 'cid', array(), '', 'array' );
		JArrayHelper::toInteger($cid);
		for ($i=0, $n=count($cid); $i < $n; $i++) {
			$book =& JTable::getInstance('flippingbook', 'Table');
			if (!$book->delete( $cid[$i] )) {
				$msg .= $book->getError();
			} else {
				$query = 'DELETE FROM #__flippingbook_pages WHERE book_id = '.(int) $cid[$i];
				$db->setQuery( $query );
				if (!$db->query()) {
					return JError::raiseWarning( 500, $row->getError() );
				}
			}
		}
		$msg .= JText::_( 'Book(s) was deleted' );
		$mainframe->redirect('index.php?option=com_flippingbook&task=book_manager', $msg);
	}

	function showPages() {
		global $mainframe, $option;
		$db					=& JFactory::getDBO();
		$filter_order		= $mainframe->getUserStateFromRequest( "$option.filter_order_pages",		'filter_order',		'b.title',	'cmd' );
		$filter_order_Dir	= $mainframe->getUserStateFromRequest( "$option.filter_order_Dir_pages",	'filter_order_Dir',	'',		'word' );
		$filter_state		= $mainframe->getUserStateFromRequest( "$option.filter_state_pages",		'filter_state',		'',		'word' );
		$filter_book		= $mainframe->getUserStateFromRequest( "$option.filter_book_pages",		'filter_book',		'-1',		'string' );
		$search				= $mainframe->getUserStateFromRequest( "$option.search_pages",			'search',			'',		'string' );
		$search				= JString::strtolower( $search );
		
		$limit		= $mainframe->getUserStateFromRequest( 'global.list.limit', 'limit', $mainframe->getCfg('list_limit'), 'int' );
		$limitstart	= $mainframe->getUserStateFromRequest( $option.'limitstart_page', 'limitstart', 0, 'int' );

		$where = array();

		if ( $filter_state ) {
			if ( $filter_state == 'P' )
			{
				$where[] = 'm.published = 1';
			}
			else if ($filter_state == 'U' )
			{
				$where[] = 'm.published = 0';
			}
		}
		
		if ( $filter_book > -1) {
			$where[] = '(m.book_id = ' . $filter_book . ')';
		}
		
		if ($search) {
			$where[] = '(LOWER(m.file) LIKE '.$db->Quote('%'.$search.'%').' OR LOWER(m.link_url) LIKE '.$db->Quote('%'.$search.'%').' OR LOWER(m.zoom_url) LIKE '.$db->Quote('%'.$search.'%').')';
		}

		$where 		= ( count( $where ) ? ' WHERE ' . implode( ' AND ', $where ) : '' );
		$orderby 	= ' ORDER BY '. $filter_order .' '. $filter_order_Dir . ', m.ordering';

		$query = 'SELECT COUNT(m.id)'
		. ' FROM #__flippingbook_pages AS m'
		. $where
		;
		$db->setQuery( $query );
		$total = $db->loadResult();

		jimport('joomla.html.pagination');
		$pageNav = new JPagination( $total, $limitstart, $limit );
		
		$query = 'SELECT m.*, b.title'
		. ' FROM #__flippingbook_pages AS m LEFT JOIN #__flippingbook_books AS b ON (m.book_id=b.id)'
		. $where
		. $orderby
		;
		$db->setQuery( $query, $pageNav->limitstart, $pageNav->limit );
		$rows = $db->loadObjectList();

		if ($db->getErrorNum()) {
			echo $db->stderr();
			return false;
		}

		$lists['state']	= JHTML::_('grid.state',  $filter_state );

		$lists['order_Dir']	= $filter_order_Dir;
		$lists['order']		= $filter_order;
		
		$query = 'SELECT id, title FROM #__flippingbook_books ORDER BY title';
		$db->setQuery( $query );
		$rows2 = $db->loadObjectList();
		$book_filter[] = JHTML::_('select.option', -1, '- '. JText::_( 'Select Book' ) .' -' );
		foreach ( $rows2 as $row ) {
			$book_filter[] = JHTML::_('select.option', $row->id, $row->title );
		}
		$lists['book']		 = JHTML::_('select.genericlist',   $book_filter, 'filter_book', 'class="inputbox" size="1" onchange="submitform( );"', 'value', 'text', $filter_book );

		$lists['search'] = $search;

		require_once( JPATH_COMPONENT.DS.'views'.DS.'page_manager.php' );
		PageManager::showPages( $rows, $pageNav, $option, $lists );
	}

	function editPage()	{
		global $mainframe, $option;
		$db		=& JFactory::getDBO();
		$user 	=& JFactory::getUser();

		$cid 	= JRequest::getVar( 'cid', array(0), '', 'array' );
		$option = JRequest::getCmd( 'option');
		$uid 	= (int) @$cid[0];

		$row =& JTable::getInstance('flippingpage', 'Table');
		$row->load( $uid );
		
		$query = 'SELECT id FROM #__flippingbook_books';
		$db->setQuery( $query );
		if (count($db->loadObjectList()) < 1) {
			$msg = JText::_( 'CREATE A BOOK FIRST' );
			$link = 'index.php?option=com_flippingbook&task=book_manager';
			$mainframe->redirect($link, $msg);
			return;
		}

		$query = 'SELECT id, title FROM #__flippingbook_books ORDER BY title';
		$db->setQuery( $query );
		$book_rows = $db->loadObjectList();
		$book_filter[] = JHTML::_('select.option', -1, '- '. JText::_( 'Select Book' ) .' -' );
		foreach ( $book_rows as $book_row )
			$book_option[] = JHTML::_('select.option', $book_row->id, $book_row->title );

		$lists['books'] = JHTML::_('select.genericlist', $book_option, 'book_id', 'class="inputbox" size="1"', 'value', 'text', $row->book_id );

		$lists['files'] = $this->getFilesSelectBox ('file', $row->file, 0, 'jpg|jpeg|swf|JPG|JPEG|SWF', '');

		$lists['zoomed_image'] = $this->getFilesSelectBox ('zoom_url', $row->zoom_url, 1, 'jpg|jpeg|swf|JPG|JPEG|SWF', 'onchange="update_fields_state();"');

		require_once( JPATH_COMPONENT.DS.'views'.DS.'page_manager.php' );
		PageManager::editPage( $row, $lists );
	}
	
	function savePage() {
		global $mainframe;
		$db =& JFactory::getDBO();
		$row =& JTable::getInstance('flippingpage', 'Table');
		$post = JRequest::get( 'post' );
		$post['description'] = JRequest::getVar('description', '', 'POST', 'string', JREQUEST_ALLOWRAW);
		if (!$row->bind( $post )) {
			JError::raiseError(500, $row->getError() );
		}
		$isNew = ($row->id == 0);
		if (!$row->check()) {
			JError::raiseError(500, $row->getError() );
		}
		if (!$row->store()) {
			JError::raiseError(500, $row->getError() );
		}
		//$row->checkin();
		$row->reorder("book_id = $row->book_id");
		
		switch ($this->_task) {
			case 'apply_page':
				$msg = JText::_( 'Page saved' );
				$link = 'index.php?option=com_flippingbook&task=edit_page&cid[]='. $row->id .'';
			break;
			case 'save_page':
			default:
				$msg = JText::_( 'Page saved' );
				$link = 'index.php?option=com_flippingbook&task=page_manager';
			break;
		}
		$mainframe->redirect($link, $msg);
	}
	
	function clonePage() {
		$db =& JFactory::getDBO();
		$user =& JFactory::getUser();

		$cid = JRequest::getVar( 'cid', array(0), '', 'array' );
		$option = JRequest::getCmd( 'option');
		$uid = ( int ) @$cid[0];

		$total = count($cid);
			for ($i = 0; $i < $total; $i ++) {
			$row =& JTable::getInstance( 'flippingpage', 'Table' );
			$row->load( $cid[$i] );
			
			$row->id = 0; 
			$row->published = 0;
			
			if (!$row->check()) {
				JError::raiseError(500, $row->getError() );
			}
			if (!$row->store()) {
				JError::raiseError(500, $row->getError() );
			}
			
			$row->reorder("book_id = $row->book_id");
		}
		
		$msg = JText::_( 'Page(s) successfully cloned' );
		$this->setRedirect( 'index.php?option='. $option .'&task=page_manager', $msg);
	}
	
	function cancelPage() {
		global $option;
		$this->setRedirect( 'index.php?option='. $option .'&task=page_manager' );
	}
	
	function reorderPages() {
		global $mainframe;
		$db =& JFactory::getDBO();
		$this->setRedirect( 'index.php?option=com_flippingbook&task=page_manager' );

		$cid = JRequest::getVar( 'cid', array(), 'post', 'array' );
		JArrayHelper::toInteger($cid);

		$task = $this->getTask();
		$inc = ($task == 'orderup_page' ? -1 : 1);

		if (empty( $cid )) {
			return JError::raiseWarning( 500, 'No items selected' );
		}

		$row =& JTable::getInstance('flippingpage', 'Table');
		$row->load( (int) $cid[0] );
		$row->move( $inc, "book_id = $row->book_id" );
		$row->reorder("book_id = $row->book_id");
	}

	function removePage() {
		$db		=& JFactory::getDBO();
		$cid	= JRequest::getVar( 'cid', array(), '', 'array' );
		JArrayHelper::toInteger($cid);
		$msg = '';
		for ($i=0, $n=count($cid); $i < $n; $i++) {
				$book =& JTable::getInstance('flippingpage', 'Table');
				if (!$book->delete( $cid[$i] )) {
					$msg .= $book->getError();
				}
			}
		$this->setRedirect( 'index.php?option=com_flippingbook&task=page_manager', $msg );
	}

	function publish() {
		global $mainframe;

		$db 	=& JFactory::getDBO();
		$user 	=& JFactory::getUser();

		$cid		= JRequest::getVar( 'cid', array(), '', 'array' );
		$publish	= ( $this->_task == 'publish' ? 1 : 0 );
		$option		= JRequest::getCmd( 'option', 'com_flippingbook', '', 'string' );

		JArrayHelper::toInteger($cid);

		if (count( $cid ) < 1) {
			$action = $publish ? 'publish' : 'unpublish';
			JError::raiseError(500, JText::_( 'Select an item to '.$action, true ) );
		}
		$cids = implode( ',', $cid );
		switch (JRequest::getVar( 'section', '', 'post', 'string' )) {
			case 'category_manager':
				$query = 'UPDATE #__flippingbook_categories'
				. ' SET published = ' . (int) $publish
				. ' WHERE id IN ( '. $cids .' )'
				;
				$db->setQuery( $query );
				if (!$db->query()) {
					JError::raiseError(500, $db->getErrorMsg() );
				}

				if (count( $cid ) == 1) {
					$row =& JTable::getInstance('flippingcategory', 'Table');
					$row->checkin( $cid[0] );
				}
				$link = 'index.php?option=com_flippingbook&task=category_manager';
				$this->setRedirect($link);
			break;
			
			case 'book_manager':
				$query = 'UPDATE #__flippingbook_books'
				. ' SET published = ' . (int) $publish
				. ' WHERE id IN ( '. $cids .' )'
				;
				$db->setQuery( $query );
				if (!$db->query()) {
					JError::raiseError(500, $db->getErrorMsg() );
				}

				if (count( $cid ) == 1) {
					$row =& JTable::getInstance('flippingbook', 'Table');
					$row->checkin( $cid[0] );
				}
				$link = 'index.php?option=com_flippingbook&task=book_manager';
				$this->setRedirect($link);
			break;
			
			case 'page_manager':
			default:
				$query = 'UPDATE #__flippingbook_pages'
				. ' SET published = ' . (int) $publish
				. ' WHERE id IN ( '. $cids .' )'
				;
				$db->setQuery( $query );
				if (!$db->query()) {
					JError::raiseError(500, $db->getErrorMsg() );
				}

				if (count( $cid ) == 1) {
					$row =& JTable::getInstance('flippingpage', 'Table');
					$row->checkin( $cid[0] );
				}
				$link = 'index.php?option=com_flippingbook&task=page_manager';
				$this->setRedirect($link);
			break;
		}
	}

	function batchAddPages () {
		global $mainframe, $option;
		$db =& JFactory::getDBO();
		
		$query = 'SELECT id FROM #__flippingbook_books';
		$db->setQuery( $query );
		if (count($db->loadObjectList()) < 1) {
			$msg = JText::_( 'CREATE A BOOK FIRST' );
			$link = 'index.php?option=com_flippingbook&task=book_manager';
			$mainframe->redirect($link, $msg);
			return;
		}
		
		$query = 'SELECT id, title FROM #__flippingbook_books ORDER BY title';
		$db->setQuery( $query );
		$book_rows = $db->loadObjectList();
		
		//Book list
		if (count($book_rows) > 0) {
			foreach ( $book_rows as $book_row ) {
				$book_option[] = JHTML::_('select.option', $book_row->id, $book_row->title );
			}
		} else {
			echo JText::_('Create a book before adding pages');
			return;
		}
		$lists['books'] = JHTML::_('select.genericlist', $book_option, 'book_id', 'class="inputbox" size="1"', 'value', 'text');

		//Folders list
		$folders = JFolder::listFolderTree (JPATH_ROOT.DS.'images'.DS.'flippingbook', '', 10);
		$folder_name[] = JHTML::_('select.option', DS.'images'.DS.'flippingbook'.DS, DS.'images'.DS.'flippingbook'.DS );
		if (count($folders) > 0) {
			foreach ($folders as $folder) {
				$folder_name[] = JHTML::_('select.option', $folder["relname"].DS, $folder["relname"].DS );
			}
		}
		$lists['folders'] = JHTML::_('select.genericlist', $folder_name, 'folder', 'class="inputbox" size="1"', 'value', 'text');

		//Adding method
		$method[] = JHTML::_('select.option', 'simple', JText::_( 'Simple' ) );
		$method[] = JHTML::_('select.option', 'advanced', JText::_( 'Advanced' ) );
		$lists['method'] = JHTML::_('select.genericlist', $method, 'method', 'class="inputbox" size="1" onchange="check_method();"', 'value', 'text');
		
		require_once(JPATH_COMPONENT.DS.'views'.DS.'batch_add_pages.php');
		BatchAddPages::form($lists);
	}
	
	function batchAddPagesExecute () {	
		//NOTE for generate scaled images
		set_include_path(
			get_include_path().PATH_SEPARATOR.
			JPATH_COMPONENT."/pearlib");
		require_once 'Image/Transform.php';
		
		//set_time_limit(0);
		ini_set("max_execution_time", 0);

		if(!function_exists("tmp_com_flippingbok_sortfiles")){
			function tmp_com_flippingbok_sortfiles($a, $b){
				preg_match("{([0-9]+)[.jpg|$.swf$]}i", $a, $ma);
				preg_match("{([0-9]+)[.jpg|$.swf$]}i", $b, $mb);
				return (int)$ma[1] > (int)$mb[1]? 1 :
					((int)$ma[1] < (int)$mb[1]? -1 : 0);
			}
		}

		$scale_width = JRequest::getVar('scale_width', '', 'POST', 'int');
		$scale_height = JRequest::getVar('scale_height', '', 'POST', 'int');

		global $mainframe;
		$vars = array();
		$vars['book_id'] = JRequest::getVar('book_id', '', 'POST', 'int');
		$vars['folder'] = JRequest::getVar('folder', '', 'POST', 'string');
		$vars['method'] = JRequest::getVar('method', '', 'POST', 'string');
		$vars['prefix_page'] = JRequest::getVar('prefix_page', '', 'POST', 'string');
		$vars['prefix_zoom'] = JRequest::getVar('prefix_zoom', '', 'POST', 'string');

		// Get the files from the selected folder
		$path = JPATH_SITE . $vars['folder'];
		$filter='.jpg$|.swf$';
		$recurse=false;
		$fullpath=false;
		jimport('joomla.filesystem.folder');
		jimport( 'joomla.filesystem.file' );
		$files = JFolder::files($path, $filter, $recurse, $fullpath);

		// sort for numerical order
		usort($files, "tmp_com_flippingbok_sortfiles");
		
		if (count($files) == 0)  {
			$msg = JText::_( 'There are no files in selected folder' ) . ": " . $vars['folder'];
			$mainframe->redirect('index.php?option=com_flippingbook&task=batch_add_pages', $msg);
			return;
		}

		//Get the last page number in the selected book
		$db =& JFactory::getDBO();
		$query = 'SELECT MAX(ordering)' . ' FROM #__flippingbook_pages WHERE book_id=' . $vars['book_id'];
		$db->setQuery( $query );
		$last_page_number = $db->loadResult();

		//Adding all jpg and swf files into the book
		if ($vars['method'] == 'simple') {
			$i = $last_page_number + 1;
			foreach ($files as $file) {
				$path_for_db = $vars['folder'] . $file;
				$path_for_db = strtr($path_for_db, "\\", "/");
				$path_for_db = preg_replace ('/^\/images\/flippingbook\//', '', $path_for_db);
				$query = "INSERT INTO #__flippingbook_pages (file, book_id, ordering, published) VALUES('" . $path_for_db . "', " . $vars['book_id'] . ", " . $i . ", 1);";
				$db->setQuery( $query );
				if (!$db->query()) {
					return JError::raiseWarning( 500, $row->getError() );
				}
				$i++;
			}
		}

		//Advanced adding files into the book
		if ($vars['method'] == 'advanced') {
			$html = '<fieldset class="adminform"><legend>Report</legend><table class="adminlist" width="100%"><th>#</th><th>' . JText::_( 'File' ) . '</th>' . '<th>' . JText::_( 'Zoomed Image' ) . '</th>';
			$i = $last_page_number + 1;
			foreach ($files as $file) {
				//NOTE for generate scaled image
				//if (preg_match ("/^" . $vars['prefix_page'] . "[0-9]+[.jpg|$.swf$]/i", $file)) {
				if (preg_match ("/^" . $vars['prefix_page'] .
						$vars['prefix_zoom']. "[0-9]+[.jpg|$.swf$]/i", $file)) {

					$html .= '<tr><td>' . $i . '</td><td>' . $vars['folder'] . $file . '</td><td>';
					
					//preg_match ("/^" . $vars['prefix_page'] . "([0-9]+).(jpg$|swf$)/i", $file, $matches);
					preg_match ("/^" . $vars['prefix_page'] .
						$vars['prefix_zoom'] . "([0-9]+).(jpg$|swf$)/i", $file, $matches);

					$name_after_prefix = $matches[1];
					$file_extension = $matches[2];

					//$path_for_db = $vars['folder'] . $file;
					$path_for_db = $vars['folder'] . str_replace($vars['prefix_zoom'], "", $file);
					
					$path_for_db = strtr($path_for_db, "\\", "/");
					$path_for_db = preg_replace ('/^\/images\/flippingbook\//', '', $path_for_db);
					$zoom_file_name = $vars['folder'] . $vars['prefix_page'] . $vars['prefix_zoom'] . $name_after_prefix . 	"." . $file_extension;
					$zoom_path_for_db = '';

					if (JFile::exists(JPATH_ROOT . $zoom_file_name)) {
						$html .= $zoom_file_name;
						$zoom_path_for_db = $zoom_file_name;
						$zoom_path_for_db = strtr($zoom_path_for_db, "\\", "/");
						$zoom_path_for_db = preg_replace ('/^\/images\/flippingbook\//', '', $zoom_path_for_db);
					}

					if(!file_exists(JPATH_SITE."/images/flippingbook/".$path_for_db))
						$this->generate_scaled_image(
							JPATH_SITE."/images/flippingbook/".$zoom_path_for_db,
							JPATH_SITE."/images/flippingbook/".$path_for_db,
							$scale_width, $scale_height);

					$query = "INSERT INTO #__flippingbook_pages (file, book_id, ordering, published, zoom_url) VALUES('" . $path_for_db . "', " . $vars['book_id'] . ", " . $i . ", 1, '" . $zoom_path_for_db . "');";
					$db->setQuery( $query );
					if (!$db->query()) {
						return JError::raiseWarning( 500, $row->getError() );
					}
					$html .= '</td>';
					$i++;
				}
			}
			$html .= '</tr></table></fieldset>';
			echo $html;
		}
		$i = $i - $last_page_number - 1;
		$msg = $i . " " . JText::_('pages was created');
		$mainframe->redirect('index.php?option=com_flippingbook&task=batch_add_pages', $msg);
	}

	//NOTE generate scaled pages
	function generate_scaled_image($src, $dest, $width = 300, $height = 500) {
		$a = Image_Transform::factory('GD');
		$a->load($src);
		$a->fit($width, $height);
		$a->save($dest);
	}
	
	function manageFiles () {
		require_once( JPATH_COMPONENT.DS.'views'.DS.'file_manager.php' );
		FileManager::fileManagerInterface( '' );
	}
	
	function saveUploadedFiles () {
		global $clearUploads;
		global $mainframe;
		$msg = '<table style="padding-left:35px;">';
		$userfile = JRequest::getVar( 'upload', null, 'files', 'array' );
		jimport('joomla.filesystem.path');
		jimport('joomla.filesystem.file');
		if (JRequest::getVar( 'folder', '', '', 'string' )) $folder = JRequest::getVar( 'folder', '', '', 'string' );
		else $folder = DS . 'images'. DS . 'flippingbook';
		
		for ($i = 0; $i < count($userfile); $i++) {
			if (@$userfile['name'][$i] != '') {
				$tmp_dest = JPATH_SITE . $folder . DS . $userfile['name'][$i];
				$tmp_src = $userfile['tmp_name'][$i];
				$format = substr( $tmp_dest, -3 );
				$allowable = array ('jpg', 'png', 'gif', 'bmp', 'swf');
				$match = 0;
				foreach( $allowable as $ext ) {
					if ( strcasecmp( $format, $ext ) == 0 ) $match = 1;
				}
				if ($match == 0) {
					$msg .= '<tr><td align="right">' . $userfile['name'][$i] . '</td><td> ' . JText::_( 'Unsupported file type' ) . '</td></tr>';
				} else {
					if (JFile::upload($tmp_src, $tmp_dest)) {
						$msg .= '<tr><td align="right">' . $userfile['name'][$i] . '</td><td> OK </td></tr>';
					} else {
						$msg .= '<tr><td align="right">' . $userfile['name'][$i] . '</td><td> ERROR </td></tr>';
					}
				}
			}
		}
		$msg .= '</table>';
		$mainframe->redirect('index.php?option=com_flippingbook&task=file_manager&folder=' . JRequest::getVar( 'folder', '', '', 'string' ), $msg);
	}
	
	function removeRenameFile () {
		global $mainframe;
		require_once( JPATH_COMPONENT.DS.'views'.DS.'file_manager.php' );
		
		$file = JRequest::getVar( 'file_to_delete', '', 'get', 'string' );
		if ($file == '') $file = JRequest::getVar( 'file_to_rename', '', 'get', 'string' );
		
		if (($this->validateDelete ($file) == false)&&(JRequest::getVar( 'old_file_name', '', 'post', 'string' ) == '')) {
			$msg = $file . ' ' . JText::_( "can't be deleted or renamed" );
			$mainframe->redirect('index.php?option=com_flippingbook&task=file_manager&folder=' . JRequest::getVar( 'folder', '', '', 'string' ), $msg);
		} else {
			switch ($this->_task) {
			case 'delete_file':
				unlink (JPATH_SITE . JRequest::getVar( 'folder', '', '', 'string' ) . DS . $file);
				$msg = $file . JText::_( 'was deleted' );
				$mainframe->redirect('index.php?option=com_flippingbook&task=file_manager&folder=' . JRequest::getVar( 'folder', '', '', 'string' ), $msg);
				break;
			case 'rename_file':
			default:
				if (JRequest::getVar( 'file_to_rename', '', 'get', 'string' ) != '') {
					require_once( JPATH_COMPONENT . DS . 'views' . DS . 'file_manager.php' );
					FileManager::renameFileForm( $file );
				} else {
					$old_file_name = JRequest::getVar( 'old_file_name', '', 'post', 'string' );
					$new_file_name = JRequest::getVar( 'new_file_name', '', 'post', 'string' );
					if (preg_match('/\.(php|php3|php4|php5|php6|js|htm|html|phtml|cgi|pl|perl|asp)$/i', $new_file_name)) {
						$msg = JText::_( 'Incorrect file extension' );
						$mainframe->redirect('index.php?option=com_flippingbook&task=file_manager&folder=' . JRequest::getVar( 'folder', '', '', 'string' ), $msg);
					} else {
						if (JRequest::getVar( 'folder', '', 'post', 'string' )) $folder = JRequest::getVar( 'folder', '', 'post', 'string' );
						else $folder = DS . 'images'. DS . 'flippingbook';
						$path = JPATH_SITE . $folder;
						$old = $path . DS . $old_file_name;
						$new = $path . DS . $new_file_name;
						
						if (@rename ($old, $new)) {
							$msg = JText::_( 'File was renamed' );
							FileManager::fileManagerInterface( @$report );
						} else {
							$msg = JText::_( 'Error' );
							$msg .= $old . "<br>";
							$msg .= $new;
							FileManager::fileManagerInterface( @$report );
						}
						$mainframe->redirect('index.php?option=com_flippingbook&task=file_manager&folder=' . JRequest::getVar( 'folder', '', '', 'string' ), $msg);
					}
				}
				break;
			}
		}
	}
	
	function createFolder () {
		global $mainframe;
		jimport('joomla.filesystem.path');
		jimport('joomla.filesystem.file');
		require_once( JPATH_COMPONENT.DS.'views'.DS.'file_manager.php' );
		$folder = JRequest::getVar( 'folder', '', '', 'string' );
		$new_folder = JRequest::getVar( 'folder_name', '', 'post', 'string' );
		if (JRequest::getVar( 'save_folder', '', 'post', 'string' ) != 1) {
			FileManager::createFolderForm( $folder );
		} else {
			if (JFolder::create (JPATH_SITE . $folder . DS . $new_folder)) {
				$msg = JText::_( 'The folder was created' );
			} else {
				$msg = JText::_( 'Error' );
			}
			$mainframe->redirect('index.php?option=com_flippingbook&task=file_manager&folder=' . $folder, $msg);
		}
	}
	
	function renameFolder () {
		global $mainframe;
		jimport('joomla.filesystem.path');
		jimport('joomla.filesystem.file');
		require_once( JPATH_COMPONENT.DS.'views'.DS.'file_manager.php' );
		$folder = JRequest::getVar( 'folder_to_rename', '', '', 'string' );
		if (JRequest::getVar( 'folder_to_rename', '', 'get', 'string' ) != '') {
			FileManager::renameFolderForm( $folder );
		} else {
			$old_folder_name = JPATH_SITE. DS . 'images'. DS . 'flippingbook' . DS . JRequest::getVar( 'old_folder_name', '', 'post', 'string' );
			$new_folder_name = JPATH_SITE. DS . 'images'. DS . 'flippingbook' . DS . JRequest::getVar( 'new_folder_name', '', 'post', 'string' );
			if (@rename ($old_folder_name, $new_folder_name)) {
				$msg = JText::_( 'The folder was renamed' );
			} else {
				$msg = JText::_( 'Error' );
			}
			$mainframe->redirect('index.php?option=com_flippingbook&task=file_manager&folder=' . JRequest::getVar( 'folder', '', '', 'string' ), $msg);
		}
	}
	
	function deleteFolder () {
		global $mainframe;
		jimport('joomla.filesystem.path');
		jimport('joomla.filesystem.file');
		require_once( JPATH_COMPONENT.DS.'views'.DS.'file_manager.php' );
		$folder = JRequest::getVar( 'folder_to_delete', '', '', 'string' );
		if ($folder != '') {
			$folder_to_delete = JPATH_SITE. DS . 'images'. DS . 'flippingbook' . DS . $folder;
			if (JFolder::delete ($folder_to_delete)) {
				$msg = JText::_( 'The folder was deleted' );
			} else {
				$msg = JText::_( 'The folder can\'t be deleted' );
			}
			$mainframe->redirect('index.php?option=com_flippingbook&task=file_manager&folder=' . JRequest::getVar( 'folder', '', '', 'string' ), $msg);
		}
	}
	
	function saveCategoryOrder() {
		global $mainframe;
		$db = & JFactory::getDBO();
		$cid = JRequest::getVar( 'cid', array(0), 'post', 'array' );
		$order = JRequest::getVar( 'order', array (0), 'post', 'array' );
		$total = count( $cid );
		
		JArrayHelper::toInteger($cid, array(0));
		JArrayHelper::toInteger($order, array(0));

		$row =& JTable::getInstance('flippingcategory', 'Table');
		for( $i=0; $i < $total; $i++ ) {
			$row->load( (int) $cid[$i] );
			if ($row->ordering != $order[$i]) $row->ordering = $order[$i];
			$row->store();
		}
		$row->reorder();
		
		$link = 'index.php?option=com_flippingbook&task=category_manager';
		$this->setRedirect($link);
	}
	
	function saveBookOrder() {
		global $mainframe;
		$db			= & JFactory::getDBO();
		$cid		= JRequest::getVar( 'cid', array(0), 'post', 'array' );
		$order		= JRequest::getVar( 'order', array (0), 'post', 'array' );
		$total		= count( $cid );
		
		JArrayHelper::toInteger($cid, array(0));
		JArrayHelper::toInteger($order, array(0));

		$conditions = array();

		$row =& JTable::getInstance('flippingbook', 'Table');
		
		for( $i=0; $i < $total; $i++ ) {
			$row->load( (int) $cid[$i] );
			if ($row->ordering != $order[$i]) {
				$row->ordering = $order[$i];
				if (!$row->store()) {
					echo "<script> alert('".$database->getErrorMsg()."'); window.history.go(-1); </script>\n";
					exit();
				}
			$condition = "category_id = $row->category_id";
				$found = false;
				foreach ( $conditions as $cond )
					if ($cond[1]==$condition) {
						$found = true;
						break;
					}
				if (!$found) $conditions[] = array($row->id, $condition);
			}
		}
		foreach ( $conditions as $cond ) {
			$row->load( $cond[0] );
			$row->reorder( $cond[1] );
		}
		
		$link = 'index.php?option=com_flippingbook&task=book_manager';
		$this->setRedirect($link);
	}

	function savePageOrder() {
		global $mainframe;
		$db			= & JFactory::getDBO();
		$cid		= JRequest::getVar( 'cid', array(0), 'post', 'array' );
		$order		= JRequest::getVar( 'order', array (0), 'post', 'array' );
		$total		= count( $cid );
		
		JArrayHelper::toInteger($cid, array(0));
		JArrayHelper::toInteger($order, array(0));

		$conditions = array();

		$row =& JTable::getInstance('flippingpage', 'Table');
		
		for( $i=0; $i < $total; $i++ ) {
			$row->load( (int) $cid[$i] );
			if ($row->ordering != $order[$i]) {
				$row->ordering = $order[$i];
				if (!$row->store()) {
					echo "<script> alert('".$database->getErrorMsg()."'); window.history.go(-1); </script>\n";
					exit();
				}
			$condition = "book_id = $row->book_id";
				$found = false;
				foreach ( $conditions as $cond )
					if ($cond[1]==$condition) {
						$found = true;
						break;
					}
				if (!$found) $conditions[] = array($row->id, $condition);
			}
		}
		foreach ( $conditions as $cond ) {
			$row->load( $cond[0] );
			$row->reorder( $cond[1] );
		}
		$link = 'index.php?option=com_flippingbook&task=page_manager';
		$this->setRedirect($link);
	}

	function getFilesSelectBox ($field_name, $current_value, $add_blank_field, $filter, $custom_param) {
		//Folders list
		if ($add_blank_field == 1) $files[] = JHTML::_('select.option', '', '- '. JText::_( 'Select Image' ) .' -');
		$files[] = JHTML::_('select.option',  '<OPTGROUP>', DS.'images'.DS.'flippingbook'.DS );
		$image_files_root = JFolder::files(JPATH_SITE.DS.'images'.DS.'flippingbook'.DS, '.(' . $filter . ')$');
			if (count($image_files_root) > 0) {
				foreach ($image_files_root as $file) {
					$path_for_db = strtr($file, "\\", "/");
					$path_for_db = preg_replace ('/^\/images\/flippingbook\//', '', $path_for_db);
					$files[] = JHTML::_('select.option', $path_for_db, $file);
				}
			}
		$files[] = JHTML::_('select.option',  '</OPTGROUP>' );
		$folders = JFolder::listFolderTree (JPATH_ROOT.DS.'images'.DS.'flippingbook', '', 10);
		if (count($folders) > 0) {
			foreach ($folders as $folder) {
				$files[] = JHTML::_('select.option',  '<OPTGROUP>', $folder["relname"].DS );
				$image_files = JFolder::files(JPATH_SITE.$folder["relname"], '.(jpg|jpeg|swf)$');
				if (count($image_files) > 0) {
					foreach ($image_files as $file) {
						$path_for_db = strtr($folder["relname"] . DS . $file, "\\", "/");
						$path_for_db = preg_replace ('/^\/images\/flippingbook\//', '', $path_for_db);
						$files[] = JHTML::_('select.option', $path_for_db, $file);
					}
				}
				$files[] = JHTML::_('select.option',  '</OPTGROUP>' );
			}
		}
		return JHTML::_('select.genericlist', $files, $field_name, 'class="inputbox" size="1" ' . $custom_param . ' ', 'value', 'text', $current_value);
	}
	
	function validateDelete ($file) {
		$db	=& JFactory::getDBO();
		$user =& JFactory::getUser();
		$query = "SELECT p.file, p.zoom_url, b.preview_image, b.background_image "
				."FROM #__flippingbook_pages as p, #__flippingbook_books as b "
				."WHERE p.file IN ( '".$file."' ) OR p.zoom_url IN ( '".$file."' ) OR b.preview_image IN ( '".$file."' ) OR b.background_image IN ( '".$file."' )";

		$db->setQuery($query);
		$rows = $db->loadObjectList();
		
		if (count($rows) > 0) {
			return false;
		} else {
			return true;
		}
	}
	
	function getVersion() {
		$db	=& JFactory::getDBO();
		$query = "SELECT value FROM #__flippingbook_config WHERE name = 'version'";
		$db->setQuery( $query );
		$rows = $db->loadObjectList();
		return $rows[0]->value;
	}
}
?>
