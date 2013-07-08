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
	    $body = null;

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
			$body.addClass('active-popup');
		};
		$.colorbox.settings.onComplete = function(){
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
		};
		$.colorbox.settings.onCleanup = function(){
			$body.removeClass('active-popup');
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

				if($('#colorbox:visible').length){
					popupReszie();
				}
			}
		})

		.on('click', '.app-request .cancel, .close-popup', function(event){
			event.preventDefault();
			$.colorbox.close()
		})


		.on('click', '.tile.sold-out .progress .block', function(event){
			event.preventDefault();
			if(isLogged){
				$(this).closest('.tile').addClass('notified');
			}else{
				popupOpen($(this).attr('href'));
			}
		})

		.on('submit', '.postcard .edit-card form', function(event){
			event.preventDefault();
			populateCard($(this).serializeArray());
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
			$('.postcard').removeClass('completed').addClass('sent');
			popupReszie();
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
			if($(this).is(':checked')){
				var valArray = $(this).val().split(',');
				PayBox.setPrice(parseInt(valArray[0]));
				$('.pay-box').find('.min').text('$' + parseInt(valArray[0]));
				$('.pay-box').find('.mid').text('$' + parseInt(valArray[1]));
				$('.pay-box').find('.max').text('$' + parseInt(valArray[2]));

				$('.pay-box').find('.slider').slider('option', {
					min: parseInt(valArray[0]),
					max: parseInt(valArray[2]) 
				});
			}
		})

		.on('click', '.buy-btn', function(event){
			event.preventDefault();
			var $deal = $(this).closest('.deal');
			$deal.height($deal.find('.deal-payment').height()).addClass('payment-active');
		})

		.on('click', '.deal-payment .back', function(event){
			event.preventDefault();
			var $deal = $(this).closest('.deal');
			$deal.height($deal.find('.deal-main').height()).removeClass('payment-active');
		})

		.on('click', '.pay-box .help > a', function(event){
			event.preventDefault();

			var $self = $(this);
			//set little timeout to prevent item from close immidiatly after the open
			setTimeout(function(){
				$self.siblings('.balloon').addClass('expanded');
			}, 1);
		})
    
    .on('click', '.view-account-btn', function(event) {
      event.preventDefault();
      $.colorbox.close();
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
      var full = location.protocol+'//'+location.hostname+(location.port ? ':'+location.port: '');
      history.pushState({food: "circles"}, "FoodCircles", full + '/'+$(this).data('slug'));
      
			event.preventDefault();
			popupOpen('/deal_popup_not_logged/'+$(this).data('slug'));

		});

		$('.welcome-line > a').on('click', function(event){
			event.preventDefault();
			//set little timeout to prevent item from close immidiatly after the open
			setTimeout(function(){
				$('#sign-up-form').toggleClass('expanded');
			}, 1);
		});

		$('#sign-up-form .form-caption a').on('click', function(event){
			event.preventDefault();
			//set little timeout to prevent item from close immidiatly after the open
			setTimeout(function(){
				$('#sign-in-form, #sign-up-form').toggleClass('expanded');
			}, 1);
		});


		//banner slideshow
		$('.banner .slides').carouFredSel({
			auto:4000,
			responsive:true,
			items:{
				visible:1,
				height:'28%'
			},
			pagination:'.banner .paging',
			prev:'.banner .slide-prev',
			next:'.banner .slide-next'
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


		$('.settings .delete').on('click', function(event){
			event.preventDefault();
			if($(this).closest('fieldset').is('.social-connections')){
				$(this).hide().siblings('.value').html('<em>Not connected</em>');
			}else{
				$(this).hide().closest('.row').hide();
			}
		});

    $(document).bind('cbox_closed', function(){ 
      history.back();
    });

	});//document ready event

	$win.on('load', function(){
		Header.pos();
		sectionScroll();
    
    //var offer_id_if_present = location.pathname.match(/\/offer\/(\d+)/);
    if(location.pathname != '/' && $body.data('meta') === 'home#index')
    {
      popupOpen('/deal_popup_not_logged'+location.pathname);
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
				step:0.5,
				slide: function(event, ui){
					if($slider.closest('.pay-box').length){
						$slider.closest('.pay-box').find('.field').val(ui.value).trigger('change');
					}
				}
			});
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
			$fieldset.find('.field').each(function(){
				var $self = $(this);
				$self.siblings('.value').text($self.val());
				if($self.val().length){
					$self.siblings('.delete').show();
				}
			});
			this.closeEdit($fieldset);

		},
		closeEdit: function($fieldset){
			$fieldset.removeClass('editing').find('.edit span').text('edit');
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
				itemSelector:'.tile',
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
					aFilter.push('.' + $(this).val());
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
			$('.postcard .' + arr[i].name).text(arr[i].value);
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
