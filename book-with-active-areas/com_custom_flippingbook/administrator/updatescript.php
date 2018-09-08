<?php
/**********************************************
* 	FlippingBook Gallery Component.
*	© Mediaparts Interactive. All rights reserved.
* 	Released under Commercial License.
*	www.page-flip-tools.com
**********************************************/
defined( '_JEXEC' ) or die( 'Restricted access' );

$query = "SELECT value FROM #__flippingbook_config WHERE name = 'version'";
$db->setQuery($query);
$rows = $db->loadObjectList();

if (count($rows) == 0) {
	$query = array();
	
	$query[] = "ALTER TABLE `#__flippingbook_books` ADD `zooming_method` INT( 1 ) NOT NULL DEFAULT '0'";
	$query[] = "ALTER TABLE `#__flippingbook_pages` ADD `zoom_height` INT( 4 ) NOT NULL DEFAULT '800'";
	$query[] = "ALTER TABLE `#__flippingbook_pages` ADD `zoom_width` INT( 4 ) NOT NULL DEFAULT '600'";
	$query[] = "INSERT INTO `#__flippingbook_config` ( `name` , `value` ) VALUES ( 'version', '1.5.7' )";

	foreach ( $query as $query_string ) {
		$db->setQuery( $query_string );
		$db->query() or die( $db->stderr() );
	}
?>
<dl id="system-message">
<dt class="message">Message</dt>
<dd class="message message fade">
	<ul>
		<li>FlippingBook was updated to 1.5.7 version</li>
	</ul>
</dd>
</dl>
<?php
}
?>