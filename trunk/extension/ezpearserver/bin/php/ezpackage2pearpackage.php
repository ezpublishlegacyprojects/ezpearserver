<?php
/**
 * Converts an ezp package file into a pear package file
 *
 * @version $Id$
 * @copyright 2011
 */

require 'autoload.php';

$cli = eZCLI::instance();
$script = eZScript::instance( array( 'description' => '...',
                                     'use-session' => false,
                                     'use-modules' => false,
                                     'use-extensions' => true ) );
$script->startup();
$options = $script->getOptions( '', // options
                                '[input-file][output-file]', // params
                                array() ); // help
$script->initialize();

if ( count( $options['arguments'] ) < 2 )
{
    $cli->error( 'Please specify a file to convert and a target file' );
    $script->shutdown( 1 );
}

$infile = $options['arguments'][1];
$outfile = $options['arguments'][2];

$package = eZPackage::fetchFromFile( $infile );
if ( !$package )
{
    $cli->error( "File $infile is not a valid eZPublish package" );
    $script->shutdown( 1 );
}

$pear_package = eZPearPackageManager::fromeZPackage( $package );

$tpl = templateInit();
$tpl->setVariable( 'package', $pear_package );
$result = $tpl->fetch( "design:pear/releases/package.x.y.z.xml.tpl" );
file_put_contents( $outfile, $result );

$script->shutdown();

?>