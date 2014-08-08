#=require jquery.fancybox.pack
$ ->
  
	check_required = ->
		$('.q-filler').removeClass('empty')
		$('.q-required:visible').each(->
			q_title = $(@).parent('.q-title')
			q_content = q_title.siblings('.q-content')

			ipt     = q_content.children('input[type="text"]')
			if ipt.length > 0
				if ipt.attr('id') == 'answ_percent'
					if isNaN( parseInt(ipt.val()) )
						q_title.parent('.q-filler').addClass('empty')
						return false
				else
					if $.trim(ipt.val()).length == 0
						q_title.parent('.q-filler').addClass('empty')
						return false

			address = q_content.children('select')
			if address.length > 0
				if address.val() == '-1'
					q_title.parent('.q-filler').addClass('empty')
					return false

			radio  = q_content.find('input[type="radio"]')
			if radio.length > 0
				check_radio = q_content.find('input[type="radio"]:checked')
				if check_radio.length < 1
					q_title.parent('.q-filler').addClass('empty')
					return false

			checkbox = q_content.find('input[type="checkbox"]')
			if checkbox.length > 0
				checked = q_content.find('input[type="checkbox"]:checked')
				if checked.length < 1
					q_title.parent('.q-filler').addClass('empty')
					return false
		)

		other_input = $('input[id$="_other"]')

		other_input.each(->
			current_input = $(@)
			other_ipt = $(@).parent().siblings('input:checked')
			if $.trim($(@).val()).length < 1
				if other_ipt.length > 0
					current_input.parents('.q-filler').addClass('empty')
					return false
			else
				if other_ipt.length <= 0
					current_input.parents('.q-filler').addClass('empty')
					return false
		)

	alert_notice = ->
		if $('.q-filler.empty').length < 1
  		$.fancybox.open($('#alert_notice'),{
  		  padding:0,
  		  autoSize:true,
  		  scrolling:no,
  		  openEffect:'none',
  		  closeEffect:'none',        
  		  helpers : {
  		    overlay : {
  		      locked: false,
  		      closeClick: false,
  		      css : {
  		        'background' : 'rgba(51, 51, 51, 0.2)'
  		      }
  		    }
  		  },
  		  afterShow:->
  		  	$('.fancy-wra button.cancel').bind('click',->
  		  		$.fancybox.close()
  		  	)

  		  	$('.fancy-wra button.sub-btn').bind('click',->
  		  		$('<input id="answ_company" name="answ[status]" type="hidden" value="2">').appendTo($('form'))
  		  		finish()
  		  	)

  		  afterClose:-> 
  		  	$('#alert_notice').hide()
  		})	

	finish = ->
		if $('form').attr('action') == '/answs'
			meth = 'POST'
		else
			meth = 'PUT'
		console.log(meth)
		$.ajax {
			type: meth
			url: $('form').attr('action')
			data: $('form').serialize()
			success: ->
			 	window.location.href = '/'
			error: ->
				console.log('upd faailed')	
		}

	$('#next_btn').click((e)->
		e.preventDefault()
		#check_required()
		alert_notice()
	)

	$('button.review').click(->
		$.ajax {
			type: "GET"
			url: '/review'
			data: {}
			success: (ret)->
			 	if ret
			 		window.open("/answs/#{ret._id['$oid']}",'_blank')
		}		
	)

	$('button.print').click(->
		window.print()
		return false
	)

	$('button.report').click(->
		window.location.href = '/down'
	)



