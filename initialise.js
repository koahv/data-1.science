$(document).ready( function () {
    $('#example').dataTable( {
	"dom": 'C<"clear">lfrtip',
        "order": [[ 0, "desc" ]],
        "pageLength": 100,
    } );
} );

	/*
	columnDefs: [ {
		targets: [ 0 ],
		orderData: [ 0, 1 ]
	} ]
	*/








/*

$(document).ready(function() {
    $('#example').dataTable( {
        columnDefs: [ {
            targets: [ 0 ],
            orderData: [ 0, 1 ]
        } ]
    } );
} );

*/



/*
 *  *  * Example initialisation
 *   *   */

/*
 * $(document).ready( function () {
    $('#example').DataTable( {
        "dom": 'C<"clear">lfrtip',
	"order": [[ 0, "desc" ]],
	"pageLength": 22
    } );
} );

*/

/*$document).ready(function() {
    $('#example').dataTable( {
        "order": [[ 0, "desc" ]]
    } );
} );
*/



/*
$(document).ready(function() {
    $('#example').DataTable( {
        ajax:           "2500.txt",
        deferRender:    true,
        dom:            "frtiS",
        scrollY:        200,
        scrollCollapse: true
    } );
} );
*/


