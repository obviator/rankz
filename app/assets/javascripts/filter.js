$(document).on('turbolinks:load', function () {
    $filterBox = $('#filter-search');

    if ($('[data-behavior~=filterable]').length) {
        $filterBox.keyup(filterObjects);
        $filterBox.show();
    }
    else {
        $filterBox.hide();
    }

});

function filterObjects() {
    let $filter = $("#filter-search").val().toUpperCase();

    $('[data-behavior~=filterable]').each(function (i, object) {
        let $object = $(object);
        let $match = false;
        $object.find('[data-behavior~=searchable]').each(function (i, item) {
            let $item = $(item);
            if ($item.text().toUpperCase().indexOf($filter) > 0) {
                $match = true;
            }
        });
        if ($match || !$filter) {
            $object.addClass('animated').show();
        }
        else {
            $object.hide();
        }
    });
}