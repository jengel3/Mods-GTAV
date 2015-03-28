$(document).ready(function () {
	if ($('#fileupload').length) {
		$('#fileupload').fileupload({
			dataType: 'json',
			done: function (e, data) {
				$("#upload_btn").off('click')
			},
			add: function (e, data) {
				$('.open-screenshot').magnificPopup('open');
				console.log(e, data)
				$("#upload_btn").on('click', function () {
					data.submit();
				});
				$.each(data.files, function (index, file) {
					var select = '';
					file.context = $('#file-body').append( '<tr><td class="img_td"><img class="upload_preview" height="60" src="' + URL.createObjectURL(file) + '"/></td><td>' + file.name + '</td><td>' + humanFileSize(file.size) + '</td><td>' + $('.upload_select').html() + '</td></tr>' );
				});
			},
			submit: function(e, data) {
				$.each(data.files, function (index, file) {
					console.log(file)
					var target = $(file.context).find('tr').find('td').last().children()[0];
					var val = target.options[target.selectedIndex].value;
					data.formData = {location: val};
				});
			}
		});
		$(document).ready(function() {
			$('.open-screenshot').magnificPopup({
				type:'inline',
				midClick: true,
				mainClass: 'mfp-fade'
			});
		});
	}
});