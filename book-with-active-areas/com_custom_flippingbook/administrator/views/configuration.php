<?php
/**********************************************
* 	FlippingBook Gallery Component.
*	© Mediaparts Interactive. All rights reserved.
* 	Released under Commercial License.
*	www.page-flip-tools.com
**********************************************/
defined( '_JEXEC' ) or die( 'Restricted access' );

class Config {
	function Configuration( $FlippingBook_config, $lists ) {
	global $option;
	JHTML::_('behavior.tooltip');
?>
<script language="javascript" type="text/javascript">
	function submitbutton(pressbutton) {
		submitform( pressbutton );
	}
	
	function resetConfiguration() {
		var printTitle = document.getElementById('printTitle');
		printTitle.value = 'Print pages';
		var downloadComplete = document.getElementById('downloadComplete');
		downloadComplete.value = 'Complete';
		var zoomHint = document.getElementById('zoomHint');
		zoomHint.value = 'Double click for zooming';
		var rigidPageSpeed = document.getElementById('rigidPageSpeed');
		rigidPageSpeed.value = '5';
		var closeSpeed = document.getElementById('closeSpeed');
		closeSpeed.value = '3';
		var moveSpeed = document.getElementById('moveSpeed');
		moveSpeed.value = '2';
		var gotoSpeed = document.getElementById('gotoSpeed');
		gotoSpeed.value = '3';
		var zoomOnClick1 = document.getElementById('zoomOnClick1');
		zoomOnClick1.checked = true;
		var dropShadowEnabled1 = document.getElementById('dropShadowEnabled1');
		dropShadowEnabled1.checked = true;
		var categoryListTitle = document.getElementById('categoryListTitle');
		categoryListTitle.value = 'FlippingBook Categories';
		var printIcon1 = document.getElementById('printIcon1');
		printIcon1.checked = true;
		var emailIcon1 = document.getElementById('emailIcon1');
		emailIcon1.checked = true;
	}
</script>
<form action="index.php?option=com_flippingbook" method="post" name="adminForm">
	<table width="100%" class="adminform">
		<tr valign="middle">
			<td width="50%" valign="top" nowrap="nowrap">
				<fieldset class="adminform">
					<legend><?php echo JText::_( 'Interface Settings' ); ?></legend>
					<table class="admintable">
						<tr>
							<td class="key"><span class="editlinktip hasTip" title="<?php echo JText::_( 'Theme' );?>::<?php echo JText::_( 'Theme Description' ); ?>"><?php echo JText::_( 'Theme' ); ?></span></td>
							<td><?php echo $lists['themes_list']; ?></td>
						</tr>
						<tr>
                          <td class="key"><span class="editlinktip hasTip" title="<?php echo JText::_( 'Preloader Type' );?>::<?php echo JText::_( 'Preloader Type Description' ); ?>"><?php echo JText::_( 'Preloader Type' ); ?></span></td>
						  <td><?php echo $lists['preloader']; ?></td>
					  </tr>
						<tr>
                          <td class="key"><span class="editlinktip hasTip" title="<?php echo JText::_( 'Page Flip Sound' );?>::<?php echo JText::_( 'Page Flip Sound Description' ); ?>"><?php echo JText::_( 'Page Flip Sound' ); ?></span></td>
						  <td><?php echo $lists['pageFlipSound']; ?></td>
						</tr>
						<tr>
                          <td class="key"><span class="editlinktip hasTip" title="<?php echo JText::_( 'Hard Cover Flip Sound' );?>::<?php echo JText::_( 'Hard Cover Flip Sound Description' ); ?>"><?php echo JText::_( 'Hard Cover Flip Sound' ); ?></span></td>
						  <td><?php echo $lists['hardcoverFlipSound']; ?></td>
						</tr>
						<tr>
							<td class="key"><span class="editlinktip hasTip" title="<?php echo JText::_( 'Print Title' );?>::<?php echo JText::_( 'Print Title Description' ); ?>"><?php echo JText::_( 'Print Title' ); ?></span></td>
							<td><input name="printTitle" type="text" id="printTitle" value="<?php echo htmlspecialchars ( urldecode ( $FlippingBook_config->printTitle )); ?>" style="width:200px;" /></td>
						</tr>
						<tr>
							<td class="key"><span class="editlinktip hasTip" title="<?php echo JText::_( 'Download Complete' );?>::<?php echo JText::_( 'Download Complete Description' ); ?>"><?php echo JText::_( 'Download Complete' ); ?></span></td>
							<td><input name="downloadComplete" type="text" id="downloadComplete" value="<?php echo htmlspecialchars ( urldecode ( $FlippingBook_config->downloadComplete )); ?>" style="width:200px;" /></td>
						</tr>
						<tr>
							<td class="key"><span class="editlinktip hasTip" title="<?php echo JText::_( 'Zoom Hint' );?>::<?php echo JText::_( 'Zoom Hint Description' ); ?>"><?php echo JText::_( 'Zoom Hint' ); ?></span></td>
							<td><input name="zoomHint" type="text" id="zoomHint" value="<?php echo htmlspecialchars ( urldecode ( $FlippingBook_config->zoomHint )); ?>" style="width:200px;" /></td>
						</tr>
						<tr>
							<td class="key"><span class="editlinktip hasTip" title="<?php echo JText::_( 'Rigid Page Speed' );?>::<?php echo JText::_( 'Rigid Page Speed Description' ); ?>"><?php echo JText::_( 'Rigid Page Speed' ); ?></span></td>
							<td><input name="rigidPageSpeed" type="text" id="rigidPageSpeed" maxlength="4" value="<?php echo $FlippingBook_config->rigidPageSpeed; ?>" style="width:50px;"/></td>
						</tr>
						<tr>
							<td class="key"><span class="editlinktip hasTip" title="<?php echo JText::_( 'Flip Speed' );?>::<?php echo JText::_( 'Flip Speed Description' ); ?>"><?php echo JText::_( 'Flip Speed' ); ?></span></td>
							<td><input name="closeSpeed" type="text" id="closeSpeed" maxlength="4" value="<?php echo $FlippingBook_config->closeSpeed; ?>" style="width:50px;"/></td>
						</tr>
						<tr>
							<td class="key"><span class="editlinktip hasTip" title="<?php echo JText::_( 'Move Speed' );?>::<?php echo JText::_( 'Move Speed Description' ); ?>"><?php echo JText::_( 'Move Speed' ); ?></span></td>
							<td><input name="moveSpeed" type="text" id="moveSpeed" maxlength="4" value="<?php echo $FlippingBook_config->moveSpeed; ?>" style="width:50px;"/></td>
						</tr>
						<tr>
							<td class="key"><span class="editlinktip hasTip" title="<?php echo JText::_( 'Go To Speed' );?>::<?php echo JText::_( 'Go To Speed Description' ); ?>"><?php echo JText::_( 'Go To Speed' ); ?></span></td>
							<td><input name="gotoSpeed" type="text" id="gotoSpeed" maxlength="4" value="<?php echo $FlippingBook_config->gotoSpeed; ?>" style="width:50px;"/></td>
						</tr>
						<tr>
							<td class="key"><span class="editlinktip hasTip" title="<?php echo JText::_( 'Zoom On Double Click' );?>::<?php echo JText::_( 'Zoom On Double Click Description' ); ?>"><?php echo JText::_( 'Zoom On Double Click' ); ?></span></td>
							<td><?php echo JHTML::_( 'select.booleanlist', 'zoomOnClick', 'class="inputbox"', $FlippingBook_config->zoomOnClick ); ?></td>
						</tr>
						<tr>
							<td class="key"><span class="editlinktip hasTip" title="<?php echo JText::_( 'Drop Shadow Enabled' );?>::<?php echo JText::_( 'Drop Shadow Enabled Description' ); ?>"><?php echo JText::_( 'Drop Shadow Enabled' ); ?></span></td>
							<td><?php echo JHTML::_( 'select.booleanlist', 'dropShadowEnabled', 'class="inputbox"', $FlippingBook_config->dropShadowEnabled ); ?></td>
						</tr>
						<tr>
							<td></td>
							<td height="30" valign="bottom"><input type="button" name="Button" value="<?php echo JText::_( 'Restore default settings' );?>" onclick="resetConfiguration();" /></td>
						</tr>
					</table> 
				</fieldset>							</td>
		    <td width="50%" valign="top" nowrap="nowrap"><fieldset class="adminform">
					<legend><?php echo JText::_( 'Category List' ); ?></legend>
					<table class="admintable">
						<tr>
							<td class="key"><span class="editlinktip hasTip" title="<?php echo JText::_( 'Category List Title' );?>::<?php echo JText::_( 'CATEGORY LIST TITLE DESCRIPTION' ); ?>"><?php echo JText::_( 'Category List Title' ); ?></span></td>
							<td><input name="categoryListTitle" type="text" id="categoryListTitle" maxlength="254" value="<?php echo htmlspecialchars ( urldecode ( $FlippingBook_config->categoryListTitle )); ?>" style="width:200px;" /></td>
					    </tr>
						<tr>
							<td class="key"><span class="editlinktip hasTip" title="<?php echo JText::_( 'Columns In Category List' );?>::<?php echo JText::_( 'COLUMNS IN CATEGORY LIST DESCRIPTION' ); ?>"><?php echo JText::_( 'Columns In Category List' ); ?></span></td>
							<td><?php echo $lists['columns']; ?></td>
					    </tr>
						<tr>
						  <td class="key"><?php echo JText::_( 'Print Icon' ); ?></td>
							<td><?php echo JHTML::_( 'select.booleanlist', 'printIcon', 'class="inputbox"', $FlippingBook_config->printIcon ); ?></td>
			          </tr>
						<tr>
						  <td class="key"><?php echo JText::_( 'Email Icon' ); ?></td>
							<td><?php echo JHTML::_( 'select.booleanlist', 'emailIcon', 'class="inputbox"', $FlippingBook_config->emailIcon ); ?></td>
			          </tr>
					</table>
				</fieldset>
			</td>
		</tr>
		<tr valign="middle">
		  <td colspan="2" valign="top" nowrap="nowrap"></td>
	  </tr>
	</table>
	<input type="hidden" name="option" value="<?php echo $option; ?>" />
	<input type="hidden" name="task" value="" />
</form>
<?php
	}
}
?>
