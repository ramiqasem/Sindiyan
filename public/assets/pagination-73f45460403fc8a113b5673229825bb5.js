$(function(){
	
	$( ".pagination a").click(function(){
		$('#flash_hook').empty();
		var num = $('div[id="tabs"] .tab-pane.active').attr('id') 
		$.get(this.href, { id: num }, null, "script");
		return false;
	
		


});

	$("button:contains('show more')").click(function(){
		$(this).parent().find(".pagination a[rel=\'next\']").click();
		alert ('yes');
		return false;
	});


});
