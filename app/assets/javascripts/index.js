$(document).ready(function() {
  var user = $("#user_identifier").val();
  history.pushState({1:1}, "user", user);

  function prep_events(){
    $('.event_title').click(function(){
      $(this).parent().next().slideToggle(200);
    });

    $('.schedule_add').click(function(){
      var my_event = $(this),
          whole_event = $(this).closest('.event');
      $.ajax({
        url: "/schedule_entries/create?user=" + user + "&event_id=" + my_event.attr('id'),
        cache: false,
        success: function(html){
          my_event.html("YEAH!");
          whole_event.css('background-color', 'green');
          whole_event.css('border-color', 'green');
        }
      });
    });

    $('.schedule_remove').click(function(){
      var my_event = $(this),
          whole_event = $(this).closest('.event');
      $.ajax({
        url: "/schedule_entries/destroy?user=" + user + "&event_id=" + my_event.attr('id'),
        cache: false,
        success: function(html){
          console.log($("#user_schedule_title").val());
          if($("#user_schedule_title").val() !== undefined ){
            whole_event.slideUp(200);
          } else{
            my_event.html("REMOVED!");
            console.log(whole_event);
            whole_event.removeClass('added');
          };
        }
      });
    });
  };

  function prep_schedule_links(){
    console.log('prepping schedule links');
    $("#friend_schedules").change(function(){
      var me = $(this);

      if(me.val() == "ARR"){
        $.ajax({
          url: "/schedules/show?view=list&user=" + user,
          cache: false,
          success: function(html){
            $("#content_box").html(html);
            prep_schedule_links();
            prep_events();
            prep_schedule_share();
          }
        });
      } else {
        $.ajax({
          url: "/shared_schedules/show?shared_schedule=" + me.val() +"&viewing_user=" + user,
          cache: false,
          success: function(html){
            $('#schedule_pane').html(html);
            $(".schedule_add").hide();
            $(".schedule_remove").hide();
            prep_events();
          }
        });
      };
    });
  };

  function prep_schedule_share(){
    $("#send_schedule_form").bind('ajax:success', function(){
      $("#send_to_friend").append("<div id='congratz'>Oh man!  Sent!</div>");
      setTimeout(function(){
        $("#congratz").slideUp(1000);
      }, 10000);
    })
    .bind('ajax:error', function(){
      $("#send_to_friend").append("<div id='fuuuck'>Nooo.. That's not a real user!</div>");
      setTimeout(function(){
        $("#fuuuck").slideUp(1000);
      }, 10000);
    });
  };
  //   $('#list_link').click(function(){
      // $.ajax({
      //   url: "/schedules/show?view=list&user=" + user,
      //   cache: false,
      //   success: function(html){
      //     $("#content_box").html(html);
      //     prep_schedule_links()
      //     prep_events();
      //   }
      // });
  //   });

  //   $('a#timeline_link').click(function(){
  //     console.log("clicked timeline link!");
  //     $.ajax({
  //       url: "/schedules/show?view=timeline&user=" + user,
  //       cache: false,
  //       success: function(html){
  //         console.log(html);
  //         $("#content_box").html(html);
  //         prep_schedule_links()
  //       }
  //     });
  //   });
  // };

  $("#close_welcome_button").click(function(){
    $("#welcome_message").text("Goodbye, I'll miss you... :( :(")
    $("#welcome_message").slideUp(2000);
  })

  $("#panelist").change(function(){
    var panelist = $("#panelist").val();
    $.ajax({
      url: "/events/show?panelist=" + panelist + "&user=" + user ,
      cache: false,
      success: function(html){
        $("#content_box").html(html);
        prep_events();
      }
    });
  });
  $("#conference_schedule").click(function(){
    $.ajax({
      url: "/events/show?user=" + user,
      cache: false,
      success: function(html){
        $("#content_box").html(html);
        prep_events();
      }
    });
  });
  $("#search_friday").click(function(){
    $.ajax({
      url: "/events/show?day=FRIDAY&user=" + user,
      cache: false,
      success: function(html){
        $("#content_box").html(html);
        prep_events();
      }
    });
  });
  $("#search_saturday").click(function(){
    $.ajax({
      url: "/events/show?day=SATURDAY&user=" + user,
      cache: false,
      success: function(html){
        $("#content_box").html(html);
        prep_events();
      }
    });
  });
  $(".day").mouseenter(function(){
    $(this).animate({
      width: '+=10px',
      height: '+=10',
    }, 200, function() {
    // Animation complete.
    });
  });
  $(".day").mouseleave(function(){
    $(this).animate({
      width: '-=10',
      height: '-=10',
    }, 200, function() {
    // Animation complete.
    });
  });

  $("#search_sunday").click(function(){
    $.ajax({
      url: "/events/show?day=SUNDAY&user=" + user,
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
        prep_schedule_links();
        prep_events();
        prep_schedule_share();
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