<?php
/**
 * Converts an ezp package file into a pear package file
 *
 * @version $Id$
 * @copyright (C) 2011
 *
 * @toso support json as package def format (remember to add it to self def as optional!)
 */

require 'autoload.php';

$cli = eZCLI::instance();
$script = eZScript::instance( array( 'description' => '...',
                                     'use-session' => false,
                                     'use-modules' => false,
                                     'use-extensions' => true ) );
$script->startup();
$options = $script->getOptions( '[format:]', // options
                                '[input-file][output-file]', // params
                                array( 'format' => 'Format for source package file. Defaults to \'native\' (ie. an ezp package). Supports \'php_array\' (ie. php array)' ) ); // help
$script->initialize();

if ( count( $options['arguments'] ) < 2 )
{
    $cli->error( 'Please specify a file to convert and a target file' );
    $script->shutdown( 1 );
}

$infile = $options['arguments'][0];
$outfile = $options['arguments'][1];


switch( @$options['format'] )
{
    case 'php_array':
        $pear_package = include( $infile );
        /// @todo add more validation
        if ( !is_array( $pear_package ) )
        {
            $cli->error( "File $infile is not a valid eZPearPackage in array form" );
            $script->shutdown( 1 );
        }
        break;
    //case 'json':
    //    break;
    default:
        $package = eZPackage::fetchFromFile( $infile );
        if ( !$package )
        {
            $cli->error( "File $infile is not a valid eZPublish package" );
            $script->shutdown( 1 );
        }
        $pear_package = eZPearPackageManager::fromeZPackage( $package );

        // inject into package definition the ez package file itself
        $pear_package['contents'] = array(
            array(
                'name' => '/',
                'dirs' => array(),
                'files' => array(
                    array(
                        'name' => $infile,
                        'role' => 'ezpackage'
                    )
                )
            )
        );
        break;
}

require_once( "kernel/common/template.php" );
$tpl = templateInit();
$tpl->setVariable( 'package', $pear_package );
$result = $tpl->fetch( "design:pear/releases/package.x.y.z.xml.tpl" );
file_put_contents( $outfile, $result );

$script->shutdown();

?>