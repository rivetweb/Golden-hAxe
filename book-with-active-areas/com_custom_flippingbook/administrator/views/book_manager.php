<?php
/**********************************************
* 	FlippingBook Gallery Component.
*	© Mediaparts Interactive. All rights reserved.
* 	Released under Commercial License.
*	www.page-flip-tools.com
**********************************************/
defined( '_JEXEC' ) or die( 'Restricted access' );

class BookManager {
	function showBooks( &$rows, &$pageNav, $option, &$lists ) {
		$user =& JFactory::getUser();
		$ordering = ($lists['order'] == 'm.category_id' || $lists['order'] == 'b.title');
		JHTML::_('behavior.tooltip');
		?>
		<form action="index.php?option=com_flippingbook" method="post" name="adminForm">
			<table width="100%">
				<tr>
					<td align="left">
						<?php echo JText::_( 'Filter (Title, Description)' ); ?>:
						<input type="text" name="search" id="search" value="<?php echo $lists['search'];?>" class="text_area" onchange="document.adminForm.submit();" />
						<button onclick="this.form.submit();"><?php echo JText::_( 'Go' ); ?></button>
						<button onclick="document.getElementById('search').value='';this.form.submit();"><?php echo JText::_( 'Reset' ); ?></button></td>
					<td align="center" nowrap="nowrap">
						<?php echo JText::_( 'Category Filter' ); ?>:<?php
						echo $lists['category'];
						?></td>
					<td align="right" nowrap="nowrap"><?php echo JText::_( 'State Filter' ); ?>:
						<?php
						echo $lists['state'];
						?></td>
				</tr>
			</table>
		<div id="tablecell">
			<table class="adminlist">
				<thead>
					<tr>
						<th width="5" nowrap="nowrap"><?php echo JText::_( 'NUM' ); ?></th>
						<th width="20" nowrap="nowrap"><input type="checkbox" name="toggle" value="" onclick="checkAll(<?php echo count( $rows ); ?>);" /></th>
						<th width="1%" nowrap="NOWRAP"><?php echo JHTML::_('grid.sort', 'ID', 'm.id', @$lists['order_Dir'], @$lists['order'], 'book_manager' ); ?></th>
						<th nowrap="nowrap" class="title"><?php echo JHTML::_('grid.sort', 'Book Title', 'book_title', @$lists['order_Dir'], @$lists['order'], 'book_manager' ); ?></th>
						<th align="center" nowrap="nowrap"><?php echo JHTML::_('grid.sort', 'Published', 'm.published', @$lists['order_Dir'], @$lists['order'], 'book_manager' ); ?></th>
						<th align="center"><?php echo JText::_( 'Description' ); ?></th>
						<th align="center" nowrap="nowrap"><?php echo JHTML::_('grid.sort', 'Category ID', 'm.category_id', @$lists['order_Dir'], @$lists['order'], 'book_manager' ); ?></th>
						<th align="center" nowrap="nowrap"><?php echo JHTML::_('grid.sort', 'Category Title', 'm.title', @$lists['order_Dir'], @$lists['order'], 'book_manager' ); ?></th>
						<th colspan="3" nowrap="NOWRAP"><?php echo JHTML::_('grid.sort', 'Ordering', 'm.ordering', @$lists['order_Dir'], @$lists['order'], 'book_manager' ); ?><?php echo JHTML::_('grid.order', $rows, 'filesave.png', 'savebookorder' ); ?></th>
					</tr>
				</thead>
				<tfoot>
					<tr>
						<td colspan="13">
							<?php echo $pageNav->getListFooter(); ?>					</td>
					</tr>
				</tfoot>
				<tbody>
			<?php
			$k = 0;
			for ($i=0, $n=count( $rows ); $i < $n; $i++) {
				$row = &$rows[$i];

				$link 		= 'index.php?option=com_flippingbook&task=edit_book&cid[]='. $row->id ;

				$checked 	= JHTML::_('grid.checkedout', $row, $i );
				$published 	= JHTML::_('grid.published', $row, $i );
				?>
				<tr class="<?php echo "row$k"; ?>">
					<td><?php echo $pageNav->getRowOffset( $i ); ?></td>
					<td><?php echo $checked; ?></td>
					<td align="center"><?php echo $row->id; ?></td>
					<td><?php if ( JTable::isCheckedOut($user->get ('id'), $row->checked_out ) ) {
						echo $row->title;
					} else { ?>
						<a href="<?php echo JRoute::_( $link ); ?>" title="<?php echo JText::_( 'Edit Book' ); ?>"><?php echo $row->book_title; ?></a>
					<?php }	?></td>
					<td align="center"><?php echo $published;?></td>
					<td><?php echo $row->description;?></td>
					<td width="1%" align="center"><?php echo $row->category_id;?></td>
					<td align="left"><?php echo $row->category_title;?></td>
					<td width="1%" align="center"><?php echo $pageNav->orderUpIcon( $i, ($row->category_id == @$rows[$i-1]->category_id) , 'orderup_book', 'Move Up', $ordering); ?></td>
					<td width="1%" align="center"><?php echo $pageNav->orderDownIcon( $i, $n, ($row->category_id == @$rows[$i+1]->category_id), 'orderdown_book', 'Move Down', $ordering ); ?></td>
					<td width="1%" align="center" nowrap="nowrap"><?php $disabled = $ordering ? '' : 'disabled="disabled"'; ?><input type="text" name="order[]" size="5" value="<?php echo $row->ordering; ?>" <?php echo $disabled; ?> class="text_area" style="text-align: center" /></td>
				</tr>
				<?php
				$k = 1 - $k;
			}
			?>
			</tbody>
			</table>
		</div>

		<input type="hidden" name="option" value="<?php echo $option;?>" />
		<input type="hidden" name="task" value="book_manager" />
		<input type="hidden" name="section" value="book_manager" />
		<input type="hidden" name="boxchecked" value="0" />
		<input type="hidden" name="filter_order" value="<?php echo $lists['order']; ?>" />
		<input type="hidden" name="filter_order_Dir" value="" />
		</form>
		<?php
	}

	function editBook( &$row, &$lists ) {
		JRequest::setVar( 'hidemainmenu', 1 );
		$editor =& JFactory::getEditor();
		jimport( 'joomla.filter.output' );
		JFilterOutput::objectHTMLSafe( $row, ENT_QUOTES );
		jimport( 'joomla.html.pane' );
		$pane =& JPane::getInstance( 'sliders' );
		JHTML::_( 'behavior.tooltip' );
?>
		
<script language="javascript" type="text/javascript">
	function submitbutton(pressbutton) {
		var form = document.adminForm;
		if (pressbutton == 'cancel_book') {
			submitform( pressbutton );
			return;
		}

		if (form.title.value == "") {
			alert( "<?php echo JText::_( 'Book must have a title', true ); ?>" );
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
<?php 
if ( $row->id != "" ) {
?>
				<tr>
					<td class="key"></td>
					<td><?php echo '<a href="../index2.php?option=com_flippingbook&view=book&id=' . $row->id . '" target="_blank">' . JText::_( 'Preview Book' ) . '</a>'; ?></td>
				</tr>
				<tr>
					<td class="key"><label for="title"><?php echo JText::_( 'Book URL' ); ?></label></td>
					<td><?php echo 'index.php?option=com_flippingbook&view=book&id='.$row->id; ?></td>
				</tr>
<?php 
} 
?>
				<tr>
					<td class="key"><label for="title"><?php echo JText::_( 'Category' ); ?></label></td>
					<td><?php echo $lists['categories']; ?></td>
				</tr>
				<tr>
					<td class="key"><label for="title"><?php echo JText::_( 'Preview Image' );?></label></td>
					<td><?php echo $lists['preview_image']; ?></td>
				</tr>
				<tr>
					<td class="key"><label for="title"><?php echo JText::_( 'Title' ); ?></label></td>
					<td><input class="inputbox" type="text" name="title" id="title" size="60" value="<?php echo $row->title; ?>" /></td>
				</tr>
				<tr>
					<td class="key"><label for="title"><?php echo JText::_( 'Alias' ); ?></label></td>
					<td><input class="inputbox" type="text" name="alias" id="alias" size="60" value="<?php echo $row->alias; ?>" /></td>
				</tr>
				<tr>
					<td class="key"><label for="title"><?php echo JText::_( 'Ordering' );?></label></td>
					<td><input name="ordering" type="text" class="text_area" id="ordering" value="<?php echo $row->ordering; ?>" /></td>
				</tr>
				<tr>
					<td class="key"><?php echo JText::_( 'Description' ); ?></td>
					<td><?php echo $editor->display( 'description', $row->description, '100%', '300', '60', '20', false ) ; ?></td>
				</tr>
			</table>
		</td>
		<td valign="top">
		
		<table style="border: 1px dashed silver; padding: 5px; margin-bottom: 10px;" width="100%">
			<tbody>
<?php 
if ( $row->id != "" ) { 
?>
				<tr>
					<td>
						<strong>Book ID:</strong>
					</td>
					<td>
						<?php echo $row->id; ?>
					</td>
				</tr>
<?php
}
?>
				<tr>
					<td>
						<strong>State</strong>
					</td>
					<td>
<?php 
if ( $row->published == 1 ) 
	echo JText :: _('Published');
else 
	echo JText :: _('Unpublished'); 
?>
					</td>
				</tr>
				<tr>
					<td>
						<strong>Hits</strong>
					</td>
					<td>
						<?php echo $row->hits; ?>
					</td>
				</tr>
				<tr>
					<td>
						<strong>Created</strong>
					</td>
					<td>
						<?php echo JHTML::_('date',  $row->created, JText::_('DATE_FORMAT_LC2')); ?>
					</td>
				</tr>
				<tr>
					<td>
						<strong>Modified</strong>
					</td>
					<td>
						<?php echo JHTML::_('date',  $row->modified, JText::_('DATE_FORMAT_LC2')); ?>
					</td>
				</tr>
			</tbody>
		</table>
<?php 
echo $pane->startPane("menu-pane");
echo $pane->startPanel(JText :: _('Publishing'), "param-publishing"); 
?>
			<table class="admintable">
				<tr>
					<td class="key"><?php echo JText :: _('Published'); ?></td>
					<td><?php echo JHTML::_( 'select.booleanlist', 'published', 'class="inputbox"', $row->published ); ?></td>
				</tr>
				<tr>
					<td class="key"><?php echo JText :: _('Show Book Title'); ?></td>
					<td><?php echo JHTML::_( 'select.booleanlist', 'show_book_title', 'class="inputbox"', $row->show_book_title ); ?></td>
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
					<td class="key"><?php echo JText :: _('Show Book Description'); ?></td>
					<td><?php echo JHTML::_( 'select.booleanlist', 'show_book_description', 'class="inputbox"', $row->show_book_description ); ?></td>
				</tr>
				<tr>
					<td class="key"><?php echo JText :: _('Show Pages Description'); ?></td>
					<td><?php echo JHTML::_( 'select.booleanlist', 'show_pages_description', 'class="inputbox"', $row->show_pages_description ); ?></td>
				</tr>
			</table>
<?php
echo $pane->endPanel();
echo $pane->startPanel(JText :: _('Parameters (Basic)'), "param-basic_parameters"); 
?>
			<table class="admintable">
				<tr>
					<td class="key"><span class="editlinktip hasTip" title="<?php echo JText::_( 'Pages Width' );?>::<?php echo JText::_( 'Pages Width Description' ); ?>"><?php echo JText :: _('Pages Width'); ?></span></td>
					<td><input name="book_width" type="text" class="text_area" id="book_width" value="<?php echo $row->book_width; ?>"/></td>
				</tr>
				<tr>
					<td class="key"><span class="editlinktip hasTip" title="<?php echo JText::_( 'Pages Height' );?>::<?php echo JText::_( 'Pages Height Description' ); ?>"><?php echo JText :: _('Pages Height'); ?></span></td>
					<td><input name="book_height" type="text" class="text_area" id="book_height" value="<?php echo $row->book_height; ?>" /></td>
				</tr>
				<tr>
					<td class="key"><span class="editlinktip hasTip" title="<?php echo JText::_( 'Flash Width' );?>::<?php echo JText::_( 'Flash Width Description' ); ?>"><?php echo JText :: _('Flash Width'); ?></span></td>
					<td><input name="flash_width" type="text" class="text_area" id="flash_width" value="<?php echo $row->flash_width; ?>" /></td>
				</tr>
				<tr>
					<td class="key"><span class="editlinktip hasTip" title="<?php echo JText::_( 'Flash Height' );?>::<?php echo JText::_( 'Flash Height Description' ); ?>"><?php echo JText :: _('Flash Height'); ?></span></td>
					<td><input name="flash_height" type="text" class="text_area" id="flash_height" value="<?php echo $row->flash_height; ?>" /></td>
				</tr>
				<tr>
					<td class="key"><span class="editlinktip hasTip" title="<?php echo JText::_( 'Hardcover' );?>::<?php echo JText::_( 'Hardcover Description' ); ?>"><?php echo JText :: _('Hardcover'); ?></span></td>
					<td nowrap="nowrap"><?php echo JHTML::_( 'select.booleanlist', 'hardcover', 'class="inputbox"', $row->hardcover ); ?></td>
				</tr>
				<tr>
					<td class="key"><span class="editlinktip hasTip" title="<?php echo JText::_( 'Print Enabled' );?>::<?php echo JText::_( 'Print Enabled Description' ); ?>"><?php echo JText :: _('Print Enabled'); ?></span></td>
					<td nowrap="nowrap"><?php echo JHTML::_( 'select.booleanlist', 'print_enabled', 'class="inputbox"', $row->print_enabled ); ?></td>
				</tr>
				<tr>
					<td class="key"><span class="editlinktip hasTip" title="<?php echo JText::_( 'Center Book' );?>::<?php echo JText::_( 'Center Book Description' ); ?>"><?php echo JText :: _('Center Book'); ?></span></td>
					<td nowrap="nowrap"><?php echo JHTML::_( 'select.booleanlist', 'center_book', 'class="inputbox"', $row->center_book ); ?></td>
				</tr>
				<tr>
					<td class="key"><span class="editlinktip hasTip" title="<?php echo JText::_( 'Scale Content' );?>::<?php echo JText::_( 'Scale Content Description' ); ?>"><?php echo JText :: _('Scale Content'); ?></span></td>
					<td nowrap="nowrap"><?php echo JHTML::_( 'select.booleanlist', 'scale_content', 'class="inputbox"', $row->scale_content ); ?></td>
				</tr>
				<tr>
					<td class="key"><span class="editlinktip hasTip" title="<?php echo JText::_( 'Always Opened' );?>::<?php echo JText::_( 'Always Opened Description' ); ?>"><?php echo JText :: _('Always Opened'); ?></span></td>
					<td nowrap="nowrap"><?php echo JHTML::_( 'select.booleanlist', 'always_opened', 'class="inputbox"', $row->always_opened ); ?></td>
				</tr>
			</table>
<?php
echo $pane->endPanel();
echo $pane->startPanel(JText :: _('Background'), "param-background"); 
?>
			<table class="admintable">
				<tr>
					<td class="key"><span class="editlinktip hasTip" title="<?php echo JText::_( 'Background Image' );?>::<?php echo JText::_( 'Background Image Description' ); ?>"><?php echo JText :: _('Background Image'); ?></span></td>
					<td><?php echo $lists['background_image']; ?></td>
				</tr>
				<tr>
					<td class="key"><label for="title"><?php echo JText::_( 'Background Image Placement' ); ?></label></td>
					<td><?php echo $lists['backgroundImagePlacement']; ?></td>
				</tr>
				<tr>
					<td class="key"><span class="editlinktip hasTip" title="<?php echo JText::_( 'Background Color' );?>::<?php echo JText::_( 'Background Color Description' ); ?>"><?php echo JText :: _('Background Color'); ?></span></td>
					<td><input name="background_color" type="text" style="width:130px;" maxlength="6" id="background_color" value="<?php echo $row->background_color; ?>" /><a href="javascript:onclick=colorSelector('background_color','none');">&gt;&gt;&gt;</a></td>
				</tr>
				<tr>
					<td class="key"><span class="editlinktip hasTip" title="<?php echo JText::_( 'Page Background Color' );?>::<?php echo JText::_( 'Page Background Color Description' ); ?>"><?php echo JText :: _('Page Background Color'); ?></span></td>
					<td><input name="page_background_color" type="text" style="width:130px;" maxlength="6" id="page_background_color" value="<?php echo $row->page_background_color; ?>" /><a href="javascript:onclick=colorSelector('page_background_color','none');">&gt;&gt;&gt;</a></td>
				</tr>
			</table>
<?php
echo $pane->endPanel();
echo $pane->startPanel(JText :: _('Navigation Bar'), "param-navigationbar"); 
?>
			<table class="admintable">
				<tr>
					<td class="key"><span class="editlinktip hasTip" title="<?php echo JText::_( 'Navigation Bar File' );?>::<?php echo JText::_( 'Navigation Bar File Description' ); ?>"><?php echo JText :: _('Navigation Bar File'); ?></span></td>
					<td><?php echo $lists['navigationBarFiles']; ?></td>
				</tr>
				<tr>
					<td class="key"><span class="editlinktip hasTip" title="<?php echo JText::_( 'Navigation Bar Placement' );?>::<?php echo JText::_( 'Navigation Bar Placement Description' ); ?>"><?php echo JText :: _('Navigation Bar Placement'); ?></span></td>
					<td><?php echo $lists['navigationBarPlacement']; ?></td>
				</tr>  
				<tr>
					<td class="key"><?php echo JText::_( 'Show Fullscreen Button' );?></td>
					<td><?php echo JHTML::_( 'select.booleanlist', 'fullscreen_enabled', 'class="inputbox"', $row->fullscreen_enabled ); ?></td>
				</tr>
				<tr>
					<td class="key"><?php echo JText::_( 'Show "Go To Page" field' );?></td>
					<td><?php echo JHTML::_( 'select.booleanlist', 'go_to_page_field', 'class="inputbox"', $row->go_to_page_field ); ?></td>
				</tr>
				<tr>
					<td class="key"><?php echo JText::_( 'Show Slideshow Button' );?></td>
					<td><?php echo JHTML::_( 'select.booleanlist', 'slideshow_button', 'class="inputbox"', $row->slideshow_button ); ?></td>
				</tr>
				<tr>
					<td class="key"><?php echo JText::_( 'Show "First" and "Last" Buttons' );?></td>
					<td><?php echo JHTML::_( 'select.booleanlist', 'first_last_buttons', 'class="inputbox"', $row->first_last_buttons ); ?></td>
				</tr>
			</table>
<?php
echo $pane->endPanel();
echo $pane->startPanel(JText :: _('Zoom Settings'), "param-zooming"); 
?>
			<table class="admintable">
				<tr>
					<td class="key"><span class="editlinktip hasTip" title="<?php echo JText::_( 'Zoom Enabled' );?>::<?php echo JText::_( 'Zoom Enabled Description' ); ?>"><?php echo JText :: _('Zoom Enabled'); ?></span></td>
					<td><?php echo JHTML::_( 'select.booleanlist', 'zoom_enabled', 'class="inputbox"', $row->zoom_enabled ); ?></td>
				</tr>
				<tr>
					<td class="key"><span class="editlinktip hasTip" title="<?php echo JText::_( 'Zooming Method' );?>::<?php echo JText::_( 'Zooming Method Description' ); ?>"><?php echo JText :: _('Zooming Method'); ?></span></td>
					<td><?php echo $lists['zoomingMethod']; ?></td>
				</tr>
				<tr>
					<td class="key"><span class="editlinktip hasTip" title="<?php echo JText::_( 'Zoom Image Height' );?>::<?php echo JText::_( 'Zoom Image Height Description' ); ?>"><?php echo JText :: _('Zoom Image Height'); ?></span></td>
					<td><input name="zoom_image_height" type="text" class="text_area" id="zoom_image_height" value="<?php echo $row->zoom_image_height; ?>" /></td>
				</tr>
				<tr>
					<td class="key"><span class="editlinktip hasTip" title="<?php echo JText::_( 'Zoom Image Width' );?>::<?php echo JText::_( 'Zoom Image Width Description' ); ?>"><?php echo JText :: _('Zoom Image Width'); ?></span></td>
					<td><input name="zoom_image_width" type="text" class="text_area" id="zoom_image_width" value="<?php echo $row->zoom_image_width; ?>" /></td>
				</tr>
				<tr>
					<td class="key"><span class="editlinktip hasTip" title="<?php echo JText::_( 'Zoom UI Color' );?>::<?php echo JText::_( 'Zoom UI Color Description' ); ?>"><?php echo JText :: _('Zoom UI Color'); ?></span></td>
					<td><input name="zoom_ui_color" type="text" style="width:130px;" maxlength="6" id="zoom_ui_color" value="<?php echo $row->zoom_ui_color; ?>" /><a href="javascript:onclick=colorSelector('zoom_ui_color','none');">&gt;&gt;&gt;</a></td>
				</tr>
			</table>
			<script language="javascript" type="text/javascript">
				var zoom_image_height_obj = document.getElementById("zoom_image_height");
				var zoom_image_width_obj = document.getElementById("zoom_image_width");
				var zooming_method_obj = document.getElementById("zooming_method");
				function check_method() {
					if (zooming_method_obj.selectedIndex == 1) {
						zoom_image_height_obj.disabled = true;
						zoom_image_width_obj.disabled = true;
					} else {
						zoom_image_height_obj.disabled = false;
						zoom_image_width_obj.disabled = false;
					}
				}
				check_method();
			</script>
<?php
echo $pane->endPanel();
echo $pane->startPanel(JText :: _('Download Book'), "param-download"); 
?>
			<table class="admintable">
				<tr>
					<td class="key"><span class="editlinktip hasTip" title="<?php echo JText::_( 'Download URL' );?>::<?php echo JText::_( 'Download URL Description' ); ?>"><?php echo JText :: _('Download URL'); ?></span></td>
					<td><input name="download_url" type="text" class="text_area" id="download_url" value="<?php echo $row->download_url; ?>"/></td>
				</tr>
				<tr>
					<td class="key"><span class="editlinktip hasTip" title="<?php echo JText::_( 'Download Title' );?>::<?php echo JText::_( 'Download Title Description' ); ?>"><?php echo JText :: _('Download Title'); ?></span></td>
					<td><input name="download_title" type="text" class="text_area" id="download_title" value="<?php echo $row->download_title; ?>"/></td>
				</tr>
				<tr>
					<td class="key"><span class="editlinktip hasTip" title="<?php echo JText::_( 'File Size' );?>::<?php echo JText::_( 'File Size Description' ); ?>"><?php echo JText :: _('File Size'); ?></span></td>
					<td><input name="download_size" type="text" class="text_area" id="download_size" value="<?php echo $row->download_size; ?>"/></td>
				</tr>
			</table>
<?php
echo $pane->endPanel();
echo $pane->startPanel(JText :: _('Slideshow'), "param-slideshow"); 
?>

<table class="admintable">
	<tr>
		<td class="key"><span class="editlinktip hasTip" title="<?php echo JText::_( 'Turn Slideshow On' );?>::<?php echo JText::_( 'Turn Slideshow On Description' ); ?>"><?php echo JText :: _('Turn Slideshow On'); ?></span></td>
		<td><?php echo JHTML::_( 'select.booleanlist', 'slideshow_auto_play', 'class="inputbox"', $row->slideshow_auto_play ); ?></label></td>
	</tr>
	<tr>
		<td class="key"><span class="editlinktip hasTip" title="<?php echo JText::_( 'Page Browsing Interval' );?>::<?php echo JText::_( 'Page Browsing Interval Description' ); ?>"><?php echo JText :: _('Page Browsing Interval'); ?></span></td>
		<td><input name="slideshow_display_duration" type="text" class="inputbox" id="slideshow_display_duration" style="width:130px;" value="<?php echo $row->slideshow_display_duration; ?>" size="5" /></td>
	</tr>
</table>

<?php
echo $pane->endPanel();
echo $pane->startPanel(JText :: _('Book Window'), "param-book_window"); 
?>

<table class="admintable">
	<tr>
		<td class="key"><span class="editlinktip hasTip" title="<?php echo JText::_( 'Book Link Target' );?>::<?php echo JText::_( 'Book Link Target Description' ); ?>"><?php echo JText :: _('Book Link Target'); ?></span></td>
		<td><select name="open_book_in" id="open_book_in" class="inputbox" size="2" onchange="check_window_target()">
			<option value="1" <?php if ($row->open_book_in == 1) echo 'selected="selected"'; ?>>Parent Window With Browser Navigation</option>
			<option value="3" <?php if ($row->open_book_in == 3) echo 'selected="selected"'; ?>>New Window Without Browser Navigation</option>
			</select>
		</td>
	</tr>
	<tr>
		<td class="key"><span class="editlinktip hasTip" title="<?php echo JText::_( 'New Window Width' );?>::<?php echo JText::_( 'New Window Width Description' ); ?>"><?php echo JText :: _('New Window Width'); ?></span></td>
		<td><input name="new_window_width" type="text" class="inputbox" id="new_window_width" style="width:130px;" value="<?php echo $row->new_window_width; ?>"/></td>
	</tr>
	<tr>
		<td class="key"><span class="editlinktip hasTip" title="<?php echo JText::_( 'New Window Height' );?>::<?php echo JText::_( 'New Window Height Description' ); ?>"><?php echo JText :: _('New Window Height'); ?></span></td>
		<td><input name="new_window_height" type="text" class="inputbox" id="new_window_height" style="width:130px;" value="<?php echo $row->new_window_height; ?>"/></td>
	</tr>
</table>
<script language="javascript" type="text/javascript">
var new_window_width_obj = document.getElementById("new_window_width");
var new_window_height_obj = document.getElementById("new_window_height");
var open_book_in_list = document.getElementById("open_book_in");
function check_window_target() {
	if (open_book_in_list.selectedIndex == 0) {
		new_window_width_obj.disabled = true;
		new_window_height_obj.disabled = true;
	} else {
		new_window_width_obj.disabled = false;
		new_window_height_obj.disabled = false;
	}
}
check_window_target();
</script>

<?php
echo $pane->endPanel();
echo $pane->startPanel(JText :: _('Parameters (Advanced)'), "param-advanced_parameters"); 
?>
			<table class="admintable">
				<tr>
					<td class="key"><span class="editlinktip hasTip" title="<?php echo JText::_( 'Allow Pages Unload' );?>::<?php echo JText::_( 'Allow Pages Unload Description' ); ?>"><?php echo JText :: _('Allow Pages Unload'); ?></span></td>
					<td nowrap="nowrap"><?php echo JHTML::_( 'select.booleanlist', 'allow_pages_unload', 'class="inputbox"', $row->allow_pages_unload ); ?></td>
				</tr>
				<tr>
					<td class="key"><span class="editlinktip hasTip" title="<?php echo JText::_( 'First Page Number' );?>::<?php echo JText::_( 'First Page Number Description' ); ?>"><?php echo JText :: _('First Page Number'); ?></span></td>
					<td><input name="first_page" type="text" class="text_area" id="first_page" value="<?php echo $row->first_page; ?>" /></td>
				</tr>
				<tr>
					<td class="key"><span class="editlinktip hasTip" title="<?php echo JText::_( 'Flip Area' );?>::<?php echo JText::_( 'Flip Area Description' ); ?>"><?php echo JText :: _('Flip Area'); ?></span></td>
					<td><input name="auto_flip_size" type="text" class="text_area" id="auto_flip_size" value="<?php echo $row->auto_flip_size; ?>" /></td>
				</tr>
				<tr>
					<td class="key"><span class="editlinktip hasTip" title="<?php echo JText::_( 'Static Shadow Depth' );?>::<?php echo JText::_( 'Static Shadow Depth Description' ); ?>"><?php echo JText :: _('Static Shadow Depth'); ?></span></td>
					<td><input name="static_shadows_depth" type="text" class="text_area" id="static_shadows_depth" value="<?php echo $row->static_shadows_depth; ?>" /></td>
				</tr>
				<tr>
					<td class="key"><span class="editlinktip hasTip" title="<?php echo JText::_( 'Dynamic Shadow Depth' );?>::<?php echo JText::_( 'Dynamic Shadow Depth Description' ); ?>"><?php echo JText :: _('Dynamic Shadow Depth'); ?></span></td>
					<td><input name="dynamic_shadows_depth" type="text" class="text_area" id="dynamic_shadows_depth" value="<?php echo $row->dynamic_shadows_depth; ?>" /></td>
				</tr>
				<tr>
					<td class="key"><span class="editlinktip hasTip" title="<?php echo JText::_( 'Static Shadows Type' );?>::<?php echo JText::_( 'Static Shadows Type Description' ); ?>"><?php echo JText :: _('Static Shadows Type'); ?></span></td>
					<td><?php echo $lists['staticShadowsType']; ?></td>
				</tr>
				<tr>
					<td class="key"><span class="editlinktip hasTip" title="<?php echo JText::_( 'Flip Corner Style' );?>::<?php echo JText::_( 'Flip Corner Style Description' ); ?>"><?php echo JText :: _('Flip Corner Style'); ?></span></td>
					<td><?php echo $lists['flipCornerStyle']; ?></td>
				</tr>
			</table>
<script language="JavaScript" type="text/javascript">
function getScrollY() {
	var scrOfX = 0,scrOfY=0;
	if (typeof(window.pageYOffset) == 'number') {
		scrOfY=window.pageYOffset;
		scrOfX=window.pageXOffset;
	} else if(document.body&&(document.body.scrollLeft||document.body.scrollTop)) {
		scrOfY=document.body.scrollTop;
		scrOfX=document.body.scrollLeft;
	} else if(document.documentElement&&(document.documentElement.scrollLeft||document.documentElement.scrollTop)) {
		scrOfY=document.documentElement.scrollTop;scrOfX=document.documentElement.scrollLeft;
	} 
	return scrOfY;
}

document.write("<style>.colorpicker301{text-align:center;visibility:hidden;display:none;position:absolute;background-color:#FFF;border:solid 1px #CCC;padding:4px;z-index:999;filter:progid:DXImageTransform.Microsoft.Shadow(color=#D0D0D0,direction=135);}.o5582brd{border-bottom:solid 1px #DFDFDF;border-right:solid 1px #DFDFDF;padding:0;width:8px;height:8px;}a.o5582n66,.o5582n66,.o5582n66a{font-family:arial,tahoma,sans-serif;line-height: 7px;text-decoration:underline;font-size:10px;color:#666;border:none;}.o5582n66,.o5582n66a{text-align:center;line-height: 7px;text-decoration:none;}a:hover.o5582n66{text-decoration:none;line-height: 7px;color:#FFA500;cursor:pointer;}.a01p3{padding:1px 4px 1px 2px;background:whitesmoke;border:solid 1px #DFDFDF;}</style>");

function gett6op6() {
	csBrHt=0;
	if (typeof(window.innerWidth)=='number') {
			csBrHt=window.innerHeight;
	} else if(document.documentElement&&(document.documentElement.clientWidth||document.documentElement.clientHeight)) {
			csBrHt=document.documentElement.clientHeight;
	} else if(document.body&&(document.body.clientWidth||document.body.clientHeight)) {
			csBrHt=document.body.clientHeight;
	}
	ctop=((csBrHt/2)-132)+getScrollY();
	return ctop;
}

function getLeft6() {
	var csBrWt=0;
	if(typeof(window.innerWidth)=='number') {
		csBrWt=window.innerWidth;
	} else if (document.documentElement&&(document.documentElement.clientWidth||document.documentElement.clientHeight)) {
		csBrWt=document.documentElement.clientWidth;
	} else if (document.body&&(document.body.clientWidth||document.body.clientHeight)) {
		csBrWt=document.body.clientWidth;
	} 
	cleft=(csBrWt/2)-125;
	return cleft;
}

var nocol1="&#78;&#79;&#32;&#67;&#79;&#76;&#79;&#82;",
clos1="&#67;&#76;&#79;&#83;&#69;",
tt6="&#70;&#82;&#69;&#69;&#45;&#67;&#79;&#76;&#79;&#82;&#45;&#80;&#73;&#67;&#75;&#69;&#82;&#46;&#67;&#79;&#77;",
hm6="&#104;&#116;&#116;&#112;&#58;&#47;&#47;&#119;&#119;&#119;&#46;";
hm6+=tt6;
tt6="&#80;&#79;&#87;&#69;&#82;&#69;&#68;&#32;&#98;&#121;&#32;&#70;&#67;&#80;";

function setCCbldID6(objID,val) {
	document.getElementById(objID).value=val;
}

function setCCbldSty6(objID,prop,val) {
	switch(prop) {
		case "bc":
			if(objID!='none') {
				document.getElementById(objID).style.backgroundColor=val;
			}
		break;
		case "vs":
			document.getElementById(objID).style.visibility=val;
		break;
		case "ds":
			document.getElementById(objID).style.display=val;
		break;
		case "tp":
			document.getElementById(objID).style.top=val;
		break;
		case "lf":
			document.getElementById(objID).style.left=val;
		break;
	}
}

function putOBJxColor6(OBjElem,Samp,pigMent) {
	if( pigMent!='x') {
		setCCbldID6(OBjElem,pigMent);
		setCCbldSty6(Samp,'bc',pigMent);
	}
	setCCbldSty6('colorpicker301','vs','hidden');
	setCCbldSty6('colorpicker301','ds','none');
}

function colorSelector(OBjElem,Sam){
	var objX=new Array('00','33','66','99','CC','FF');
	var c=0;
	var z='"'+OBjElem+'","'+Sam+'",""';
	var xl='"'+OBjElem+'","'+Sam+'","x"';
	var mid='';
	mid+='<center><table bgcolor="#FFFFFF" border="0" cellpadding="0" cellspacing="0" style="border:solid 1px #F0F0F0;padding:2px;">';
	mid+="<tr><td colspan='18' align='center' style='margin:0;padding:2px;height:14px;' ><input class='o5582n66' type='text' size='10' id='o5582n66' value='FFFFFF'><input class='o5582n66a' type='text' size='2' style='width:14px;' id='o5582n66a' value='' style='border:solid 1px #666;'>&nbsp;&nbsp;&nbsp;<a class='o5582n66' href='javascript:onclick=putOBJxColor6("+xl+")'><span class='a01p3'>"+clos1+"</span></a></td></tr><tr>";
	var br=1;
	for (o=0;o<6;o++) {
		mid+='</tr><tr>';
		for(y=0;y<6;y++) {
			if(y==3) {
				mid+='</tr><tr>';
			}
			for(x=0;x<6;x++) {
				var grid='';
				grid=objX[o]+objX[y]+objX[x];
				var b="'"+OBjElem+"', '"+Sam+"','"+grid+"'";
				mid+='<td class="o5582brd" style="background-color:#'+grid+'"><a class="o5582n66" href="javascript:onclick=putOBJxColor6('+b+');" onmouseover=javascript:document.getElementById("o5582n66").value="'+grid+'";javascript:document.getElementById("o5582n66a").style.backgroundColor="#'+grid+'"; title="'+grid+'"><div style="width:8px;height:8px;"></div></a></td>';
				c++;
			}
		}
	}
	mid+='</tr></table>';
	var objX=new Array('0','3','6','9','C','F');
	var c=0;
	var z='"'+OBjElem+'","'+Sam+'",""';
	var xl='"'+OBjElem+'","'+Sam+'","x"';
	mid+='<table bgcolor="#FFFFFF" border="0" cellpadding="0" cellspacing="0" style="border:solid 1px #F0F0F0;padding:1px;"><tr>';
	var br=0;
	for(y=0;y<6;y++) {
		for(x=0;x<6;x++) {
			if(br==18) {
				br=0;mid+='</tr><tr>';
			}
			br++;
			var grid='';
			grid=objX[y]+objX[x]+objX[y]+objX[x]+objX[y]+objX[x];
			var b="'"+OBjElem+"', '"+Sam+"','"+grid+"'";
			mid+='<td class="o5582brd" style="background-color:#'+grid+'"><a class="o5582n66" href="javascript:onclick=putOBJxColor6('+b+');" onmouseover=javascript:document.getElementById("o5582n66").value="'+grid+'";javascript:document.getElementById("o5582n66a").style.backgroundColor="#'+grid+'"; title="'+grid+'"><div style="width:8px;height:8px;"></div></a></td>';
			c++;
		}
	}
	mid+="</tr>";
	mid+='</table></center>';
	setCCbldSty6('colorpicker301','tp','100px');
	document.getElementById('colorpicker301').style.top=gett6op6();
	document.getElementById('colorpicker301').style.left=getLeft6();
	setCCbldSty6('colorpicker301','vs','visible');
	setCCbldSty6('colorpicker301','ds','block');
	document.getElementById('colorpicker301').innerHTML=mid;
}
</script>
<div id="colorpicker301" class="colorpicker301"></div>

<?php
echo $pane->endPanel();
echo $pane->endPane();
?>
		</td>
	</tr>
</table>
		<input type="hidden" name="created" value="<?php echo $row->created;?>" />
		<input type="hidden" name="task" value="" />
		<input type="hidden" name="option" value="com_flippingbook" />
		<input type="hidden" name="id" value="<?php echo $row->id; ?>" />
		<input type="hidden" name="cid[]" value="<?php echo $row->id; ?>" />
</form>
		<?php
	}
}
?>