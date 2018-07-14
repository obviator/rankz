$(document).on('turbolinks:load', function () {
    $body_classes = $("body").attr("class").split(/\s+/);
    $match = '';
    $.each($body_classes, function (index, value) {
        if (/^(?:cont|act)$/.test(value.split('_')[0])) {
            $match += '-' + value.split('_')[1];
        }
    });
    $('a.nav-link.nav' + $match).addClass('active');
})

