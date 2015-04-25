$(document).ready(function() {
	var page = 1;
	var continueScroll = true;
	var isLoading = false;
	if ($('.homepage_recent_mods_wrap').length) {
		$(window).scroll(function() {
			if (!continueScroll || $('#scroll-done').length) {
				continueScroll = false;
				return;
			}
			if(continueScroll && $(window).scrollTop() + $(window).height() > $(document).height() - 25) {
				if (!isLoading) {
					isLoading = true;
					setTimeout(function() {
						page += 1;
						loadMore(page, function() {
							isLoading = false;
							$('.submissiondate').hide();
							$('.likecounter').hide();
							$(".time").timeago();
							updateTimestamps();
						});
					}, 500);
				}
			}
		});
	}

	$('.add-comm-video').magnificPopup({
		type: 'inline',
		midClick: true,
		removalDelay: 500,
		mainClass: 'mfp-zoom-in'
	});

	$('#video_url').keyup(function(e) {
		try {
			var yurl = $(e.target).val();
			var id = yurl.split('v=')[1].substring(0, 11);
			var thumb = 'https://img.youtube.com/vi/' + id + '/mqdefault.jpg'
			$("#vidimg img").attr('src', thumb);
			$("#vidurl a").attr('href', yurl);
			$("#vidurl a").text(yurl);
			$("#vidid").text(id);
			$('.vid-display').css('display', 'inline');
			$('#videoerrors').fadeOut(100);
		} catch (e) {
			$('.vid-display').css('display', 'none');
			$('#videoerrors').text("Unable to load thumbnail. Confirm the ID is valid.");
			$('#videoerrors').css('display', 'block');
		}
	});
})


function loadMore(page, callback) {
	$.getScript($('.homepage_recent_mods_wrap').attr('data-url') + '?page=' + page, function( data, textStatus, jqxhr ) {
		callback();
	});
}
