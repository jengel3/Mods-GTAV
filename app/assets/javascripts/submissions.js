$(document).ready(function() {
  var uploadStarted = false;
  var fileCount = 0;
  if ($('#fileupload').length) {
    $('#fileupload').fileupload({
      dataType: 'json',
      done: function(e, data) {
        $("#upload_btn").off('click');
      },
      add: function(e, data) {
        $('.open-screenshot').magnificPopup('open');
        $("#upload_btn").on('click', function() {
          data.submit();
          if (!uploadStarted) {
            $('.progress-bar').css('display', 'inherit');
            uploadStarted = true;
          }
        });
        $.each(data.files, function(index, file) {
          var body = $('#file-table');
          file.context = $('<tr><td><div class="imgwrap"><img src="' + URL.createObjectURL(file) + '"/></div></td><td>' + file.name + '</td><td>' + humanFileSize(file.size) + '</td><td>' + $('.upload_select').html() + '</td></tr><tr class="spacer"></tr>').appendTo(body);
          if (fileCount === 0) {
            file.context.find('select').val("Main");
          }
          fileCount += 1;
        });
      },
      submit: function(e, data) {
        $.each(data.files, function(index, file) {
          var target = $(file.context).find('td').last().children()[0];
          var val = target.options[target.selectedIndex].value;
          data.formData = {
            location: val
          };
        });
      },
      progressall: function(e, data) {
        var progress = parseInt(data.loaded / data.total * 100, 10);
        $('.progress-bar span').text(progress + '%');
        $('.progress-bar span').css('width', progress + '%');
        if (progress >= 100) {
          $('.progress-bar span').text('Upload complete! Refreshing...');
          setTimeout(function() {
            location.reload();
          }, 1000);
        }
      }
    });
    $('.close').click(function(e){
      e.preventDefault();
      e.stopPropagation();
      var url = $(e.target).attr('href');
      $.ajax({
        type: "DELETE",
        url: url,
        success: function(data, status, xhr) {
          if (data.status === 'destroyed') {
            $(e.target).parent().fadeOut("slow", function() {
              this.remove();
            });
          } else {
            console.error('Error:', data);
          }
        },
        dataType: 'json'
      });
    });
    $('.open-screenshot').magnificPopup({
      type: 'inline',
      midClick: true,
      removalDelay: 500,
      mainClass: 'mfp-zoom-in'
    });
    $('.uploadmod_individual_screenshot_wrap').click(function(e) {
      e.preventDefault();
      $('.open-screenshot').magnificPopup('open');
    });

    $('.open-file').magnificPopup({
      type: 'inline',
      midClick: true,
      removalDelay: 500,
      mainClass: 'mfp-zoom-in'
    });
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
          if (data.status === 'not authenticated') {
            $('#rating').text('Log in to rate content!');
          } else if (data.status === 'can not rate own content') {
            $('#rating').text('You can not rate this!');
          } else {
            $('#rating').text(Math.abs(data.count) + ' ' + (Math.abs(data.count) === 1 ? 'person' : 'people') + ' ' + (data.count < 0 ? 'dislike' : 'like') + (Math.abs(data.count) === 1 ? 's' : '') + ' this mod');
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
          if (data.status === 'not authenticated') {
            $('#rating').text('Log in to rate content!');
          } else if (data.status === 'can not rate own content') {
            $('#rating').text('You can not rate this!');
          } else {
            $('#rating').text(Math.abs(data.count) + ' ' + (Math.abs(data.count) === 1 ? 'person' : 'people') + ' ' + (data.count < 0 ? 'dislike' : 'like') + (Math.abs(data.count) === 1 ? 's' : '') + ' this mod');
          }
        },
        dataType: 'json'
      });
    });

    $('.contentpage_screenshot').click(function(e) {
      e.preventDefault();
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
      mouseenter: function() {
        $('.likecomment_button', this).show();
      },
      mouseleave: function() {
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
        $.each(data, function(key, val) {
          var template = $('.comment-template').html();
          template = template.replace('{{username}}', val['user']['username']).replace('{{count}}', 0).replace('/{{liked}}/g', 'liked_comment').replace('{{id}}', val['id']).replace('{{text}}', val['text'])
          var new_comment = $(parent).before(template);
          $('.likecomment_button').off();
          $('.likecomment_button').click(likeComment);
        });
      });
    }
    $('.load_comments_wrap').click(loadComments);

    function likeComment(e) {
      e.preventDefault();
      $.ajax({
        type: "POST",
        url: $(e.target).attr('data-url'),
        success: function(data, status, xhr) {
          if (data.status === 'removed like') {
            $(e.target).removeClass('liked_comment');
            $(e.target).parent().removeClass('liked_comment');
          } else if (data.status == 'liked comment') {
            $(e.target).addClass('liked_comment');
            $(e.target).parent().addClass('liked_comment');
          } else {
            return;
          }
          var parent = $(e.target).parent();
          var a = $(parent).find('a');
          $(parent).html('+' + data.count);
          $(parent).append(a);
          a.click(likeComment);
        },
        dataType: 'json'
      });
    }
    $('.likecomment_button').click(likeComment);
  }
});