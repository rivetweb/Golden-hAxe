<?php 
@mkdir(JPATH_SITE."/images/flippingbook", 0755);
$fb_files = array ("abstract_background_blue.jpg", "abstract_background_green.jpg", "abstract_background_orange.jpg", "abstract_background_red.jpg", "abstract_background_yellow.jpg", "book_preview.png", "category_preview.png", "my-book_01.swf", "my-book_02.jpg", "my-book_03.jpg", "my-book_04.jpg", "my-book_05.jpg", "my-book_06.jpg", "my-book_07.jpg", "my-book_08.jpg", "my-book_zoom_02.jpg", "my-book_zoom_03.jpg", "my-book_zoom_04.jpg", "my-book_zoom_05.jpg", "my-book_zoom_06.jpg", "my-book_zoom_07.jpg", "my-book_zoom_08.jpg");

foreach ( $fb_files as $fb_file ) {
	@rename(JPATH_SITE."/components/com_flippingbook/samples/".$fb_file, JPATH_SITE."/images/flippingbook/".$fb_file);
}
?>
