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
  

  if_required  = function(quota,show,chain){
    if(show){
      quota.parents('.q-filler').find('.q-required').css('display','inline');
      quota.parents('.q-content').find('input').prop('disabled', false);
      if(chain){
        chain.parents('.q-content').find('input').prop('disabled', false);
        chain.prop('disabled', false);
      }
    }else{
      quota.parents('.q-filler').find('.q-required').css('display','none');
      d_ipt = quota.parents('.q-content').find('input');
      ipt_text = quota.parents('.q-content').find('input[type="text"]');
      d_ipt.prop('checked',false);
      d_ipt.prop('disabled', true);
      ipt_text.val('')
      if(chain){
        chain.prop('checked',false);
        chain.prop('disabled', true);
        chain.parents('.q-content').find('input').prop('disabled', true).val('');
      }      
    }
  }

  set_required = function(obj){
    var name  = obj.attr('name');
    var val   = obj.attr('value');
    if (!val){
      val = obj.val();
    }
      
    
    var quota = null;
    switch(name) {
      case 'answ[known_level]':
        quota = $('input[name="answ[known_way][]"]');
        if(val == '没听说过'){
          if_required(quota,false);
        }else{
          if_required(quota,true);
        }
        break;
      case 'answ[support]':
          var quota1 = $('input[name="answ[suggest]"]');
          var quota2 = $('input[name="answ[reason]"]');
        if(val == '是'){
          if_required(quota1,true);
          if_required(quota2,false);
        }else{
          if_required(quota1,false);
          if_required(quota2,true);
        }
        break;
      case 'answ[have_innovate]':
        quota = $('input[name="answ[innovate_type][]"]');
        var quota1 = $('input[name="answ[prefer_policy]"]');
        var quota2 = $('input[name="answ[policy_problem]"]');
        if(val == '是'){
          if_required(quota,true);
        }else{
          if_required(quota,false);
          if_required(quota1,false);
          if_required(quota2,false);
        }      
        break;
      case 'answ[innovate_type][]':
      	quota = $('input[name="answ[prefer_policy]"]');
      	if(val == '上述都没有'){
      		if_required(quota,false);
      	}else{
      		if_required(quota,true);
      	}
      	break;
      case 'answ[prefer_policy]':
        var obj_disabled = obj.prop('disabled')
      	quota = $('input[name="answ[policy_problem]"]');

        if(obj_disabled){
          if_required(quota,false);
        }else{
         if(val == '从未申请过'){
          if_required(quota,false);
         }else{
          if_required(quota,true);
         }
         
        }   
        break;
      case 'answ[innovate_union]':
        quota = $('input[name="answ[union_support][]"]');
        if(val == '是'){
          if_required(quota,true);
        }else{
          if_required(quota,false);
        }
        break;
      case 'answ[service_support]':
        quota = $('input[name="answ[no_supp_reason][]"]');
        if(val == '是'){
          if_required(quota,false);
        }else{
          if_required(quota,true);
        }      
        break;
      case 'answ[adv_person]': 
        quota = $('input[name="answ[adv_p_support]"]');
        if(val == '是'){
          if_required(quota,true,$('input[name="answ[no_adv_reason]"]'));
        }else{
          if_required(quota,false,$('input[name="answ[no_adv_reason]"]'));
        }          
        break;
      case 'answ[adv_p_support]':
        quota = $('input[name="answ[no_adv_reason]"]');
        var obj_disabled = obj.prop('disabled');

        if(obj_disabled){
          if_required(quota,false);
        }else{
          if(val == '否'){
            if_required(quota,true);
          }else{
            if_required(quota,false);
          }   
        }
        break;
      case 'answ[adv_reward]':
        quota = $('input[name="answ[reward_reason]"]');
        if(val == '是'){
          if_required(quota,true);
        }else{
          if_required(quota,false);
        }          
        break;
      case 'answ[use_school]':
        quota = $('input[name="answ[no_use_school]"]');
        if(val == '否'){
          if_required(quota,true);
        }else{
          if_required(quota,false);
        }         
        break;
      case 'answ[sent_out]': 
        quota = $('input[name="answ[no_sent_out_res]"]');
        if(val == '否'){
          if_required(quota,true);
        }else{
          if_required(quota,false);
        }           
        break;
      case 'answ[innovate_world]':
        quota = $('input[name="answ[world_type][]"]');
        if(val == '是'){
          if_required(quota,true);
        }else{
          if_required(quota,false);
        }         
        break;
      case 'answ[deduct_prolicy]':
        var quota1 = $('input[name="answ[deduct_usage]"]');
        var quota2 = $('input[name="answ[no_deduct_rea][]"]');
        if(val == '是'){
          if_required(quota1,true);
          if_required(quota2,false)
        }else{
          if_required(quota1,false);
          if_required(quota2,true);
        }
        break;
      case 'answ[depreciation]':
        var quota1 = $('input[name="answ[deprecia_usage]"]');
        var quota2 = $('input[name="answ[no_deprecia][]"]');
        if(val == '是'){
          if_required(quota1,true);
          if_required(quota2,false);
        }else{
          if_required(quota1,false);
          if_required(quota2,true);
        }
        break;
      case 'answ[adv_company]':
        quota = $('input[name="answ[adv_policy]"]');
        if(val == '是'){
          if_required(quota,true);
        }else{
          if_required(quota,false);
        }      
        break;



    }
  }

  send_post_ajax = function(obj){
    set_required(obj)
    $.ajax({
        data: $('form').serialize(),
        url: $('form').attr('action'),
        method: "POST"     
    })
  
  }


  send_upd_ajax = function(obj){
    set_required(obj)
    $.ajax(
      {
          data: $('form').serialize(),
          url: $('form').attr('action'),
          method: "PUT"      
      }
    )
  }

  except = function(obj){
    if(obj.attr('name') == 'answ[innovate_type][]'){
      if(obj.hasClass('last')){
        if(obj.is(':checked')){
          $('input.innovate_type').attr('checked',false)
        }
      }else{
        $('input[name="answ[innovate_type][]"]:last').attr('checked',false)
      }
    }

    if(obj.attr('name') == 'answ[no_deduct_rea][]'){

      if(obj.hasClass('first')){
        if(obj.is(':checked')){
          $('input.no_deduct_rea').attr('checked',false)
        }
      }else{
        $('input[name="answ[no_deduct_rea][]"]:first').attr('checked',false)
      }
    }


    if(obj.attr('name') == 'answ[no_deprecia][]'){
      if(obj.hasClass('first')){
        if(obj.is(':checked')){
          $('input.no_deprecia').attr('checked',false)
        }
      }else{
        $('input[name="answ[no_deprecia][]"]:first').attr('checked',false)
      }
    }    
  }


  $('input[type="radio"]:checked').each(function(){
    set_required($(this));
  })

  $('input[type="checkbox"]:checked').each(function(){
    set_required($(this));
  })  

  $('.new_answ input[type="text"]').keyup(function(){
    send_post_ajax($(this))
    return false
  })

  $('.new_answ input[type="radio"],.new_answ input[type="checkbox"],.new_answ select').change(function(){
    except($(this))
    send_post_ajax($(this))
    //return false
  })    

  $('.edit_answ input[type="text"]').keyup(function(){
    send_upd_ajax($(this))
    //return false
  })

  $('.edit_answ input[type="radio"],.edit_answ input[type="checkbox"],.edit_answ select').change(function(){
    except($(this)) 
    send_upd_ajax($(this))
    //return false
  })


})