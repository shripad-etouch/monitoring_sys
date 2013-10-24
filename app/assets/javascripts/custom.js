$(".add_request_headers").live("click", function(){
	old_index = parseInt($(".request_headers_div").last().attr("index_val"));
	$(".request_headers_div").last().clone().appendTo("#request_headers_main");
	change_ids_and_names(old_index+1)
});

$(".remove_headres").live("click", function(){
	$(this).parent().prev().parent().remove();
	if(parseInt($(".request_headers_div").last().attr("index_val")) != 0){
		$(".remove_link_div").remove(); //This is extra check not essential
		$(".request_headers_div").last().append("<div class='remove_link_div'> <a href='javascript:void(0)' class='remove_headres'> Remove </a> </div>");
	}
});


function change_ids_and_names(index)
{
	main_obj = $(".request_headers_div").last();
	main_obj.attr("index_val", index);
	object_child = main_obj.children().first();
	change_attributes(object_child, index, "request_header_key_");
	change_attributes(object_child.next(), index, "request_header_value_");
	$(".remove_link_div").remove();
	main_obj.append("<div class='remove_link_div'> <a href='javascript:void(0)' class='remove_headres'> Remove </a> </div>");
	
}

function change_attributes(obj, index, string_val){
	obj.attr("id", string_val+index);
	obj.attr("name", string_val+index);
	obj.attr("value","");
}


