$(".add_request_headers").live("click", function(){
    old_index = parseInt($(".request_headers_div").last().attr("index_val"));
    /* Keep only one remove icon. */
    var removeLinks = $(".request_headers_div").last().children(".remove_link_div");
    for(var i=1; i<removeLinks.length; i++){
        removeLinks[i].remove();
    }
    $(".request_headers_div").last().clone().appendTo("#request_headers_main");
    change_ids_and_names(old_index + 1)
});

$(".remove_headres").live("click", function(){
    $(this).parent().prev().parent().remove();
});


function change_ids_and_names(index) {
	var removeIconString;
    if(index == 1) {
        removeIconString = 
            "<div class='remove_link_div'>" +
                "<a href='javascript:void(0)' class='remove_headres'>" +
                    "<i class='icon-large icon-remove' title='Remove header'></i>" +
                "</a>" + 
            " </div>";
    } else {
        removeIconString =
            "<div class='remove_link_div'>" +
                "<a href='javascript:void(0)' class='remove_headres'></a>" + 
            " </div>";
    }
    main_obj = $(".request_headers_div").last();
    main_obj.attr("index_val", index);
    object_child = main_obj.children().first();
    change_attributes(object_child, index, "request_header_key_");
    change_attributes(object_child.next(), index, "request_header_value_");
    main_obj.append(removeIconString);
    
}

function change_attributes(obj, index, string_val){
    obj.attr("id", string_val+index);
    obj.attr("name", string_val+index);
    obj.attr("value","");
}


