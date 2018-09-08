<?php
/**********************************************
* 	FlippingBook Gallery Component.
*	© Mediaparts Interactive. All rights reserved.
* 	Released under Commercial License.
*	www.page-flip-tools.com
**********************************************/
defined( '_JEXEC' ) or die( 'Restricted access' );

class PageManager {
	function showPages( &$rows, &$pageNav, $option, &$lists ) {
		$user =& JFactory::getUser();
		$ordering = ($lists['order'] == 'm.book_id' || $lists['order'] == 'b.title');
		JHTML::_('behavior.tooltip');
		?>
		<form action="index.php?option=com_flippingbook" method="post" name="adminForm">
			<table width="100%">
				<tr>
					<td align="left">
						<?php echo JText::_( 'Filter (File, Link URL, Zoom file)' ); ?>:
						<input type="text" name="search" id="search" value="<?php echo $lists['search'];?>" class="text_area" onchange="document.adminForm.submit();" />
						<button onclick="this.form.submit();"><?php echo JText::_( 'Go' ); ?></button>
						<button onclick="document.getElementById('search').value='';this.form.submit();"><?php echo JText::_( 'Reset' ); ?></button></td>
					<td align="center" nowrap="nowrap">
						<?php echo JText::_( 'Book Filter' ); ?>:<?php
						echo $lists['book'];
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
						<th width="1%" nowrap="NOWRAP"><?php echo JHTML::_('grid.sort', 'ID', 'm.id', @$lists['order_Dir'], @$lists['order'], 'page_manager' ); ?></th>
						<th nowrap="nowrap" class="title"><?php echo JHTML::_('grid.sort', 'File', 'm.file', @$lists['order_Dir'], @$lists['order'], 'page_manager' ); ?></th>
						<th align="center" nowrap="nowrap"><?php echo JHTML::_('grid.sort', 'Book ID', 'm.book_id', @$lists['order_Dir'], @$lists['order'], 'page_manager' ); ?></th>
						<th align="center" nowrap="nowrap"><?php echo JHTML::_('grid.sort', 'Book Title', 'b.title', @$lists['order_Dir'], @$lists['order'], 'page_manager' ); ?></th>
						<th align="center" nowrap="nowrap"><?php echo JHTML::_('grid.sort', 'Published', 'm.published', @$lists['order_Dir'], @$lists['order'], 'page_manager' ); ?></th>
						<th align="center" nowrap="nowrap"><?php echo JHTML::_('grid.sort', 'Link URL', 'm.link_url', @$lists['order_Dir'], @$lists['order'], 'page_manager' ); ?></th>
						<th align="center" nowrap="nowrap"><?php echo JHTML::_('grid.sort', 'Zoom file', 'm.zoom_url', @$lists['order_Dir'], @$lists['order'], 'page_manager' ); ?></th>
						<th colspan="3" nowrap="NOWRAP"><?php echo JHTML::_('grid.sort', 'Ordering', 'm.ordering', @$lists['order_Dir'], @$lists['order'], 'page_manager' ); ?><?php echo JHTML::_('grid.order', $rows, 'filesave.png', 'savepageorder' ); ?></th>
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

				$link 		= 'index.php?option=com_flippingbook&task=edit_page&cid[]='. $row->id ;

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
						<a href="<?php echo JRoute::_( $link ); ?>" title="<?php echo JText::_( 'Edit Page' ); ?>"><?php echo $row->file; ?></a>
					<?php }	?></td>
					<td width="1%" align="center"><?php echo $row->book_id;?></td>
					<td align="left"><?php echo $row->title;?></td>
					<td align="center"><?php echo $published;?></td>
					<td align="center"><?php echo $row->link_url;?></td>
					<td><?php echo $row->zoom_url; ?></td>
					<td width="1%" align="center"><?php echo $pageNav->orderUpIcon( $i, ($row->book_id == @$rows[$i-1]->book_id) , 'orderup_page', 'Move Up', $ordering); ?></td>
					<td width="1%" align="center"><?php echo $pageNav->orderDownIcon( $i, $n, ($row->book_id == @$rows[$i+1]->book_id), 'orderdown_page', 'Move Down', $ordering ); ?></td>
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
		<input type="hidden" name="task" value="page_manager" />
		<input type="hidden" name="section" value="page_manager" />
		<input type="hidden" name="boxchecked" value="0" />
		<input type="hidden" name="filter_order" value="<?php echo $lists['order']; ?>" />
		<input type="hidden" name="filter_order_Dir" value="" />
		</form>
		<?php
	}

	function image_selection_box($file = ""){ ?>

	<!-- image selection block -->

	<table width="100%"><tr><td>
	<div style="float:left; margin-right:15px;">
	<img id="ladybug" src="<?=$file?>" >

	</div>

	<div style="float:left; margin-right:15px;">
	<select id="items_coord" size="15">
	<option disabled>--------------------</option>
	</select>

	<p>
	<form action="" method="post">
	 <input type="hidden" id="x1" name="x1" value="82" >
	 <input type="hidden" id="y1" name="y1" value="50" >
	 <input type="hidden" id="x2" name="x2" value="219">
	 <input type="hidden" id="y2" name="y2" value="121">

	 <input  id="bAdd" name="bAdd" value="Добавить область" type="button"><p>
	 <input id="bDel" name="bDel" value="Удалить область" type="button"><p>
	 <!--input id="bSave" name="bSave" value="Сохранить области" type="button"><p-->
	 <p>&nbsp;</p>
		<!--input id="bGen" name="bGen" value="Сгенерировать" type="button"><p-->
		<input id="bRemove" name="bSave" value="Удалить SWF-страницу" type="button">
	</form>
	</div>

	<div style="float:left; margin-right:15px;">
		<input id="imgsel_art" name="imgsel_art" value="Артикул..."
			onfocus="this.value='';">&nbsp;<input
			id="bFilter" name="bFilter" type="button" value="Отфильтровать">&nbsp;<input
			id="bFilterReset" name="bFilterReset" type="button" value="Сбросить"><br><br>
		<select id="imgsel_categs_id" size="15">
		</select>
	</div>

	<div style="float:left; margin-right:15px;">
		<select id="imgsel_products_id" size="15">
			<option value="" disabled>----------</option>
		</select>
	</div>

	</td>
	</tr>
	</table>
	
		<? }

	function image_selection_box_script(){ ?>

	<!-- image selection block script -->
	
<script type="text/javascript">

(function($){

var image_selection_box = function(){

	var ias;

	var images_path = "/images/flippingbook/";

	//init image selection box
	/*
	 if($('#file')[0].selectedIndex > 0)
		$('#ladybug').attr("src",
			images_path + $('#file')[0].options[$('#file')[0].selectedIndex].value);
	*/

	var check_active = function(){
		return $('#items_coord')[0].selectedIndex > 0;
			// && $('#imgsel_categs_id option:selected').val() != "";
	};

	var make_s = function(selection, prod, attr){
		var s = attr || $('#imgsel_products_id option:selected').val();
		if(!s)
			s = '';
		return [
			selection.x1, selection.y1, selection.x2, selection.y2,
			prod || $('#imgsel_categs_id option:selected').val(),
			"'"+s+"'"
		].join(",");
	};

	var update_s = function(selection){
		var o=$('#items_coord')[0].options[$('#items_coord')[0].selectedIndex];
		o.value = make_s(selection);
		o.text = 'item: {'+make_s(selection)+'}';
	}

	$('#ladybug').imgAreaSelect({
		onSelectEnd: function(img, selection) {
			//init region coords
			/*
			$('input[name=x1]').val(selection.x1);
			$('input[name=y1]').val(selection.y1);
			$('input[name=x2]').val(selection.x2);
			$('input[name=y2]').val(selection.y2);
			*/
			if(check_active())
				update_s(selection);
		}
	});

	//instance of image selection box
	ias = $('#ladybug').imgAreaSelect({ instance: true });

	//load current item coords
	$.getJSON(
		"/administrator/index.php?option=com_flippingbook&task=get_imageinfo&cid="+
			$("input[name=cid\\[\\]]").val()+
			"&ts="+new Date().getTime(),
		function(data){
			//alert(data);
			$.each(data, function(i, n){
				var selection = {'x1': n[0], 'y1': n[1], 'x2': n[2], 'y2': n[3]};
				$('#items_coord').append(
					'<option value="'+make_s(selection, n[4]+','+n[5], n[6])+
						'">item: {'+make_s(selection, n[4]+','+n[5], n[6])+'}</option>');
			});
		});

	//display current region from select list
	$('#items_coord').change(function() {
		var coo = this.value.split(",");
		ias.setSelection(coo[0], coo[1], coo[2], coo[3], true);
		ias.setOptions({ show: true });
		ias.update();

		var prod = coo[4]+','+coo[5];
		var attr = coo[6];

		$('#imgsel_categs_id option').each(function(i, n){
			if (n.value == prod){
				$('#imgsel_categs_id')[0].selectedIndex = i;

				$.get(
					'/administrator/index.php?option=com_flippingbook&task=get_prodattr&product_id='+
					$('#imgsel_categs_id option:selected').val().split(",")[1]+
					"&ts="+new Date().getTime(),
					function(data){
						$('#imgsel_products_id').html(data);
						//var f = 0;
						$('#imgsel_products_id option').each(function(j, m){
							if (("'"+m.value+"'") == attr){
								//f++;
								$('#imgsel_products_id')[0].selectedIndex = j;
							}
						});
						//if (f == 0)
						//	update_s();
					}
				);
			}
		});
	});

	//append new region to select list
  $('#bAdd').click(function(){
	  //save for select list
		var selection = ias.getSelection();

		//alert(
		// '<option value="'+make_s(selection)+'">item: {'+make_s(selection)+'}</option>'
		//);

		$('#items_coord').append(
			'<option value="'+make_s(selection)+'">item: {'+make_s(selection)+'}</option>');
	});

	//delete region from select list
  $('#bDel').click(function(){
		if($('#items_coord')[0].selectedIndex > 0){
			$('#items_coord')[0].remove($('#items_coord')[0].selectedIndex);
			ias.setSelection(0, 0, 10, 10, true);
			ias.setOptions({ show: true });
			ias.update();
		}
	});

	//change src image for image selection box
	$('#file').change(function(){
		$('#ladybug').attr("src", "/images/flippingbook/"+this.value);
	});

	//products info
	$('#imgsel_categs_id').load(
		'/administrator/index.php?option=com_flippingbook&task=get_categs'+
		"&ts="+new Date().getTime());

	$('#imgsel_categs_id').change(function(){
		if(check_active())
			$.get(
				'/administrator/index.php?option=com_flippingbook&task=get_prodattr&product_id='+
					this.value.split(",")[1]+
					"&ts="+new Date().getTime(),
				function(data) {
					$('#imgsel_products_id').html(data);
					update_s(ias.getSelection());
				});
	});

	$('#imgsel_products_id').change(function(){
		if(check_active())
			update_s(ias.getSelection());
	});

	ImageSelectBox = {};
	ImageSelectBox.save_data = function(fn){
		var s = [];
		$('#items_coord option').each(function(i, n){
			if(!n.disabled){
				s.push("["+n.value+"]");
			}
		});
		//if(s.length > 0){
			//alert(s);
			$.post(
				"/administrator/index.php?option=com_flippingbook&task=save_imageinfo",
				{cid: $("input[name=cid\\[\\]]").val(),
					image: $('#file option:selected').val(),
					info: s.join(",")},

				function(data, textStatus){
					if(data == "error 1")
						alert("Не выбран товар для области.");
					else if(data.indexOf("error in") >= 0)
						alert("Продукт заданный для области" +
							data.substr(8, data.length) + " - не существует.");
					else
						fn();
					/*
					if(textStatus== "success")
						alert("Данные сохранены.");
					else
						alert("Ошибка при сохранении данных.");
					*/
				});
		//}
	};
	
	ImageSelectBox.gen_swf = function(fn){
		var s = [];
		$('#items_coord option').each(function(i, n){
			if(!n.disabled){
				s.push("["+n.value+"]");
			}
		});

		if(s.join(",") == "")
			$.post("/administrator/index.php?option=com_flippingbook&task=remove_swf_page&cid="+
				$("input[name=cid\\[\\]]").val(),
				function(data){
					fn();
				});
		else
			$.post("/administrator/index.php?option=com_flippingbook&task=generate_swf_page&cid="+
				$("input[name=cid\\[\\]]").val(),
			function(data){
				//alert("swf generated");
				fn();
				/*
				if(data == "0")
					alert("Активная SWF-страница сгенерирована.");
				else
					alert("Ошибка при генерации SWF-страницы.");
				*/
			});
	};

	$('#bRemove').click(function(){
		$.get("/administrator/index.php?option=com_flippingbook&task=remove_swf_page&cid="+
			$("input[name=cid\\[\\]]").val()+
			"&ts="+new Date().getTime(),
		function(data){
			alert("SWF-страница удалена.");
		});
	});

	$("#bFilter").click(function(){
		$('#imgsel_categs_id').load(
			'/administrator/index.php?option=com_flippingbook&task=get_categs'+
			"&art="+$("#imgsel_art").val()+
			"&ts="+new Date().getTime());
	});

	$("#bFilterReset").click(function(){
		$('#imgsel_categs_id').load(
			'/administrator/index.php?option=com_flippingbook&task=get_categs'+
			"&ts="+new Date().getTime());
	});

};

if($.browser.mozilla){
	window.onload = image_selection_box;
}
else{
	document.body.onload = image_selection_box;
}

})(jQuery);

</script>

	<? }

	function editPage( &$row, &$lists ) {
		//$document = &JFactory::getDocument();
		//$document->addScript("js/some-script.js");

		if (JRequest::getCmd('task') == 'add_page') {
			$row->file = '';
			$row->book_id = '';
			$row->description = '';
			$row->ordering = '0';
			$row->published = '1';
			$row->link_url = '';
			$row->link_url_target = '';
			$row->link_window_height = '600';
			$row->link_window_width = '800';
			$row->zoom_url = '';
			$row->zoom_url_target = '';
			$row->zoom_window_height = '600';
			$row->zoom_window_width = '800';
		}
		JRequest::setVar( 'hidemainmenu', 1 );

		$editor =& JFactory::getEditor();

		jimport('joomla.filter.output');
		JFilterOutput::objectHTMLSafe( $row, ENT_QUOTES );

		JHTML::_('behavior.tooltip');
		?>
<script language="javascript" type="text/javascript">
	//NOTE image select box
	var ImageSelectBox = null;

	function submitbutton(pressbutton) {
		var form = document.adminForm;
		if (pressbutton == 'cancel_page') {
			submitform( pressbutton );
			return;
		}
		// do field validation
		/*if (form.title.value == "") {
			alert( "" );
		}*/
		else {

			//NOTE image select box
			if(ImageSelectBox != null){
				ImageSelectBox.save_data(function(){
					ImageSelectBox.gen_swf(function(){
						submitform( pressbutton );
					});
				});
			}			
			else
				submitform( pressbutton );
		}
	}

</script>

<? self::image_selection_box("/images/flippingbook/".$row->file)?>

<form action="index.php" method="post" name="adminForm">
	<table class="admintable" width="100%">
		<tr>
			<td valign="top">
				<table class="adminform">
					<tr>
						<td class="key"><?php echo JText::_( 'Page ID' ); ?></td>
						<td><?php echo $row->id ; ?></td>
					</tr>
					<tr>
						<td class="key"><?php echo JText :: _('Published'); ?></td>
						<td><?php echo JHTML::_( 'select.booleanlist', 'published', 'class="inputbox"', $row->published ); ?></td>
					</tr>
					<tr>
						<td class="key"><span class="editlinktip hasTip" title="<?php echo JText::_( 'Book' );?>::<?php echo JText::_( 'Book Page Description' ); ?>"><?php echo JText::_( 'Book' ); ?></span></td>
						<td><?php echo $lists['books']; ?></td>
					</tr>
						<td class="key"><span class="editlinktip hasTip" title="<?php echo JText::_( 'File' );?>::<?php echo JText::_( 'File Page Description' ); ?>"><?php echo JText::_( 'File' ); ?></span></td>
						<td><?php echo $lists['files']; ?></td>
					</tr>
					<tr>
						<td class="key">
						  <span class="editlinktip hasTip" title="<?php echo JText::_( 'Zoomed Image' );?>::<?php echo JText::_( 'Zoomed Image Description' ); ?>"><?php echo JText::_( 'Zoomed Image' ); ?></span></td>
						<td><table border="0" cellspacing="0" cellpadding="0">
                            <tr>
                              <td><?php echo $lists['zoomed_image']; ?></td>
                              <td><span class="editlinktip hasTip" title="<?php echo JText::_( 'SWF File Width and Height' );?>::<?php echo JText::_( 'SWF File Width and Height Description' ); ?>"><?php echo JText::_( 'SWF File' ); ?></span>
							  <?php echo JText::_( 'Width' ); ?> <input name="zoom_width" type="text" class="text_area" id="zoom_width" value="<?php echo $row->zoom_width; ?>" size="6" /></td>
                              <td><?php echo JText::_( 'Height' ); ?> <input name="zoom_height" type="text" class="text_area" id="zoom_height" value="<?php echo $row->zoom_height; ?>" size="6" /></td>
							</tr>
                          </table></td>
					</tr>
					<tr>
						<td class="key"><span class="editlinktip hasTip" title="<?php echo JText::_( 'Ordering' );?>::<?php echo JText::_( 'Order Page Description' ); ?>"><?php echo JText::_( 'Ordering' ); ?></span></td>
						<td><input name="ordering" type="text" class="text_area" id="ordering" value="<?php echo $row->ordering; ?>" /></td>
					</tr>
					<tr>
						<td class="key"><span class="editlinktip hasTip" title="<?php echo JText::_( 'URL' );?>::<?php echo JText::_( 'URL Description' ); ?>"><?php echo JText::_( 'URL' ); ?></span></td>
						<td><input name="link_url" type="text" class="text_area" id="link_url" value="<?php echo $row->link_url; ?>" size="50" /></td>
					</tr>
					<tr>
						<td class="key" style="text-align:left"><span class="key" style="text-align:left"><?php echo JText::_( 'Description' ); ?></span>:</td>
						<td></td>
					</tr>
					<tr>
						<td colspan="2"><?php echo $editor->display( 'description', $row->description, '100%', '300', '60', '20', false ) ; ?></td>
					</tr>
				</table>
			</td>

	</tr>
</table>

<script language="javascript" type="text/javascript">
var zoom_height_obj = document.getElementById("zoom_height");
var zoom_width_obj = document.getElementById("zoom_width");
var zoom_url_list = document.getElementById("zoom_url");

function update_fields_state() {
	var file_ext = zoom_url_list.value.substring(zoom_url_list.value.length-3,zoom_url_list.value.length);
 	if (( file_ext == 'swf')||(file_ext == 'SWF')) {
		zoom_height_obj.disabled = false;
		zoom_width_obj.disabled = false;
	} else {
		zoom_height_obj.disabled = true;
		zoom_width_obj.disabled = true;
	}
}
update_fields_state();
</script>
		<input type="hidden" name="task" value="" />
		<input type="hidden" name="option" value="com_flippingbook" />
		<input type="hidden" name="id" value="<?php echo $row->id; ?>" />
		<input type="hidden" name="cid[]" value="<?php echo $row->id; ?>" />
</form>

	<? self::image_selection_box_script()?>

		<?php
	}
}
?>