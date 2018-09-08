<?php
/**********************************************
* 	FlippingBook Gallery Component.
*	� Mediaparts Interactive. All rights reserved.
* 	Released under Commercial License.
*	www.page-flip-tools.com
**********************************************/
defined( '_JEXEC' ) or die( 'Restricted access' );

class BatchAddPages {
	function form($lists)	{
		JHTML::_('behavior.tooltip');

?>
<script language="javascript" type="text/javascript">
	function submitbutton(pressbutton) {
		var form = document.adminForm;
		if (pressbutton == 'cancel_configuration') {
			submitform( pressbutton );
			return;
		}
		// do field validation

		if (pressbutton == 'batch_add_pages_execute') {
			if ((form.method.value == "advanced")&&((form.prefix_page.value == "")||(form.prefix_zoom.value == ""))) {
				alert( "<?php echo JText::_( 'Enter the prefix fields values', true ); ?>" );
				return;
			} else {
				submitform( pressbutton );
			}
		} else {
			submitform( pressbutton );
		}
	}
</script>
<form action="index.php" method="post" name="adminForm">
	<table class="admintable" width="100%">
		<tr>
			<th>Batch Add Pages</th>
			<th></th>
		<tr>
			<td class="key"><label for="title"><?php echo JText::_( 'Book' ); ?></label></td>
			<td><?php echo $lists['books']; ?></td>
		</tr>
		<tr>
			<td class="key"><label for="title"><?php echo JText::_( 'Folder' ); ?></label></td>
			<td><?php echo $lists['folders']; ?></td>
		</tr>
		<tr>
			<td class="key"><label for="title"><?php echo JText::_( 'Mode' ); ?></label></td>
			<td><?php echo $lists['method']; ?></td>
		</tr>
		<tr>
			<td colspan="2">
				<fieldset class="adminform"><legend><?php echo JText::_( 'Advanced Mode' ); ?></legend>
					<table class="admintable" width="100%">	
						<tr>
							<td class="key"><span class="editlinktip hasTip" title="<?php echo JText::_( 'Prefix For Pages Images' );?>::<?php echo JText::_( 'Prefix For Pages Images Description' ); ?>"><?php echo JText::_( 'Prefix For Pages Images' ); ?></span></td>
							<td><input class="inputbox" type="text" name="prefix_page" id="prefix_page" size="30" value="my-book_" /></td>
							<td rowspan="6" valign="top"><img src="components/com_flippingbook/images/batch_help.gif" /></td>
						</tr>
						<tr>
							<td class="key"><span class="editlinktip hasTip" title="<?php echo JText::_( 'Prefix For Zoomed Images' );?>::<?php echo JText::_( 'Prefix For Zoomed Images Description' ); ?>"><?php echo JText::_( 'Prefix For Zoomed Images' ); ?></span></td>
							<td><input class="inputbox" type="text" name="prefix_zoom" id="prefix_zoom" size="30" value="zoom_" /></td>
						</tr>
						<tr>
							<td>Ширина<br><input class="inputbox" type="text"
								name="scale_width" id="scale_width" size="30" value="250" /></td>
							<td>Высота<br><input class="inputbox" type="text"
								name="scale_height" id="scale_height" size="30" value="360" /></td>
						</tr>
					</table>
				</fieldset>
			</td>
		</tr>
	</table>
<script language="javascript" type="text/javascript">
var prefix_page_obj = document.getElementById("prefix_page");
var prefix_zoom_obj = document.getElementById("prefix_zoom");
var method_obj = document.getElementById("method");
function check_method() {
	if (method_obj.selectedIndex == 0) {
		prefix_page_obj.disabled = true;
		prefix_zoom_obj.disabled = true;
	} else {
		prefix_page_obj.disabled = false;
		prefix_zoom_obj.disabled = false;
	}
}
check_method();
</script>
		<input type="hidden" name="task" value="batch_add_pages" />
		<input type="hidden" name="option" value="com_flippingbook" />
</form>
<?php
	}
	
	function perform($vars, $files) {

	}
}
?>
