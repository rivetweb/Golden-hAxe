<?php
/**********************************************
* 	FlippingBook Gallery Component.
*	© Mediaparts Interactive. All rights reserved.
* 	Released under Commercial License.
*	www.page-flip-tools.com
**********************************************/
defined( '_JEXEC' ) or die( 'Restricted access' );

class FileManager {
	function fileManagerInterface( $report ) {
?>
<script language="JavaScript" type="text/javascript">
function addFile(what) {
	if(document.getElementById) {
		tr = what;
		while (tr.tagName != 'TR') tr = tr.parentNode;
		tr = tr.previousSibling;
		var newTr = tr.parentNode.insertBefore(tr.cloneNode(true),tr.nextSibling);
		checkForLast();
		checkForMax();
	}
}
function show (what) {
	what.style.display = "block";
}

function hide (what) {
	what.style.display = "none";
}

function checkForMax(){
	btnsminus_f = document.getElementsByName('minus_f');
	document.getElementsByName('plus_f')[0].disabled = (btnsminus_f.length > 4) ? true : false;
}

function checkForLast(){
	btnsminus_f = document.getElementsByName('minus_f');
	for (i = 0; i < btnsminus_f.length; i++){
		btnsminus_f[i].className = "addfile";
		if (btnsminus_f.length > 1){
			btnsminus_f[i].disabled = false;
			show(btnsminus_f[i]);
		}
		else{
			btnsminus_f[i].disabled = true;
			hide(btnsminus_f[i]);
		}
	}
	btnsminus_l = document.getElementsByName('minus_l');
	for (i = 0; i < btnsminus_l.length; i++){
		btnsminus_l[i].className = "addfile";
		if (btnsminus_l.length > 1){
			btnsminus_l[i].disabled = false;
			show(btnsminus_l[i]);
		}
		else{
			btnsminus_l[i].disabled = true;
			hide(btnsminus_l[i]);
		}
	}
}

function dropFile(what){
	tr = what;
	while (tr.tagName != 'TR') tr = tr.parentNode;
	tr.parentNode.removeChild(tr);
	checkForLast();
	checkForMax();
}

</script>
<form action="index.php?option=com_flippingbook&task=file_manager" method="post" name="adminForm" enctype="multipart/form-data">
<?php echo $report; ?>
<fieldset class="adminform">
	<legend><?php echo JText::_( 'Upload Files' ); ?></legend>
	<table border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="30%" valign="top">
				<table border="0" cellpadding="0" cellspacing="0" class="middle_form">
					<tr height="30">
						<td valign="top">
							<input type="hidden" name="MAX_FILE_SIZE" value="16777216">
							<input type="file" name="upload[]" size="50">
						</td>
						<td width="50" align="center" valign="top">
							<input type="button" name="minus_f" value="&#8212;" onClick="dropFile(this);" class="addfile" style="display: none;">
						</td>
					</tr><tr height="30">
						<td colspan="2" valign="top">
							<input type="button"  name="plus_f" value="<?php echo JText::_( 'add field' ); ?>" onClick="addFile(this);" class="addfile">
						</td>
					</tr>
				</table>
			</td>
			<td valign="top">&nbsp;&nbsp;&nbsp;
				<input name="submit" type="submit" value="<?php echo JText::_( 'Upload' ); ?>" />
			</td>
		</tr>
	</table>
	<?php echo JText::_( 'To ensure full compatibility, we recommend that you only use Latin characters and numerals in files and folders names.' ); ?>
</fieldset>
<?php
	if (JRequest::getVar( 'folder', '', '', 'string' ))
		$folder = JRequest::getVar( 'folder', '', '', 'string' );
	else 
		$folder = DS . 'images'. DS . 'flippingbook';
		
	if (substr($folder, 0, 20) != DS . 'images'. DS . 'fli'.'pping'.'book' )
		$folder = DS . 'images'. DS . 'flippingbook';
	
	$path = JPATH_SITE . $folder;
	$allFiles = array(null);
	$filter='.';
	$recurse=false;
	$fullpath=false;
	// Get the files and folders
	jimport('joomla.filesystem.folder');
	$files = JFolder::files($path, $filter, $recurse, $fullpath);
	$folders = JFolder::folders($path, $filter, $recurse, $fullpath);

	
?>
<fieldset class="adminform">
	<legend><?php echo JText::_( 'Current folder' ); ?>: <?php echo $folder; ?></legend>
	<table width="100%" class="adminlist">
	
		<tr>
			<td nowrap="nowrap" style="font-size:120%" colspan="4">
<?php if (JRequest::getVar( 'folder', '', '', 'string' )) { ?>
				<a href="index.php?option=com_flippingbook&task=file_manager"><?php echo JText::_( 'Go To the Root Folder' ); ?></a>&nbsp;&nbsp;&nbsp;
<?php } ?>
				<a href="index.php?option=com_flippingbook&task=create_folder&folder=<?php echo $folder; ?>"><?php echo JText::_( 'Create a new folder' ); ?></a>
			</td>
		</tr>

		<tr>
			<th width="150" align="left"><?php echo JText::_( 'Name' ); ?></th>
			<th width="90" align="left"><?php echo JText::_( 'Size' ); ?></th>
			<th width="100" align="center" colspan="2"><?php echo JText::_( 'Action' ); ?></th>
		</tr>
<?php
	$folders = JFolder::listFolderTree (JPATH_ROOT . DS . $folder, '', 10);
	if (count($folders) > 0) {
		foreach ($folders as $folders_) {
		$relname = str_replace (DS . 'images'. DS . 'flippingbook' . DS, '', $folders_["relname"]);
?>
	<tr>
		<td nowrap="nowrap" style="font-size:120%"><a href="index.php?option=com_flippingbook&task=file_manager&folder=<?php echo $folders_["relname"]; ?>"><?php echo $folders_["relname"]; ?></a></td>
		<td align="left">&mdash;</td>
		<td width="100"><a href="index.php?option=com_flippingbook&task=rename_folder&folder_to_rename=<?php echo $relname; ?>&folder=<?php echo $folder; ?>"><?php echo JText::_( 'Rename' ); ?></a></td>
		<td width="100"><a href="index.php?option=com_flippingbook&task=delete_folder&folder_to_delete=<?php echo $relname; ?>&folder=<?php echo $folder; ?>"><?php echo JText::_( 'Delete' ); ?></a></td>
	</tr>
<?php
		}
	}
	$i = 0;
	foreach ($files as $file) {
?>
		<tr>
			<td nowrap="nowrap"><?php echo $file; ?></td>
			<td align="left"><?php 
		$fb_filesize = filesize($path . DS . $file);
		echo number_format($fb_filesize, 0, ' ', ' '); ?></td>
			<td width="100"><a href="index2.php?option=com_flippingbook&task=rename_file&file_to_rename=<?php echo $file; ?>&folder=<?php echo $folder; ?>"><?php echo JText::_( 'Rename' ); ?></a></td>
			<td width="100"><a href="index2.php?option=com_flippingbook&task=delete_file&file_to_delete=<?php echo $file; ?>&folder=<?php echo $folder; ?>"><?php echo JText::_( 'Delete' ); ?></a></td>
		</tr>
<?php
		$i++;
	} ?>
	</table>
</fieldset>
<input type="hidden" name="option" value="com_flippingbook" />
<input type="hidden" name="task" value="upload_file" />
<input type="hidden" name="boxchecked" value="0" />
<input type="hidden" name="folder" value="<?php echo JRequest::getVar( 'folder', '', '', 'string' ); ?>" />
</form>
<?php
	}
	
	function renameFileForm ( $file ) {
?>
<fieldset class="adminform"><legend><?php echo JText::_( 'Rename File' ); ?>:</legend>
	<form action="index.php?option=com_flippingbook&task=rename_file" method="post" name="adminForm">
		<table>
			<tr>
				<td><?php echo JText::_( 'Old file name' ); ?>:</td>
				<td><?php echo $file; ?></td>
			</tr>
			<tr>
				<td><?php echo JText::_( 'New file name' ); ?>:</td>
				<td><input name="new_file_name" type="text" value="<?php echo $file; ?>" style="width: 200px;" /></td>
			</tr>
		</table>
		<input name="old_file_name" type="hidden" value="<?php echo $file; ?>" />
		<input name="submit" type="submit" value="<?php echo JText::_( 'Save' ); ?>" />
		<input type="hidden" name="option" value="com_flippingbook" />
		<input name="save_renamed" type="hidden" value="1" />
		<input type="hidden" name="task" value="rename_file" />
		<input type="hidden" name="folder" value="<?php echo JRequest::getVar( 'folder', '', '', 'string' ); ?>" />
	</form>
</fieldset>
<?php
	}
	
	function renameFolderForm ( $folder ) {
?>
<fieldset class="adminform"><legend><?php echo JText::_( 'Rename Folder' ); ?>:</legend>
	<form action="index.php?option=com_flippingbook&task=rename_folder" method="post" name="adminForm">
		<table>
			<tr>
				<td><strong style="color:red"><?php echo JText::_( 'Make sure that folder doesn\'t contain linked files' ); ?></strong></td>
			</tr>
			<tr>
				<td><?php echo JText::_( 'Old name' ); ?>: <?php echo DS . 'images'. DS . 'flippingbook' . DS . $folder; ?></td>
			</tr>
			<tr>
				<td><?php echo JText::_( 'New name' ); ?>: <?php echo DS . 'images'. DS . 'flippingbook' . DS; ?> <input name="new_folder_name" type="text" value="<?php echo $folder; ?>" style="width: 200px;" /></td>
			</tr>
		</table>
		<input name="old_folder_name" type="hidden" value="<?php echo $folder; ?>" />
		<input name="submit" type="submit" value="<?php echo JText::_( 'Save' ); ?>" />
		<input type="hidden" name="option" value="com_flippingbook" />
		<input name="save_renamed_folder" type="hidden" value="1" />
		<input type="hidden" name="task" value="rename_folder" />
		<input type="hidden" name="folder" value="<?php echo JRequest::getVar( 'folder', '', '', 'string' ); ?>" />
	</form>
</fieldset>
<?php
	}
	
	function createFolderForm ( $folder ) {
?>
<fieldset class="adminform"><legend><?php echo JText::_( 'Create a new folder' ); ?>:</legend>
	<form action="index.php?option=com_flippingbook&task=create_folder" method="post" name="adminForm">
		<table>
			<tr>
				<td><?php echo JText::_( 'New folder name' ); ?>: <input name="folder_name" type="text" value="new_folder" style="width: 200px;" /></td>
			</tr>
		</table>
		<input name="submit" type="submit" value="<?php echo JText::_( 'Save' ); ?>" />
		<input type="hidden" name="option" value="com_flippingbook" />
		<input type="hidden" name="save_folder" value="1" />
		<input type="hidden" name="task" value="create_folder" />
		<input type="hidden" name="folder" value="<?php echo $folder; ?>" />
	</form>
</fieldset>
<?php
	}
}
?>
