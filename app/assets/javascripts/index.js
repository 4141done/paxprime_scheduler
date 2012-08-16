$(document).ready(function() {
  var user = $("#user_identifier").val();
  history.pushState({1:1}, "user", user);

  function prep_events(){
    $('.schedule_add').click(function(){
        var my_event = $(this);
      $.ajax({
        url: "/schedule_entries/create?user=" + user + "&event_id=" + my_event.attr('id'),
        cache: false,
        success: function(html){
          my_event.html("Motherfuckin' added!");
        }
      });
    });
  };

  $("#close_welcome_button").click(function(){
    $("#welcome_message").text("Goodbye, I'll miss you... :( :(")
    $("#welcome_message").slideUp(2000);
  })

  $("#panelist").change(function(){
    var panelist = $("#panelist").val();
    $.ajax({
      url: "/events/show?panelist=" + panelist ,
      cache: false,
      success: function(html){
        $("#content_box").html(html);
        prep_events();
      }
    });
  });
  $("#conference_schedule").click(function(){
    $.ajax({
      url: "/events/show",
      cache: false,
      success: function(html){
        $("#content_box").html(html);
        prep_events();
      }
    });
  });
  $("#search_friday").click(function(){
    $.ajax({
      url: "/events/show?day=FRIDAY",
      cache: false,
      success: function(html){
        $("#content_box").html(html);
        prep_events();
      }
    });
  });
  $("#search_saturday").click(function(){
    $.ajax({
      url: "/events/show?day=SATURDAY",
      cache: false,
      success: function(html){
        $("#content_box").html(html);
        prep_events();
      }
    });
  });
  $("#search_sunday").click(function(){
    $.ajax({
      url: "/events/show?day=SUNDAY",
      cache: false,
      success: function(html){
        $("#content_box").html(html);
        prep_events();
      }
    });
  });
  $("#my_schedule").click(function(){
    $.ajax({
      url: "/schedules/show?user=" + user,
      cache: false,
      success: function(html){
        $("#content_box").html(html);
        prep_events();
      }
    });
  });

  $("#search_form").bind("ajax:complete", function( event, XMLHttpRequest, ajaxOptions){
    $("#content_box").slideUp(200);
    $("#content_box").html(XMLHttpRequest.responseText);
    $("#content_box").slideDown(200);
    prep_events();
  });
});