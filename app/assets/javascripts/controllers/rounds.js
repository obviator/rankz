$(document).on('turbolinks:load', function () {
    $('#teamFilterSearch').keyup(filterTeams);
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
            $table.show();
        }
        else {
            $table.hide();
        }
    });
}