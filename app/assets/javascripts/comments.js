var lastCall = new Date();
console.log(lastCall.getTime());

function loadComments() {

	var api_url = $('.contentpage_commentswrap').attr('data-api');
	var sort = $('.contentpage_commentswrap').attr('data-sort');

	console.log(api_url)

	$.getJSON(api_url + '?c_sort=' + sort + '&after=' + lastCall.getTime(), function( data ) {
		console.log(data);
	});
}

loadComments();