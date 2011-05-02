<?php
/**
 * @author G. Giunta
 * @version $Id$
 * @copyright (C) 2011 G. Giunta
 *
 * @todo set up some perms checking
 */

$ViewList = array(
    'channel.xml' => array(
        //'functions' => array( 'elevate' ),
        'script' => 'channel.xml.php',
        'params' => array() ),
    'c' => array(
        //'functions' => array( 'elevate' ),
        'script' => 'categories.php',
        'params' => array( 'category', 'file' ) ),
    'm' => array(
        //'functions' => array( 'elevate' ),
        'script' => 'maintainers.php',
        'params' => array( 'maintainer', 'file' ) ),
    'p' => array(
        //'functions' => array( 'elevate' ),
        'script' => 'packages.php',
        'params' => array( 'package', 'file' ) ),
    'r' => array(
        //'functions' => array( 'elevate' ),
        'script' => 'releases.php',
        'params' => array( 'package', 'file' ) ),
);

$FunctionList = array();

?>
