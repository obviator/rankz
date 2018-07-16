$(document).on('turbolinks:load', function () {
 $('#teamFilterSearch').keyup(filterTeams);
});

function filterTeams() {
    var $filter = $("#teamFilterSearch").val().toUpperCase();

    $('[data-behavior~=searchable]').remove();


    // for (i = 0; i < tr.length; i++) {
    //     td = tr[i].getElementsByTagName("td")[0];
    //     if (td) {
    //         if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
    //             tr[i].style.display = "";
    //         } else {
    //             tr[i].style.display = "none";
    //         }
    //     }
    // }
}