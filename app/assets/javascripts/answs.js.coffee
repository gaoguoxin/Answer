# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->

	check_required = ->
		$('.q-required:visible').each(->
			q_title = $(@).parent('.q-title')
			q_content = q_title.siblings('.q-content')

			ipt     = q_content.children('input[type="text"]')
			if $.trim(ipt.val()).length == 0
				q_title.parent('.q-filler').addClass('empty')
				return false

			address = q_content.children('select')
			if address.val() == '-1'
				q_title.parent('.q-filler').addClass('empty')
				return false

			radio  = q_content.find('input[type="radio"]')
			console.log(radio.length)
			console.log('------------------')
 
		)

		

	$('#next_btn').click((e)->
		e.preventDefault()
		check_required()
		#alert_notice()
	)



	# send_post_ajax = ()->
 #    	$.ajax
 #    	  data: $('form').serialize()
 #    	  url: $('form').attr('action')
 #    	  method: "POST"
 #    	  success: (ret)->
 #    	    console.log('post success')
 #    	  error: (ret)->
 #   	    	console.log('post failed') 




	# $('.new_answ input[type="text"]').keyup(()->
	# 	send_post_ajax()
	# 	return false
	# )
	# $('.new_answ input[type="radio"],input[type="checkbox"],select').change(()->
	# 	send_post_ajax()
	# 	return false
	# )


