// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(function(){
  send_post_ajax = function(){
    $.ajax({
        data: $('form').serialize(),
        url: $('form').attr('action'),
        method: "POST",
        success: function(ret){
      console.log('post success')
        },
        error: function(){
          console.log('post failed')
        }       
    })
  
  }


  send_upd_ajax = function(){
    $.ajax(
      {
          data: $('form').serialize(),
          url: $('form').attr('action'),
          method: "PUT",
          success: function(ret){
        console.log('upd success')
          },
          error: function(){
            console.log('upd failed')
          }       
      }
    )

  
  }



  $('.new_answ input[type="text"]').keyup(function(){
    send_post_ajax()
    return false
  })

  $('.new_answ input[type="radio"],.new_answ input[type="checkbox"],.new_answ select').change(function(){
    send_post_ajax()
    return false
  })    

  $('.edit_answ input[type="text"]').keyup(function(){
    send_upd_ajax()
    return false
  })

  $('.edit_answ input[type="radio"],.edit_answ input[type="checkbox"],.edit_answ select').change(function(){
    send_upd_ajax()
    return false
  })


})