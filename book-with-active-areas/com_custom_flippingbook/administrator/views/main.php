<?php
/**********************************************
* 	FlippingBook Gallery Component.
*	© Mediaparts Interactive. All rights reserved.
* 	Released under Commercial License.
*	www.page-flip-tools.com
**********************************************/
defined( '_JEXEC' ) or die( 'Restricted access' );

class Main {
	function showMain( &$rows, $params )	{
		jimport('joomla.html.pane');
		$pane =& JPane::getInstance('sliders');
?>
<table width="100%" border="0" cellspacing="0" cellpadding="5">
	<tr>
		<td valign="top">
			<div style="background-color:#f0f0f0; padding:3px; border:1px solid #cccccc">Виртуальные каталоги v. <?php echo $params['version']; ?></div>
			<table width="384" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td width="128" height="150" align="center"><a href="index.php?option=com_flippingbook&task=configuration" style="text-decoration:none"><img src="components/com_flippingbook/images/m_config.png" alt="Configuration" align="top" border="0"><br />
					<?php echo JText::_( 'Configuration' );?></a>
					</td>
					<td width="128" height="150" align="center"><a href="index.php?option=com_flippingbook&task=category_manager" style="text-decoration:none"><img src="components/com_flippingbook/images/m_categories.png" alt="Categories Manager" align="top" border="0"><br />
					<?php echo JText::_( 'Manage Categories' );?></a>
					</td>
					<td width="128" height="150" align="center"><a href="index.php?option=com_flippingbook&task=book_manager" style="text-decoration:none"><img src="components/com_flippingbook/images/m_books.png" alt="Books Manager" align="top" border="0"><br />
					<?php echo JText::_( 'Book Manager' );?></a>
					</td>
				</tr>
				<tr>
					<td width="128" height="150" align="center"><a href="index.php?option=com_flippingbook&task=page_manager" style="text-decoration:none"><img src="components/com_flippingbook/images/m_pages.png" alt="Pages Manager" align="top" border="0" /><br />
					<?php echo JText::_( 'Page Manager' );?></a>
					</td>
					<td width="128" height="150" align="center"><a href="index.php?option=com_flippingbook&task=batch_add_pages" style="text-decoration:none"><img src="components/com_flippingbook/images/m_batch.png" alt="Batch Add Pages" align="top" border="0" /><br />
					<?php echo JText::_( 'Batch Add Pages' );?></a>
					</td>
					<td width="128" height="150" align="center"><a href="index.php?option=com_flippingbook&task=file_manager" style="text-decoration:none"><img src="components/com_flippingbook/images/m_filemanager.png" alt="File Manager" align="top" border="0" /><br />
					<?php echo JText::_( 'Simple File Manager' );?></a>
					</td>
				</tr>
			</table>
		</td>
		<td valign="top">
				<table class="adminlist">
					<thead>
						<tr>
							<th>
								<?php echo JText::_( 'Lates Books' );?>
							</th>
							<th width="50">
								<?php echo JText::_( 'Hits' );?>
							</th>
							<th width="150">
								<?php echo JText::_( 'Modified' );?>
							</th>
						</tr>
					</thead>
					<tbody>
<?php 
for ($i=0, $n=count( $rows ); $i < $n; $i++) {
$row = &$rows[$i];
?>
						<tr>
							<td>
								<a href="index.php?option=com_flippingbook&amp;task=edit_book&amp;cid%5B%5D=<?php echo $row->id; ?>" title="<?php echo JText::_( 'Edit Book' );?>"><?php echo $row->title; ?></a>
							</td>
							<td align="center">
								<?php echo $row->hits; ?>
							</td>
							<td align="center">
								<?php echo $row->modified; ?>
							</td>
						</tr>
<?php
}
?>
					</tbody>
				</table>
			<br />
<?php 
echo $pane->startPane("menu-pane");

?>
		</td>
	</tr>
</table>
<?php
	}
}
?>
