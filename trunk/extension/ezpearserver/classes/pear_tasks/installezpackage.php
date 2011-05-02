<?php
/**
 * A class implementing the PEAR Task API, dedicated to installation of eZ Package files
 *
 * @version $Id$
 * @copyright 2011
 */

class installeZPackage
{
    function init( /*$config, $pkg, $version*/ )
    {
        echo "Init called! ";
        var_dump( func_get_args() );
        return true;
    }

    function run( /*$params, $group*/ )
    {
        echo "Run called! ";
        var_dump( func_get_args() );
    }
}
?>