$(document).ready(function () {
	var willUploadCount = 0;
	var uploadedCount = 0;
	var uploadStarted = false;
	if ($('#fileupload').length) {
		$('#fileupload').fileupload({
			dataType: 'json',
			done: function (e, data) {
				$("#upload_btn").off('click');
				uploadedCount += 1;
				if (uploadedCount == willUploadCount) {
					$('.progress-bar span').text('Upload complete! Refreshing...'); 
					setTimeout(function(){ 
						location.reload();
					}, 1000);
				}
			},
			add: function (e, data) {
				$('.open-screenshot').magnificPopup('open');
				$("#upload_btn").on('click', function () {
					data.submit();
					if (!uploadStarted) {
						$('.progress-bar').css('display', 'inherit');
						uploadStarted = true;
					}
				});
				$.each(data.files, function (index, file) {
					var body = $('#file-body');
					file.context = $('<tr><td class="img_td"><img class="upload_preview" height="60" src="' + URL.createObjectURL(file) + '"/></td><td>' + file.name + '</td><td>' + humanFileSize(file.size) + '</td><td>' + $('.upload_select').html() + '</td></tr>' ).appendTo(body);
				});
				willUploadCount += 1;
			},
			submit: function(e, data) {
				$.each(data.files, function (index, file) {
					var target = $(file.context).find('td').last().children()[0];
					var val = target.options[target.selectedIndex].value;
					data.formData = {location: val};
				});
			},
			progressall: function (e, data) {
				var progress = parseInt(data.loaded / data.total * 100, 10);
				$('.progress-bar span').text(progress + '%');
				$('.progress-bar span').css('width', progress + '%');
			}
		});
$('.open-screenshot').magnificPopup({
	type:'inline',
	midClick: true,
	mainClass: 'mfp-fade'
});
$('.uploadmod_individual_screenshot_wrap').click(function(e) {
	e.preventDefault();
	$('.open-screenshot').magnificPopup('open');
})
} else if ($('.downloadbutton_link').length) {
	// Likes and dislikes
	$('#like').click(function() {
		$.ajax({
			type: "POST",
			url: $('#like').attr('data-url'),
			success: function(data, status, xhr) {
				if (data.status === 'removed like') {
					$('#like').css('border', '1px solid #c2c2c2');
					$('#like img').addClass('grayscale');
				} else if (data.status == 'liked submission') {
					$('#like').css('border', '1px solid #8fc78b');
					$('#dislike').css('border', '1px solid #c2c2c2');
					$('#dislike img').addClass('grayscale');
					$('#like img').removeClass('grayscale');
				}
				$('#rating').text(Math.abs(data.count) + ' ' + ((data.count > 1 || data.count == 0) ? 'people' : 'person') + ' ' + (data.count < 0 ? 'dislike' : 'like') + (Math.abs(data.count) === 1 ? 's' : '') + ' this mod');
			},
			dataType: 'json'
		});
	});

	$('#dislike').click(function() {
		$.ajax({
			type: "POST",
			url: $('#dislike').attr('data-url'),
			success: function(data, status, xhr) {
				if (data.status === 'removed dislike') {
					$('#dislike').css('border', '1px solid #c2c2c2');
					$('#dislike img').addClass('grayscale');
				} else if (data.status == 'disliked submission') {
					$('#dislike').css('border', '1px solid #4DA2DE');
					$('#like').css('border', '1px solid #c2c2c2');
					$('#like img').addClass('grayscale');
					$('#dislike img').removeClass('grayscale');
				}
				$('#rating').text(Math.abs(data.count) + ' ' + ((data.count > 1 || data.count == 0) ? 'people' : 'person') + ' ' + (data.count < 0 ? 'dislike' : 'like') + (Math.abs(data.count) === 1 ? 's' : '') + ' this mod');
			},
			dataType: 'json'
		});
	});

	$('.screen_wrapper').click(function(e) {
		e.preventDefault();
		console.log(e);
		var src = '';
		src = $(e.target).attr('src');
		var new_src = src.replace('thumb_', '');
		$('.contentpage_mainthumb img').attr('src', new_src);
	});

	// Random display options
	$('.collapse_description_icon').on('click', function() {
		$('.contentpage_descriptionwrap').addClass('collapse_description');
		$('.contentpage_commentswrap').addClass('commentswrap_expanded');
		$('.expand_description').addClass('expand_description_show_icon');
	});

	$('.expand_description').on('click', function() {
		$('.contentpage_descriptionwrap').removeClass('collapse_description');
		$('.contentpage_commentswrap').removeClass('commentswrap_expanded');
		$('.expand_description').removeClass('expand_description_show_icon');
	});


	// Comments
	$(".usercommentwrap").on({
		mouseenter: function () {
			$('.likecomment_button', this).show();
		},
		mouseleave: function () {
			$('.likecomment_button', this).hide();
		}
	});

	var current_page = 1;
	function loadComments() {
		var api_url = $('.contentpage_commentswrap').attr('data-api');
		var sort = $('.contentpage_commentswrap').attr('data-sort');

		current_page += 1;
		$.getJSON(api_url + '?c_sort=' + sort + '&c_page=' + current_page, function(data) {
			var parent = $('.load_comments_wrap');
			$.each( data, function( key, val ) {
				$(parent).before("<div class='usercommentwrap'><div class='commentname'>" + val['user']['username'] + " <div class='likecomment_score'>+3 <a href='' class='likecomment_button'>Like</a></div></div><div class='commenttext'>" + val['text'] + "</div></div>")

			});
		});
	}
	$('.load_comments_wrap').click(loadComments);
}
});