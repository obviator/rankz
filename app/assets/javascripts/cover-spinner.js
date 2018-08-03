$(document).on('turbolinks:load', function () {
    $('[data-behavior~=cover-spin]').on('click', function(){
        $('#cover-spin').show();
    });
});
