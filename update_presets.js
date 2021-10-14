'use strict';

/* 20211014 RMB
 * example adapted to write individual files from a json presets.
 * and then u
 * 
 * sample usage:
 * 
 * mkdir presets
 * curl acs/presets -X GET > presets.json
 * node update_presets.js > upload_script.sh
 * 
 */

const fs = require( 'fs' );

fs.readFile( 'presets.json', 'utf8', function ( err, data ){
    if( err ){
        console.log( err );
        process.exit();
    }
    write_all_presets( data );
} );


function write_all_presets( data ){
    let json = JSON.parse( data );

    for( var x in json ){
        var preset_name = json[x]["_id"];
        var preset_body = JSON.stringify( json[x], null, 4 );
        write_preset( preset_name, preset_body );
    }
}


/* it uses a directory (which must exist first) to create each file 
 * and then writes a sample command to stdout via console.log
 */
function write_preset( filename, body ){
    // if directory does not exists, throws exception
    fs.writeFile( "presets/" + filename, body, function ( err ){
        if( err ){
            console.log( err );
            process.exit();
        }
        // chars \t are optional, just to make output a bit more readable
        console.log( 'curl acstest:7557/presets/' + filename + ' \t \t -X PUT --data-binary "@presets/' + filename + '" ' );
    } );
}
