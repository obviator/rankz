$(document).on('turbolinks:load', function () {
    $('#teamFilterSearch').keyup(filterTeams);
    $('[data-behavior~=cover-spin]').on('click', function(){
        $('#cover-spin').show();
    });
});

function filterTeams() {
    let $filter = $("#teamFilterSearch").val().toUpperCase();

    $('[data-behavior~=searchable-table]').each(function (i, table) {
        let $table = $(table);
        let $match = false;
        $table.find('[data-behavior~=searchable-cell]').each(function (i, td) {
            if ($(td).text().toUpperCase().indexOf($filter) > 0) {
                $match = true;
            }
        });
        if ($match || !$filter) {
            $table.addClass('animated').show();
        }
        else {
            $table.hide();
        }
    });
}