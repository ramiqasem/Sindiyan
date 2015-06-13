
jQuery.ajaxSetup({
    'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})

  $(document).ready(function(){

    resizeChosen();
    jQuery(window).on('resize', resizeChosen);
    
    $('textarea').autosize();

    


    $("#post").click(function (e, data) {
      $(this).empty();
      $('#fileupload').fileupload({
        autoUpload: false
      });
    });

    $('[data-toggle="tooltip"]').tooltip();
    $('#attach').tooltip();


    $("#group_tabs li").click(function() {

    $("#group_tabs li").removeClass("current");

    $(this).addClass("current");

    });

    $("#cancel_post").click(function() {
      resetFormElement($('#fileupload'));
      $("#post_area").val('');
      $('#files-selected').text("");
      $('#fileupload').value = $('#fileupload').defaultValue;
    });
})

function resetFormElement(e) {
  alert ('reset');
        e.wrap('<form>').closest('form').get(0).reset();
        e.unwrap();
      }

function resizeChosen() {
   $(".chosen-container").each(function() {
       $(this).attr('style', 'width: 100%');
   });          
}


var ready = function () {
    $("#success-alert").fadeTo(2000, 1000).slideUp(1000, function(){
    $("#success-alert").alert('close');
});

    


};

$(document).ready(ready);
$(document).on('page:load', ready);

function resize(event, dayDelta, minuteDelta){
  $.ajax({
    type: 'PUT',
    dataType: 'script',
    url: event.update,
    contentType: 'application/json',
    data: JSON.stringify({
      event: { id: event.id, finish: event.end },
      _method:'put'
    })
  });
}

function drop(event, dayDelta, minuteDelta){
  $.ajax({
    type: 'PUT',
    dataType: 'script',
    url: event.update,
    contentType: 'application/json',
    data: JSON.stringify({
      event: { id: event.id, start: event.start, finish: event.end },
      _method:'put'
    })
  });
}

$(document).on('page:change', function() {
  $('#calendar').fullCalendar({
      header: {
      left: 'prev,next today',
      center: 'title',
      right: 'month,agendaWeek,agendaDay'
    },
    height: 600,
    editable: false,
    resizable: false,
    events: '/events.json',
    eventRender: function(event, element) {
      $('a.fc-event-draggable').attr('data-remote', true);
    },
    eventResize: function(event, dayDelta, minuteDelta) {
      resize(event, dayDelta, minuteDelta);
    },
    eventDrop: function(event, dayDelta, minuteDelta, allDay){
      drop(event, dayDelta, minuteDelta);
    }
  });



});

