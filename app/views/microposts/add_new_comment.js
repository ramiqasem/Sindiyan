$('#<%=@comment.commentable.id %>').find('.comments ul').append('<%= escape_javascript(render 'shared/comment', comment: @comment) %>');

$('[name="comment"]').each(function(){
	$(this).val('');
});

   