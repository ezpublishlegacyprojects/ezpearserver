<?php
/**
* @author G. Giunta
* @version $Id$
* @copyright (C) 2011 G. Giunta
*
* @todo fix content-type http header
*/

require_once( "kernel/common/template.php" );

$package = $Params['package'];
$file = $Params['file'];
if ( preg_match( '', $file ) )
{
    $release = 'x.y.z';
    $file = $file;
}

$package = eZPearServer::fetchPackage( $Params['package'] );
if ( $package )
{
    $tpl = templateInit();
    $tpl->setVariable( 'package', $package );
    switch( $Params['file'] )
    {
        case 'allreleases.xml':
        case 'allreleases2.xml':
            $releases = eZPearServer::fetchPackageReleases( $Params['package'] );
            $tpl->setVariable( 'releases', $release );
            $Result['content'] = $tpl->fetch( "design:pear/packages/" . $file . ".tpl" );
            break;
        case 'latest.txt':
		case 'stable.txt':
		case 'beta.txt':
		case 'alpha.txt':
		case 'devel.txt':
            $release = substr( $file, 0, -4 );
		    // continue voluntarily
		case 'deps.x.y.z.txt':
		case 'package.x.y.z.xml':
		case 'vx.y.z.xml':
		case 'x.y.z.xml':
            $release = eZPearServer::fetchPackageRelease( $package, $release );
		    if ( $release )
		    {
		        $tpl->setVariable( 'release', $release );
		        $Result['content'] = $tpl->fetch( "design:pear/packages/" . $file . ".tpl" );
		    }
		    else
		    {
		        // error 404
		        $module = $Params['Module'];
		        return $module->handleError( eZError::KERNEL_NOT_FOUND, 'kernel' );
		    }
            break;
        default:
            // error 404
            $module = $Params['Module'];
            return $module->handleError( eZError::KERNEL_NOT_FOUND, 'kernel' );
    }
}
else
{
    // error 404
    $module = $Params['Module'];
    return $module->handleError( eZError::KERNEL_NOT_FOUND, 'kernel' );
}
$Result['pagelayout'] = 'design:plain_pagelayout.tpl';

?>
