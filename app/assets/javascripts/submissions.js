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
	console.warn('Display page discovered.')
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
			},
			dataType: 'json'
		});
	});
}
});