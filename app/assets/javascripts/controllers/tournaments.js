$(document).on('turbolinks:load', function () {

    $('#add-tiebreaker-select').change(onSelectChange);

    $('#tiebreaker-list div.alert').on('closed.bs.alert', onAlertClose);
});


function onAlertClose() {
    $("#add-tiebreaker-select").append(
        $('<option></option>').val($(this).find('input#tournament_tiebreaker_').val()).html($(this).find('strong').html())
    );

}

function onSelectChange() {
    var $last = $('#tiebreaker-list div.alert').last();

    $last = $last.clone().appendTo('#tiebreaker-list');

    $last.find('strong').html($(this).find(':selected').text());
    $last.find('input#tournament_tiebreaker_').val(this.value);
    $last.addClass('alert-secondary');
    $last.removeClass('alert-success');
    $last.addClass('animated zoomIn');
    $last.on('closed.bs.alert', onAlertClose);
    window.scrollBy(0,64);

    $("#add-tiebreaker-select option[value='" + this.value + "']").remove();
}