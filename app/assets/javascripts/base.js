function doResize() {
	if ($(window).width() <= 1160){  
		$('.right_sidebar_preview, .right_sidebar').on('click', function() {
			toggleSidebar();
		});
	}
}

function toggleSidebar() {
	var preview = $('.right_sidebar_preview');
	var	sidebar = $('.right_sidebar');
	if (preview.hasClass('showsidebarpreview')) {
		localStorage.setItem('sidebar', false);
	} else {
		localStorage.setItem('sidebar', true);
	}
	toggleSidebarClasses();
}

function toggleSidebarClasses() {
	$('.right_sidebar_preview').toggleClass('showsidebarpreview');
	$('.right_sidebar').toggleClass('showsidebar');
}

function handleSidebarLoad() {
	var val = localStorage.getItem('sidebar');
	if (val && val === "true") {
		toggleSidebarClasses();
	}
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
};

$(document).ready(function(){
	$('.submissiondate').hide();
	$('.inputwrap').hide();
	$('.resetpasswordwrap').hide();		

	$('.registerbutton').on('click', function() {
		$('.signinwrap').hide();
		$('.resetpasswordwrap').hide();
		$('.registerwrap').fadeIn(200);
	});
	$('.signinlink').on('click', function() {
		$('.registerwrap').hide();
		$('.resetpasswordwrap').hide();
		$('.signinwrap').fadeIn(200);
	});
	$('.forgotlink').on('click', function() {
		$('.signinwrap').hide();
		$('.registerwrap').hide();
		$('.resetpasswordwrap').fadeIn(200);
	});
	$('.tooltip').tooltipster({
		theme: 'tooltipster-light'
	});
	doResize();
	$(window).on('resize', doResize);
	handleSidebarLoad();  
});

doResize();
$(window).on('resize', doResize);  