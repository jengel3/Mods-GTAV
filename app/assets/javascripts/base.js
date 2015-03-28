$(document).ready(function(){
	// $.mobile.loading().hide();
	// $(".mobile_dropdown_menu").hide();

	// $('.mobilemenulink').on('click', function() {
	// 	$('.mobile_dropdown_menu').slideToggle(100);

	// }); 

	// $('.default_theme').on('click', function() {
	// 	$('.accentcolor').css('background-color', '#ff4200');
	// 	$('.accentborder').css('border-color', '#ff4200');
	// });

	// $('.blue_theme').on('click', function() {
	// 	$('.accentcolor').css('background-color', '#66a3ff');
	// 	$('.accentborder').css('border-color', '#66a3ff');
	// });

	// $('.green_theme').on('click', function() {
	// 	$('.accentcolor').css('background-color', '#41b64c');
	// 	$('.accentborder').css('border-color', '#41b64c');
	// });

	// $('.orange_theme').on('click', function() {
	// 	$('.accentcolor').css('background-color', '#ff6666');
	// 	$('.accentborder').css('border-color', '#ff6666');
	// });

$('.tooltip').tooltipster({
	theme: 'tooltipster-light'
});
});

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