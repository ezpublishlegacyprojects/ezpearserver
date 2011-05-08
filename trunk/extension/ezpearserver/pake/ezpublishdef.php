<?php
/**
 * Definition for building as PEAR package eZP itself
 * Ideally we should use the ezextbuilder extension to derive this
 *
 * @version $Id$
 * @copyright (C) 2011
 */

$rootdir = '';
while( !is_dir( $rootdir ) )
{
    echo "Enter directory where eZ Publish is installed (q to quit): ";
    $rootdir = fgets( STDIN );
    $rootdir = trim( $rootdir, "\n\r" );
    if ( $rootdir == 'q' )
    {
        exit( 1 );
    }
}

return array(
    'name' => 'ezpublish_community_project',
    'channel' => 'share.ez.no',
    'summary' => 'eZ Publish Community Project',
    'description' => 'The eZ Publish CMS allows ...',
    'date' => time(),
    'leads' => array( /// @todo
        array( 'name' => 'gggeek', 'user' => 'gggeek', 'email' => 'gg@ez.no', 'active' => true ),
        array( 'name' => 'oms', 'user' => 'oms', 'email' => 'oms@ez.no', 'active' => true ),
        array( 'name' => 'jeanvoye', 'user' => 'jeanvoye', 'email' => 'nfrp@ez.no', 'active' => true ) ),
    'developers' => array(), /// @todo
    'contributors' => array(), /// @todo
    'helpers' => array(), /// @todo
    'version' => array( 'release' => '4.2011', 'api' => '4.2011' ),
    'stability' => array( 'release' => 'stable', 'api' => 'stable' ),
    'license' => 'GNU General Public License v2.0',
    'notes' => '1st version to be released as PEAR package',
    'contents' => array(
        array(
            'name' => '/',
            'dirs' => array( dirscan( $rootdir, '' ) ),
            'files' => array()
        )
    ),
    'phprelease' => array(),
    'dependencies' => array(
        'php' => array( 'min' => '5.2.1' ), /// @todo check min reqs for ezp 4.0
        'pearinstaller' => array( 'min' => '1.4.1' ),
        'required' => array(
            'packages' => array(),
            // from http://ez.no/eZPublish/Requirements/eZ-Publish-4.4-Platform-requirements
            'extensions' => array(
                array( 'name' => 'pcre' ),
                array( 'name' => 'curl' ),
                array( 'name' => 'iconv' ),
                array( 'name' => 'mbstring' ),
                array( 'name' => 'fileinfo' ),
                array( 'name' => 'reflection' ),
                array( 'name' => 'spl' ),
                array( 'name' => 'zlib' ),
                /* 'posix', */
                array( 'name' => 'bz2' ),
                array( 'name' => 'dom' ),
                array( 'name' => 'exif' ),
                array( 'name' => 'json' ),
                array( 'name' => 'simplexml' ),
                array( 'name' => 'xmlreader' ),
            )
        ),
        'optional' => array(
            'packages' => array(),
            'extensions' => array(
                array( 'name' => 'mysql' ),
                array( 'name' => 'mysqli' ),
                array( 'name' => 'pgsql' ),
                array( 'name' => 'oci8' ),
                array( 'name' => 'apc' )
            ),
        )
    ),
    'changelog' => array() /// @todo
);

/// recursively scan dirs for contents, returning array in proper ezpearpackage format
function dirscan( $rootdir, $rootpath )
{
    $dirs = array();
    $files = array();
    foreach( scandir( $rootdir ) as $item )
    {
        if ( is_dir( "$rootdir/$item" ) )
        {
            if ( $item != '.' && $item != '..' )
            {
                $dirs[] = dirscan( "$rootdir/$item", $rootpath );
            }
        }
        else
        {
            $files[] = array( 'name' => $item, 'role' => 'www' );
        }
    }
    return array(
        'name' => basename( $rootdir ),
        'dirs' => $dirs,
        'files' => $files
    );
}

?>