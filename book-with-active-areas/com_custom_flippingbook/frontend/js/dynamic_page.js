
/*function flippingbook_addToCart(params, num){
	$ = jQuery;

	var req_params = {};
	if (params[6] && params[6] != "null") {
		var p = params[5].split(":");
		req_params[p[0]+params[5]]=p[1];
	}
	req_params["Itemid"]="1";
	req_params["adjust_price[]"]="";
	req_params["category_id"]=params[4];
	req_params["func"]="cartadd";
	req_params["master_product[]"]="";
	req_params["option"]="com_virtuemart";
	req_params["page"]="shop.cart";
	req_params["prod_id[]"]=params[5];
	req_params["product_id"]=params[5];
	req_params["quantity[]"]=num;
	req_params["set_price[]"]="";

	$.post("/index.php", req_params,
		function(data){
			alert(data);
		});	
}*/

function flippingbook_addToCart(){
	//alert("update");
	//updateMiniCarts();	
	$ = jQuery;
	$(".vmCartModule").load(
		"/index2.php?only_page=1&page=shop.basket_short&option=com_virtuemart&t="+
		new Date().getTime());
}