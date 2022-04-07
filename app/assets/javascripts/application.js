// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require turbolinks
//= require_tree .

$(document).on('turbolinks:load', function() {
    $(function() {
        $('.tab').click(function(){
            $('.tab-active').removeClass('tab-active');
            $(this).addClass('tab-active');
            $('.box-show').removeClass('box-show');
            const index = $(this).index();
            $('.tabbox').eq(index).addClass('box-show');
        });
        $('#attachment .fileinput').on('change', function () {
            var file = $(this).prop('files')[0];
            $(this).closest('#attachment').find('.filename').text(file.name);
        });
        function buildHTML(image) {
            var html =
                `
                <div class="prev-content">
                    <img src="${image}", alt="preview" class="prev-image">
                </div>
                `
            return html;
        }
        $(document).on('change', '.hidden_file', function () {
            var file = this.files[0];
            var reader = new FileReader();
            reader.readAsDataURL(file);
            reader.onload = function () {
              var image = this.result;
              if ($('.prev-content').length == 0) {
                var html = buildHTML(image)
                $('.prev-contents').prepend(html);
                $('.photo-icon').hide();
              } else {
                $('.prev-content .prev-image').attr({ src: image });
              }
            }
        });
    });
});


