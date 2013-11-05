// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

//= require jquery.colorbox
//= require jquery.carouFredSel-6.2.1-packed
//= require jquery.isotope.min
//= require jquery.infinitescroll.min
//= require jquery.payment
//= require stripe_payment

(function($){

	var $doc = $(document),
	    $win = $(window),
	    $body = null,
      position;

	//document ready event
	$doc.on('ready', function(){
    
		sectionScroll();

		$body = $('body');

		var isLogged = false;
		if(!$body.is('.not-logged')){
			isLogged = true;
		}

		$.colorbox.settings.opacity = 0.3;
		$.colorbox.settings.scrolling = false;

		$.colorbox.settings.onOpen = function(){
      position = $doc.scrollTop();
      $('#wrapper').css({top: - position});
			$body.addClass('active-popup');
		};
		$.colorbox.settings.onComplete = function(){
			refreshScripts($('#colorbox'));
      $('#cboxContent, #cboxLoadedContent').css('height', '');
			if($('.popup-print').length){
				$('#cboxClose').addClass('hidden');
				$('.popup-print').addClass('animate');
			}else{
				$('#cboxClose').removeClass('hidden');
			}
			setTimeout(function() {
				$.colorbox.resize();
			}, 100);
		};
		$.colorbox.settings.onCleanup = function(){
      $('#wrapper').css({top: 0})
			$body.removeClass('active-popup');
      $doc.scrollTop(position);
      $
			if($('.send-text').length){
				setTimeout(function() {

					popupOpen($body.data('prev-popup'));
				}, 500);
			}
		};

		//blink fields
		$doc

		.on('click', function(event){
			$('.sign-form').each(function(){
				if($(this).css('visibility') == 'visible'){
					if($(event.target).is('.sign-form') == false && $(event.target).closest('.sign-form').length == 0){
						$(this).removeClass('expanded');
					}
				}
			});
			$('.filter.expanded').each(function(){
				var $filter = $(this);
				if($filter.find('.dropdown').css('visibility') == 'visible'){
					if(!$(event.target).is('.filter.expanded .dropdown') && !$(event.target).closest('.filter.expanded .dropdown').length){
						$filter.removeClass('expanded');
					}
				}
			});
			if($('.help .balloon').css('visibility') == 'visible'){
				if(!$(event.target).is('.help .balloon') && !$(event.target).closest('.help .balloon').length){
					$('.help .balloon.expanded').removeClass('expanded');
				}
			}
		})

		.on('focusin', '.field, textarea', function(){
			if(this.title==this.value) {
				this.value = '';
			}
		}).on('focusout', '.field, textarea', function(){
			if(this.value=='') {
				this.value = this.title;
			}
		})

		.on('click', '.tabs-nav a', function(event){
			var $self = $(this),
				$target = $($self.attr('href'));

			if($target.length){
				event.preventDefault();
				$self.closest('li').addClass('active').siblings().removeClass('active');
				$target.addClass('active').siblings().removeClass('active');
        setTimeout(function(){$('.tab-cnt.active #phone').focus()}, 300);
				if($('#colorbox:visible').length){
					popupResize();
				}
			}
		})

		.on('click', '.app-request .cancel, .close-popup', function(event){
			event.preventDefault();
			$.colorbox.close()
		})

		.on('submit', '.postcard .edit-card form', function(event){
			event.preventDefault();
			populateCard($(this).find("*[data-mirror]"));
			$('.postcard').addClass('completed');
			popupReszie();

		})

		.on('click', '.postcard .complete-card .edit', function(event){
			event.preventDefault();
			$('.postcard').removeClass('completed');
			popupReszie();

		})

		.on('click', '.send-message', function(event){
			event.preventDefault();
			var form = $('.postcard .edit-card form');
			$.post(form.attr('action'), form.serialize(), function(data) {
				if(data.success == true){
					$('.postcard').removeClass('completed').addClass('sent');
					$('.postcard .thank .message').text(data.description);
					$('.postcard .thank .icon-facebook-big').attr("href", data.facebook_sharing_uri);
					$('.postcard .thank .icon-twitter-big').attr("href", data.twitter_sharing_uri);

					popupReszie();
				}
			});

		})

		.on('change keyup', '.pay-box .field', function(event){
			var val = parseFloat($(this).val()),
				kcode = event.keyCode ? event.keyCode : event.which;

			if(!$.isNumeric(val)){
				val = 0;
			}
			if(val < 0){
				val = 0;
			}
			val = val.toString();
			if(val.indexOf('.') > 0){
				var whole = val.split('.')[0],
					floats = val.split('.')[1];
				if(floats.length > 2){
					floats = floats.substring(0,2);
				}else{
					floats = floats + '0';
				}
				val = whole + '.' + floats
			}else{
				val = val + '.00';
			}

			$(this).data('val', val)
			if(kcode == 13 || typeof(kcode) == 'undefined'){
				$(this).val($(this).data('val'));
				PayBox.setSum(val);
			}

		})

		.on('focusout', '.pay-box .field', function(){	
			$(this).val($(this).data('val'));
		})


		.on('change', '.qty input', function(){
			
      if($(this).parent().is('.checked')){
        $("input[name='offer_id']").attr("checked", false)
        $(this).attr("checked","checked")
		//var origPrice = parseFloat($('input[name=offer_id]:checked').data('price'));
		var currPrice = parseFloat($('input.custom-input:checked').data('price'));
        var origPrice = parseFloat($('input.custom-input:checked').data('originalprice'));
    	
		var offerName = $(this).data('name');
        var offerDetails = $(this).data('details');
        var decodedOfferDetails = $("<div/>").html(offerDetails).text();
        
        
        $('div.deal-body .description h2').fadeOut(200, function() {
          $(this).text(offerName).fadeIn(200);
        });
        $('div.deal-body .description p').fadeOut(200, function() {
          $(this).text(decodedOfferDetails).fadeIn(200);
        });
        
        
		$('.pay-box').find('.field').val(currPrice);
    
    	var min = currPrice;
		var mid = origPrice;
    	var max = origPrice * 2;
        
		$('.pay-box').find('.min').text('$' + min);
		$('.pay-box').find('.mid').text('$' + mid);
		$('.pay-box').find('.max').text('$' + max);
		
		$('.pay-box').find('.slider').slider({ value: 1 });
	
		$('.pay-box').find('.slider').slider('option', {
			min: currPrice,
			max: origPrice * 2
		});
        
		}
	})

		.on('click', '.buy-btn', function(event){
			event.preventDefault();
      $('.deal-popup .deal-payment').addClass('payment-active');
      var $deal = $(this).closest('.deal'),
          $dealHeight = $deal.find('.deal-payment').height();
			$deal.height($dealHeight);
      $('#cboxLoadedContent').height($dealHeight + 130);
      $('#cboxContent').css('height', $dealHeight + 190);
      $doc.bind('webkitTransitionEnd oTransitionEnd transitionend msTransitionEnd', function(){
        if($('.deal-popup .profile .focus').length){
          $('.deal-popup .profile .focus').focus();
        } else if($('.deal-popup .deal-payment .focus').length) {
          $('.deal-popup .deal-payment .focus').focus();
        }
        $doc.unbind('webkitTransitionEnd oTransitionEnd transitionend msTransitionEnd');
      });
      var $amount = $('.pay-box input[name=amount]').val();
      var $give_to = $('.deal-payment .give-to');
      if($amount > 1){
        $give_to.text("Give " + $amount + " Meals To")
      } else {
        $give_to.text("Give " + $amount + " Meal To")
      }
		})

		.on('click', '.deal-payment .back', function(event){
			event.preventDefault();
			var $deal = $(this).closest('.deal-payment').siblings('.deal'),
          $dealHeight = $deal.find('.deal-main').height();
      $deal.css('height', '');
      //$('.deal-popup').height($('.deal-popup').height()).find
      $('.deal-payment').removeClass('payment-active');
			$deal.height($dealHeight).closest('#cboxLoadedContent').height($dealHeight + $('.mini-profile').height());
		})

		.on('click', '.pay-box .help .ballon-expander', function(event){
			event.preventDefault();

			//set little timeout to prevent item from close immidiatly after the open
			setTimeout(function(){
				$('.help .balloon').addClass('expanded');
			}, 1);
		})
    
    .on('click', '.view-account-btn', function(event) {
      event.preventDefault();
      $.colorbox.close();
    })

		.on('click', '.welcome-line > .sign-form-link', function(event){
			event.preventDefault();
			$('#sign-up-form').toggleClass('expanded');
      setTimeout(function(){$('.expanded').find('input[tabindex=1]').focus()}, 300);
		})

		.on('click', '.deal-payment .form-foot a, .deal-payment .form-foot a', function(event){
			event.preventDefault();
			$('.profile #sign-in-form, .profile #sign-up-form').toggleClass('hidden');
      $('.profile .focus').focus();
		})

    .on('click', '#sign-up-form .form-caption a, #sign-in-form .form-caption a', function(event){
			event.preventDefault();
			$('#sign-in-form, #sign-up-form').toggleClass('expanded');
      setTimeout(function(){$('.expanded').find('input[tabindex=1]').focus()}, 300);
		})

		.on('click', '.balloon-close', function(event){
			event.preventDefault();
			$(this).closest('.balloon').removeClass('expanded');
		})

		.on('click', '.deal-payment .different a', function(event){
			event.preventDefault();
			$(this).closest('.deal-payment').addClass('adding-card');
		})

		.on('click', '.popup-link', function(event){
			event.preventDefault();
			var data = $(this).data();
			if(data.disabled){
				return
			}

			if(data.slug) {
		        var full = location.protocol+'//'+location.hostname+(location.port ? ':'+location.port: '');
		        history.pushState({food: "circles"}, "FoodCircles", full + '/'+$(this).data('slug'));
		  		popupOpen('/deal_popup_not_logged/'+$(this).data('slug'));
					
			} else {
				console.log($(this));
				popupOpen($(this).attr('href'));
			}
      
		})

		.on('ajax:beforeSend', 'form[data-show-ajax-status-on]', function(e){
			var form = $(this);
			var selector = form.data('show-ajax-status-on');
			var input = form.find(selector);
			var text = form.data("processing-text") || "Submitting ..."
			if(input.is("input")){
				input.val(text);
			}else{
				input.text(text);
			}
		})

		.on('ajax:error', 'form[data-show-ajax-status-on]', function(e) {
			var form = $(this);
			var selector = form.data('show-ajax-status-on');
			var input = form.find(selector);
			var text = form.data("error-text") || "Error"
			if(input.is("input")){
				input.val(text);
			}else{
				input.text(text);
			}
		})

		.on('ajax:success', 'form[data-show-ajax-status-on]', function(e) {
			var form = $(this);
			var selector = form.data('show-ajax-status-on');
			var input = form.find(selector);
			var text = form.data("success-text") || "Done"
			if(input.is("input")){
				input.val(text);
			}else{
				input.text(text);
			}
		})

		.on('click', '*[data-mixpanel-event]:not([data-mixpanel-trigger-on]), *[data-mixpanel-event][data-mixpanel-trigger-on=click]', function(e) {
			var element = $(this);
			var eventName = element.data('mixpanel-event');
			var eventOptions = element.data('mixpanel-options');
			mixpanel.track(eventName, eventOptions);
		})

		.on('change', '*[data-mixpanel-event][data-mixpanel-trigger-on=change]', function(e) {
			var element = $(this);
			if(!element.is(':checked')){
				return true;
			}
			var eventName = element.data('mixpanel-event');
			var eventOptions = element.data('mixpanel-options');
			mixpanel.track(eventName, eventOptions);
		});

		//banner slideshow
		$('.banner .slides').carouFredSel({
			auto:4500,
			responsive:true,
			items:{
				visible:1,
				height:'28%'
			},
			pagination:'.banner .paging',
			prev:'.banner .slide-prev',
			next:'.banner .slide-next',
			scroll: { fx: 'crossfade', duration: 1000 }
		});

		Header.init();

		$('.products-head .search .field').autocomplete({
		  source:[
				'ActionScript',
				'AppleScript',
				'Asp',
				'BASIC',
				'C',
				'C++',
				'Clojure',
				'COBOL',
				'ColdFusion',
				'Erlang',
				'Fortran',
				'Groovy',
				'Haskell',
				'Java',
				'JavaScript',
				'Lisp',
				'Perl',
				'PHP',
				'Python',
				'Ruby',
				'Scala',
				'Scheme'
			]
		})
		if(typeof($('.products-head .search .field').data('ui-autocomplete')) !== 'undefined'){

			$('.products-head .search .field').data('ui-autocomplete')._renderMenu = function(ul, items ){
				var that = this;
				$.each( items, function(index, item){
					that._renderItemData(ul, item);
				});

				var $lnk = ul.parent('.ui-front').find('.acomplete-lnk').clone(),
					$lnkLi = $('<li />').append($lnk).addClass('sub-link');
				ul.append($lnkLi);
			}
		}

		$('.search .search-btn').on('click', function(event){
			event.preventDefault();
			var $self = $(this),
				$search = $self.closest('.search');
			if($search.is('.expanded')){
				$search.trigger('submit');
			}else{
				$search.addClass('expanded');
				setTimeout(function() {
					$search.find('.field').trigger('focus');
				}, 20);
			}
		});

		$('.search .field').on('focusout', function(){
			if($(this).val() == ''){
				$('.search').removeClass('expanded');
			}
		});

		$('.filter h5 a').on('click', function(event){
			event.preventDefault();
			var $filter = $(this).closest('.filter');

			//set little timeout to prevent item from close immidiatly after the open
			setTimeout(function(){
				if($filter.is('.expanded')){
					$filter.removeClass('expanded');
				}else{
					$filter.addClass('expanded');
				}
			}, 1);
		});

		var $ptiles = $('.products-tiles');

		Tiles.init();

		$('.filter .filter-btn').on('click', function(event){
			event.preventDefault();
			Tiles.filter();
		});

    $('.filter-tag').on('click', function(event){
      event.preventDefault();

      var $filt = $('.filters .category');
      $filt.find('input:checked').prop('checked', false);
      $filt.find('.' + $(this).attr('data-type') + ' #' + $(this).text()).prop('checked', true).trigger('change');
      $('.products-tiles').isotope({filter:'.' + $(this).text().toLowerCase().replace(/[^\w-]+/g,' ').trim().replace(/ /g,'-') + ', .add-new'});
    });

		$('.filter .cancel').on('click', function(event){
			event.preventDefault();
			$(this).closest('.filter').removeClass('expanded');
		});

		$('.filter .clear-all').on('click', function(event){
			event.preventDefault();
			$(this).closest('.filter').find('input:checked').prop('checked', false).trigger('change');
		});

		$('.filter.expanded .all-results a').on('click', function(event){
			event.preventDefault();
			$('.filter.expanded input').prop('checked', true);
			$('.filter.expanded .filter-btn').trigger('click');
		});

		$('.filter input').on('change', function(){
			var $filter = $(this).closest('.filter');
			if($filter.find('input:checked').length){
				$filter.addClass('has-checked');
			}else{
				$filter.removeClass('has-checked');
			}
		});

		$('.balloon .close').on('click', function(event){
			event.preventDefault();
			$(this).closest('.balloon').addClass('disabled');
		});


		$('.settings .edit').on('click', function(event){
			event.preventDefault();
			var $fieldset = $(this).closest('fieldset');
			if($fieldset.is('.editing')){
				AccSettings.saveGroup($fieldset);
			}else{
				AccSettings.editGroup($fieldset);
			}

		});

		$('.settings .delete[data-remote=true]').bind('ajax:success', function(event, data) {
			event.preventDefault();
			if(data.success){
				$(this).hide().closest('.row').hide();
			}
		});

    $(document).bind('cbox_closed', function(){ 
      if($body.data('meta') === 'home#index')
      {
        var full = location.protocol+'//'+location.hostname+(location.port ? ':'+location.port: '');
        history.pushState({food: "circles"}, "FoodCircles", full + '/');
      }
        
    });

	});//document ready event

	$win.on('load', function(){
		Header.pos();
		sectionScroll();
    
    //var offer_id_if_present = location.pathname.match(/\/offer\/(\d+)/);
    if(location.pathname == '/apps' && $body){
      popupOpen('app_popup')
    }
    else if(location.pathname != '/' && location.pathname != '/app_popup' && $body){
      if($body.data('meta') === 'home#index' && !$body.hasClass("sold-out")){
        popupOpen('/deal_popup_not_logged'+location.pathname);
      }
    }
    
	});

	$win.on('resize', function(){
		Header.pos();
	});

	/*=== Helpers ===*/

	function popupOpen(href){
		$.colorbox({
			href: href,
			onComplete:function(){
				$body.data('prev-popup', $body.data('cur-popup'));
				$body.data('cur-popup', href);
            
				refreshScripts($('#colorbox'));
				if($('.popup-print').length){
					$('#cboxClose').addClass('hidden');
					$('.popup-print').addClass('animate');
				}else{
					$('#cboxClose').removeClass('hidden');
				}
				setTimeout(function() {
					$.colorbox.resize();
				}, 100);
			}
		});
	}
        $.popupOpen = popupOpen

	function refreshScripts($cnt){
		//check if cnt isn't assigned and assign it as doc
		if(!$cnt){
			$cnt = $doc;
		}
		CInput.init($cnt);

		$('.slider').each(function(){
			var $slider = $(this),
				$holder = $slider.closest('.slider-holder'),
				sliderMin = 0,
				sliderMax = 0;

			if($holder.length){
				sliderMin = parseInt($holder.find('.min').text().replace('$', ''));
				sliderMax = parseInt($holder.find('.max').text().replace('$', ''));
			}
			$slider.slider({
				min: sliderMin,
				max: sliderMax,
				step:1,
				slide: function(event, ui){
					if($slider.closest('.pay-box').length){
            			$('.pay-box').find('.field').val(ui.value);
			  			$('.donation-info strong').text(Math.floor($('.pay-box').find('.field').val()));
			  			if(Math.floor($('.pay-box').find('.field').val() > 1){
			  			  $('.donation-info .meal-text').text('meals donated');
			  			}
						var mixPanelOptions = $slider.data('mixpanel-options')
						mixPanelOptions.value = ui.value;
						mixpanel.track("Touched slider handle", mixPanelOptions);
					}
				}
			});
		});
		var currPrice = parseFloat($('input.custom-input:checked').data('price'));
        var origPrice = parseFloat($('input.custom-input:checked').data('originalprice'));
    	
		$('.pay-box').find('.field').val(currPrice);
    
    	var min = currPrice;
		var mid = origPrice;
    	var max = origPrice * 2;
        
		$('.pay-box').find('.min').text('$' + min);
		$('.pay-box').find('.mid').text('$' + mid);
		$('.pay-box').find('.max').text('$' + max);
		
    
		$('.pay-box').find('.slider').slider('option', {
			min: currPrice,
			max: origPrice * 2
		});
		// $('.deal').height($('.deal').height());



		$('.deal .card-number .field').payment('formatCardNumber').on('keyup', function(){
			var val_ = $(this).val()

			if(val_.length > 0){
				$('.deal-payment').addClass('has-value');
			}else{
				$('.deal-payment').removeClass('has-value');
			}

			console.log($.payment.cardType(val_))
			switch($.payment.cardType(val_)){
				case 'visa':
					$('.cards').find('.visa').addClass('active').siblings().removeClass('active');
					break;
				case 'amex':
					$('.cards').find('.amex').addClass('active').siblings().removeClass('active');
					break;
				case 'mastercard':
					$('.cards').find('.mastercard').addClass('active').siblings().removeClass('active');
					break;
				default:
					$('.cards').find('.generic').addClass('active').siblings().removeClass('active');
			}
			if($.payment.validateCardNumber(val_)){
				$('.deal .card-number').addClass('valid');
			}else{
				$('.deal .card-number').removeClass('valid');	
			}
		});
		$('.deal .cv-code .field').payment('formatCardCVC');

		$('.phone-module:visible', $cnt).find('.field').trigger('focus');
		$('.subscribe:visible', $cnt).find('.field').trigger('focus');

	}
        $.refreshScripts = refreshScripts


	function sectionScroll(){
		if(window.location.hash == '#restaurants' && $('.products').length){
			setTimeout(function(){
				$('html, body').scrollTop($('.donation-progress').offset().top);
			}, 0);
		}
	}

	var AccSettings = {
		editGroup: function($fieldset){
			$fieldset.addClass('editing').find('.field').each(function(){
				if($(this).is('[type="password"]')){
					$(this).val('');
				}else{
					$(this).val($(this).siblings('.value').text());
				}
			});
			$fieldset.find('.edit span').text('save');
			$fieldset.find('.field:first').trigger('focus');
		},
		saveGroup: function($fieldset){
			var object = this;
			$.post($fieldset.data().url, $fieldset.serialize(), function(data) {
				if(data.success == true){
					object._refreshGroup($fieldset);
				}
			});
		},
		closeEdit: function($fieldset){
			$fieldset.removeClass('editing').find('.edit span').text('edit');
		},
		_refreshGroup: function($fieldset){
			$fieldset.find('.field').each(function(){
				var $self = $(this);
				$self.siblings(".value:not([data-keep='yes'])").text($self.val());
				if($self.val().length){
					$self.siblings('.delete').show();
				}
			});
			this.closeEdit($fieldset);
		}

	}


	var PayBox = {
		price: 1,
		sum: 1,
		calc: function(){
			$('.donation-info strong').text(Math.floor(this.sum/this.price));
		},
		setSum: function(sum){
			this.sum = parseFloat(sum);
			this.calc();
		},
		setPrice: function(price){
			this.price = price;
			this.calc();
			
		}
	}


	var Header = {
		breakPoint: 0,
		mini: false,
		init: function(){
			this.pos(true);
			this.run();
		},
		change: function(){
			if(this.mini){
				$body.removeClass('mh-active');
				this.mini = false;
			}else{
				$body.addClass('mh-active');
				this.mini = true;
			}
		},
		pos: function(initial){
			if($('#hero').length){
				this.breakPoint = $('#hero').offset().top + $('#hero').outerHeight(); 
			}else{
				if(initial){
					this.breakPoint = $('#header').outerHeight();
				}
			}
		},
		run: function(){
			$win.on('scroll', function(){
				if($win.scrollTop() > Header.breakPoint){
					if(!Header.mini){
						Header.change();
					}
				}else{
					if(Header.mini){
						Header.change();
					}
				}
			});
		}
	}

	var Tiles = {
		init: function(){
			$ptiles = $('.products-tiles');
			$ptiles.isotope({
				transformsEnabled:false,
				animationEngine:'css',
				itemSelector:'.tile'
			})
			.infinitescroll({
				navSelector: '.pagination',
				nextSelector:'.next_page',
				itemSelector:'.tile:not(.add-new)',
				bufferPx:-200,
				errorCallback: function(){
					$('.pagination').text('No more offers.')
				},
				loading: {
					img: 'assets/loader.png'
				}
			}, function(newElements){
				var $addNew = $ptiles.find('.add-new');

				//Endless Page
				if($('.pagination').length){
					$(window).scroll(function(){
						var url = $('.pagination .next_page').attr('href');
						if(url && $(window).scrollTop() > $(document).height() - $(window).height() - 50){
							var $newElements = $.getScript(url);
						}
					});
				}//Endless page end

				$ptiles.isotope('insert', $(newElements)).isotope('insert', $addNew);
			});
		},
		filter: function(){
			var that = this,
				$filters = $('.filters'),
				aFilter = [],
				selector;

			if($filters.find('input:checked').length){
				$filters.find('input:checked').each(function(){
					aFilter.push('.' + $(this).val().toLowerCase().replace(/[^\w-]+/g,' ').trim().replace(/ /g,'-'));
				});
				selector = aFilter.join(', ') + ', .add-new';
			}else{
				selector = '.tile';
			}
			$('.products-tiles').isotope({filter:selector});
			$('.filter.expanded').removeClass('expanded');
		}
	}

	var CInput = {
		init: function($cnt){
			var that = this;
			if(!$cnt){
				$cnt = $doc;
			}
			$('label', $cnt).off('click').on('click', function(event){
				that.handle($(this), event);
			});

			$('input', $cnt).off('disable enable').on('disable enable', function(event){
				that.handle($(this).parent().find('label'), event);
			});

			$('input', $cnt).each(function(){
				var $self = $(this);
				if($self.is('[type="checkbox"]') || $self.is('[type="radio"]')){
					if($self.is(':checked')){
						$self.parent().addClass('checked');
					}
					if($self.is(':disabled')){
						$self.parent().addClass('disabled');
					}
				}
			});
		},
		handle: function($label, event){
			var $input = $('input#' + $label.attr('for')),
				$parent = $label.parent();

			if($(event.target).is('a')){
				event.stopPropagation();
			}else{
				if($input.is('.custom-input')){
					if($input.is('[type="checkbox"]') || $input.is('[type="radio"]')){
						event.preventDefault();

						if(event.type == 'disable' || event.type == 'enable'){
							if(event.type == 'disable'){
								$parent.addClass('disabled');
								$input.prop('disabled', true);
							}else{
								$parent.removeClass('disabled');
								$input.prop('disabled', false);
							}
						}else{
							if(!$parent.is('.disabled')){
								if($parent.is('.checked')){
									if(!$input.is('[type="radio"]')){
										$parent.removeClass('checked')
										$input.prop('checked', false).trigger('change');
									}
								}else{
									if($input.is('[type="radio"]')){
										$radioGroup = $('input[type="radio"][name="'+$input.attr('name')+'"]');
										$radioGroup.each(function(){
											var $radioInput = $(this);
											$('label[for='+ $radioInput.attr('id') +']').parent().removeClass('checked');
											if($radioInput.prop('checked') == true){
												$radioInput.prop('checked', false).trigger('change');
											}
										});
									}
									$parent.addClass('checked');
									$input.prop('checked', true).trigger('change');
								}
							}
						}
					}
				}
			}
		}
	}

	function populateCard(arr){
		for (var i = 0; i < arr.length; i++){
			$('.postcard .' + arr[i].getAttribute('data-mirror')).text(arr[i].value);
		};
	}

	function popupReszie(){
		setTimeout(function() {
			$.colorbox.resize();
			setTimeout(function(){
				$.colorbox.resize({speed:0});
			}, 300);
		}, 50);

	}

})(jQuery);

!function ($) {

  "use strict"; // jshint ;_;


 /* ALERT CLASS DEFINITION
  * ====================== */

  var dismiss = '[data-dismiss="alert"]'
    , Alert = function (el) {
        $(el).on('click', dismiss, this.close)
      }

  Alert.prototype.close = function (e) {
    var $this = $(this)
      , selector = $this.attr('data-target')
      , $parent

    if (!selector) {
      selector = $this.attr('href')
      selector = selector && selector.replace(/.*(?=#[^\s]*$)/, '') //strip for ie7
    }

    $parent = $(selector)

    e && e.preventDefault()

    $parent.length || ($parent = $this.hasClass('alert') ? $this : $this.parent())

    $parent.trigger(e = $.Event('close'))

    if (e.isDefaultPrevented()) return

    $parent.removeClass('in')

    function removeElement() {
      $parent
        .trigger('closed')
        .remove()
    }

    $.support.transition && $parent.hasClass('fade') ?
      $parent.on($.support.transition.end, removeElement) :
      removeElement()
  }


 /* ALERT PLUGIN DEFINITION
  * ======================= */

  var old = $.fn.alert

  $.fn.alert = function (option) {
    return this.each(function () {
      var $this = $(this)
        , data = $this.data('alert')
      if (!data) $this.data('alert', (data = new Alert(this)))
      if (typeof option == 'string') data[option].call($this)
    })
  }

  $.fn.alert.Constructor = Alert


 /* ALERT NO CONFLICT
  * ================= */

  $.fn.alert.noConflict = function () {
    $.fn.alert = old
    return this
  }


 /* ALERT DATA-API
  * ============== */

  $(document).on('click.alert.data-api', dismiss, Alert.prototype.close)

}(window.jQuery);
