<?php
/**********************************************
* 	FlippingBook Gallery Component.
*	© Mediaparts Interactive. All rights reserved.
* 	Released under Commercial License.
*	www.page-flip-tools.com
**********************************************/
defined( '_JEXEC' ) or die( 'Restricted access' );

class CategoryManager {
	function showCategories( &$rows, &$pageNav, $option, &$lists ) {
		$user =& JFactory::getUser();
		$ordering = ($lists['order'] == 'm.ordering');
		JHTML::_('behavior.tooltip'); ?>
<form action="index.php?option=com_flippingbook" method="post" name="adminForm">
	<div id="tablecell">
		<table class="adminlist">
			<thead>
				<tr>
					<th width="5">
						<?php echo JText::_( 'NUM' ); ?></th>
					<th width="20">
						<input type="checkbox" name="toggle" value="" onclick="checkAll(<?php echo count( $rows ); ?>);" /></th>
					<th width="1%" nowrap="nowrap"><?php echo JHTML::_('grid.sort', 'ID', 'm.id', @$lists['order_Dir'], @$lists['order'], 'category_manager' ); ?></th>
					<th class="title">
						<?php echo JHTML::_('grid.sort', 'Title', 'm.title', @$lists['order_Dir'], @$lists['order'], 'category_manager' ); ?></th>
					<th align="center"><?php echo JHTML::_('grid.sort', 'Books', 'numoptions', @$lists['order_Dir'], @$lists['order'], 'category_manager' ); ?></th>
					<th align="center">
						<?php echo JHTML::_('grid.sort', 'Published', 'm.published', @$lists['order_Dir'], @$lists['order'], 'category_manager' ); ?></th>
					<th align="center">
						<?php echo JText::_( 'Description' ); ?></th>
					<th colspan="3" nowrap="nowrap">
						<?php echo JHTML::_('grid.sort', 'Ordering', 'm.ordering', @$lists['order_Dir'], @$lists['order'], 'category_manager' ); ?><?php echo JHTML::_('grid.order', $rows, 'filesave.png', 'savecategoryorder' ); ?></th>
				</tr>
			</thead>
			<tfoot>
				<tr>
					<td colspan="10"><?php echo $pageNav->getListFooter(); ?></td>
				</tr>
			</tfoot>
			<tbody>
			<?php
			$k = 0;
			for ($i=0, $n=count( $rows ); $i < $n; $i++) {
				$row = &$rows[$i];
				$link 		= 'index.php?option=com_flippingbook&task=edit_category&cid[]='. $row->id ;
				$checked 	= JHTML::_('grid.checkedout', $row, $i );
				$published 	= JHTML::_('grid.published', $row, $i ); ?>
				<tr class="<?php echo "row$k"; ?>">
					<td>
						<?php echo $pageNav->getRowOffset( $i ); ?>					</td>
					<td>
						<?php echo $checked; ?>					</td>
					<td align="center"><?php echo $row->id; ?></td>
					<td><?php if ( JTable::isCheckedOut($user->get ('id'), $row->checked_out ) ) {
						echo $row->title;
					} else {
						?>
						<a href="<?php echo JRoute::_( $link ); ?>" title="<?php echo JText::_( 'Edit Category' ); ?>">
						<?php echo $row->title; ?></a>
						<?php
					} ?>
					</td>
					<td align="center"><?php echo $row->numoptions;?></td>
					<td align="center">
						<?php echo $published;?>					</td>
					<td>
						<?php echo $row->description; ?>					</td>
					<td width="1%" align="center"><?php echo $pageNav->orderUpIcon( $i, true, 'orderup_category', 'Move Down', $ordering ); ?></td>
					<td width="1%" align="center"><?php echo $pageNav->orderDownIcon( $i, $n, true, 'orderdown_category', 'Move Down', $ordering ); ?></td>
					<td width="1%" align="center"><?php $disabled = $ordering ? '' : 'disabled="disabled"'; ?>
					<input type="text" name="order[]" size="5" value="<?php echo $row->ordering; ?>" <?php echo $disabled; ?> class="text_area" style="text-align: center" /></td>
				</tr>
				<?php
				$k = 1 - $k;
			}
			?>
			</tbody>
		</table>
	</div>

	<input type="hidden" name="option" value="<?php echo $option;?>" />
	<input type="hidden" name="task" value="category_manager" />
	<input type="hidden" name="section" value="category_manager" />
	<input type="hidden" name="boxchecked" value="0" />
	<input type="hidden" name="filter_order" value="<?php echo $lists['order']; ?>" />
	<input type="hidden" name="filter_order_Dir" value="" />
</form>
<?php
	}

	function editCategory( &$row, &$lists ) {
		if (JRequest::getCmd('task') == 'add_category') {
			//Default values for new category
			$row->title = 'New category';
			$row->description = '';
			$row->published = 1;
			$row->ordering = 0;
			$row->emailIcon = 1;
			$row->printIcon = 1;
			$row->colums = 2;
			$row->style = "blog";
			$row->preview_image = '';
		}
		JRequest::setVar( 'hidemainmenu', 1 );
		$editor =& JFactory::getEditor();
		jimport('joomla.filter.output');
		JFilterOutput::objectHTMLSafe( $row, ENT_QUOTES );
		jimport('joomla.html.pane');
		$pane =& JPane::getInstance('sliders');
		JHTML::_('behavior.tooltip');
?>
		
<script language="javascript" type="text/javascript">
	function submitbutton(pressbutton) {
		var form = document.adminForm;
		if (pressbutton == 'cancel_category') {
			submitform( pressbutton );
			return;
		}
		// do field validation
		if (form.title.value == "") {
			alert( "<?php echo JText::_( 'Category must have a title', true ); ?>" );
		} else {
			submitform( pressbutton );
		}
	}
</script>
<br>
<form action="index.php" method="post" name="adminForm">
<table width="100%" border="0" cellspacing="5" cellpadding="0" class="adminform">
	<tr>
		<td valign="top">
			<table class="admintable">
				<tr>
					<td class="key"><label for="title"><?php echo JText::_( 'Title' ); ?></label></td>
					<td><input class="inputbox" type="text" name="title" id="title" size="60" value="<?php echo $row->title; ?>" /></td>
				</tr>
				<tr>
					<td class="key"><label for="alias"><?php echo JText::_( 'Alias' ); ?></label></td>
					<td><input class="inputbox" type="text" name="alias" id="alias" size="60" value="<?php echo $row->alias; ?>" /></td>
				</tr>
				<tr>
					<td class="key"><?php echo JText :: _('Show Title'); ?></td>
					<td><?php echo JHTML::_( 'select.booleanlist', 'show_title', 'class="inputbox"', $row->show_title ); ?></td>
				</tr>
				<tr>
					<td class="key"><?php echo JText :: _('Published'); ?></td>
					<td><?php echo JHTML::_( 'select.booleanlist', 'published', 'class="inputbox"', $row->published ); ?></td>
				</tr>
				<tr>
					<td class="key"><?php echo JText::_( 'Columns In Book List' ); ?></td>
					<td><?php echo $lists['columns']; ?></td>
				</tr>
				<tr>
					<td class="key"><?php echo JText::_( 'Print Icon' ); ?></td>
					<td><?php echo JHTML::_( 'select.booleanlist', 'printIcon', 'class="inputbox"', $row->printIcon ); ?></td>
				</tr>
				<tr>
					<td class="key"><?php echo JText::_( 'Email Icon' ); ?></td>
					<td><?php echo JHTML::_( 'select.booleanlist', 'emailIcon', 'class="inputbox"', $row->emailIcon ); ?></td>
				</tr>
				<tr>
					<td class="key"><?php echo JText :: _('Preview Image'); ?></td>
					<td><?php echo $lists['preview_image']; ?></td>
				</tr>
				<tr>
					<td class="key"><?php echo JText::_( 'Description' ); ?></td>
					<td><?php echo $editor->display( 'description', $row->description, '100%', '300', '60', '20', false ) ; ?></td>
				</tr>
			</table>
		</td>
		<td valign="top">
		</td>
	</tr>
</table>
		<input type="hidden" name="task" value="" />
		<input type="hidden" name="option" value="com_flippingbook" />
		<input type="hidden" name="id" value="<?php echo $row->id; ?>" />
		<input type="hidden" name="cid[]" value="<?php echo $row->id; ?>" />
		<input type="hidden" name="ordering" value="<?php echo $row->ordering; ?>" />
</form>
		<?php
	}
}
?>
