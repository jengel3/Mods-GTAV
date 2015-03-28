$(document).ready(function () {
	if ($('#fileupload').length) {
		$('#fileupload').fileupload({
			dataType: 'json',
			done: function (e, data) {
				$("#upload_btn").off('click')
			},
			add: function (e, data) {
				$('.open-screenshot').magnificPopup('open');
				$("#upload_btn").on('click', function () {
					data.submit();
				});
				$.each(data.files, function (index, file) {
					var select = '';
					var body = $('#file-body');
					file.context = $('<tr><td class="img_td"><img class="upload_preview" height="60" src="' + URL.createObjectURL(file) + '"/></td><td>' + file.name + '</td><td>' + humanFileSize(file.size) + '</td><td>' + $('.upload_select').html() + '</td></tr>' ).appendTo(body);
				});
			},
			submit: function(e, data) {
				$.each(data.files, function (index, file) {
					console.log(file.context)
					var target = $(file.context).find('td').last().children()[0];
					var val = target.options[target.selectedIndex].value;
					console.log(val);
					data.formData = {location: val};
				});
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
	}
});