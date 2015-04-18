function doResize() {
	if ($(window).width() <= 1160) {  
		$('.right_sidebar_preview, .close_sidebar').on('click', function(e) {
			e.preventDefault();
			toggleSidebar();
		});
	}
}

function toggleSidebar() {
	$('.right_sidebar_preview').toggleClass('showsidebarpreview');
	$('.right_sidebar').toggleClass('showsidebar');
}


function humanFileSize(bytes, si) {
	var thresh = si ? 1000 : 1024;
	if(bytes < thresh) return bytes + ' B';
	var units = si ? ['kB','MB','GB','TB','PB','EB','ZB','YB'] : ['KiB','MiB','GiB','TiB','PiB','EiB','ZiB','YiB'];
	var u = -1;
	do {
		bytes /= thresh;
		++u;
	} while(bytes >= thresh);
	return bytes.toFixed(1)+' '+units[u];
}

$(document).ready(function() {
	$('.submissiondate').hide();
	$('.likecounter').hide();

	$(".modthumbnailwrap").on({
		mouseenter: function () {
			$('.likecounter', this).stop().fadeIn(200);
			$('.submissiondate', this).stop().fadeIn(200);
		},
		mouseleave: function () {
			$('.likecounter', this).fadeOut(20);
			$('.submissiondate', this).stop().fadeOut(100);
		}
	});

	$(".likecounter").on({
		mouseenter: function () {
			$(this).stop().animate({background: 'transparent'}, 'fast');
			$(this).stop().animateAuto("width", 100);
		},
		mouseleave: function () {
			$(this).stop().animate({width: '40px'}, 'fast');
		}
	});

	$('.right_sidebar .registerbutton').on('click', function() {
		$('.right_sidebar .signinwrap').hide();
		$('.right_sidebar .resetpasswordwrap').hide();
		$('.right_sidebar .registerwrap').fadeIn(200);
		$('.right_sidebar .registerwrap #user_email').focus();
	});
	$('.right_sidebar .signinlink').on('click', function() {
		$('.right_sidebar .registerwrap').hide();
		$('.right_sidebar .resetpasswordwrap').hide();
		$('.right_sidebar .signinwrap').fadeIn(200);
		$('.right_sidebar .signinwrap #user_login').focus();
	});
	$('.right_sidebar .forgotlink').on('click', function() {
		$('.right_sidebar .signinwrap').hide();
		$('.right_sidebar .registerwrap').hide();
		$('.right_sidebar .resetpasswordwrap').fadeIn(200);
		$('.right_sidebar .resetpasswordwrap #user_email').focus();
	});
	$('.tooltip').tooltipster({
		theme: 'tooltipster-light'
	});
	function removeAlert() {
		$('.alert').fadeOut("slow", function() {
			this.remove();
		});
	};

	$('.close-alert').click(function(e) {
		e.preventDefault();
		removeAlert();
	});

	if ($('.close-alert').length) {
		setTimeout(function() {
			removeAlert();
		}, 10000)
	};

	doResize();
	$(window).on('resize', doResize);

	$('.open-contact').magnificPopup({
		type: 'inline',
		midClick: true,
		removalDelay: 500,
		mainClass: 'mfp-zoom-in'
	});

	$(document).on('submit', 'form#sign_in', function(e) {
	}).on('ajax:success', 'form#sign_in', function(e, data, status, xhr) {
		location.reload(true);
	}).on('ajax:error', 'form#sign_in', function(e, data, status, xhr) {
		error = data.responseJSON.error;
		var errorList = $('.sidebar_login_errors');
		$(errorList).text(error);
		$(errorList).css('display', 'block');
		$(errorList).shake();
	});

	$(document).on('submit', 'form#register', function(e) {
	}).on('ajax:success', 'form#register', function(e, data, status, xhr) {
		location.reload(true);
	}).on('ajax:error', 'form#register', function(e, data, status, xhr) {
		errorResponse = data.responseText;
		var errs = renderErrors(errorResponse);
		var errorList = $('.sidebar_login_errors');
		$(errorList).html(errs);
		$(errorList).css('display', 'block');
		$(errorList).shake();
	});

	$(document).on('submit', 'form#password', function(e) {
	}).on('ajax:success', 'form#password', function(e, data, status, xhr) {
		var wrap = $(e.target).parent();
		$(wrap).find('.error').addClass('notice').text("Email sending!");
		$(wrap).find('.notice').fadeIn("slow");
		setTimeout(function() {
			location.reload(true);
		}, 1500);
	}).on('ajax:error', 'form#password', function(e, data, status, xhr) {
		errorResponse = data.responseText;
		var errs = renderErrors(errorResponse);
		var errorList = $('.sidebar_login_errors');
		$(errorList).html(errs);
		$(errorList).css('display', 'block');
		$(errorList).shake();
	});


	if ($('.onpagelogintitles').length) {
		$(document).on('submit', 'form#sign_in_combine', function(e) {
		}).on('ajax:success', 'form#sign_in_combine', function(e, data, status, xhr) {
			location.href = '/';
		}).on('ajax:error', 'form#sign_in_combine', function(e, data, status, xhr) {
			error = data.responseJSON.error;
			var wrap = $('.loginerrorcodes');
			$(wrap).text(error);
			$(wrap).css('display', 'block');
			$(wrap).shake();
		});

		$(document).on('submit', 'form#register_combine', function(e) {
		}).on('ajax:success', 'form#register_combine', function(e, data, status, xhr) {
			location.href = '/';
		}).on('ajax:error', 'form#register_combine', function(e, data, status, xhr) {
			errorResponse = data.responseText;
			var errs = renderErrors(errorResponse);
			var wrap = $('.loginerrorcodes');
			$(wrap).html(errs);
			$(wrap).css('display', 'block');
			$(wrap).shake();
		});

		$(document).on('submit', 'form#password_combine', function(e) {
		}).on('ajax:success', 'form#password_combine', function(e, data, status, xhr) {
			var wrap = $(e.target).parent();
			$(wrap).find('.error').addClass('notice').text("Email sending! Refreshing..");
			$(wrap).find('.notice').fadeIn("slow");
			setTimeout(function() {
				location.href = '/';
			}, 1500);
		}).on('ajax:error', 'form#password_combine', function(e, data, status, xhr) {
			errorResponse = data.responseText;
			var errs = renderErrors(errorResponse);
			var wrap = $('.loginerrorcodes');
			$(wrap).html(errs);
			$(wrap).css('display', 'block');
			$(wrap).shake();
		});
	}
});

function renderErrors(text) {
	var parsed = JSON.parse(text);
	var formattedErrors = [];
	$.each(parsed['errors'], function( index, value ) {
		var field_name = index;
		var errors = value;
		var uniqueErrors = [];
		$.each(errors, function(i, el){
			if($.inArray(el, uniqueErrors) === -1) { 
				uniqueErrors.push(el);
				var formatted = capitaliseFirstLetter(field_name.replace('_', ' ')) + " " + el;
				formattedErrors.push(formatted + "<br>");
			}
		});        
	});
	return formattedErrors;

	function capitaliseFirstLetter(str) {
		return str.charAt(0).toUpperCase() + str.slice(1);
	}
}