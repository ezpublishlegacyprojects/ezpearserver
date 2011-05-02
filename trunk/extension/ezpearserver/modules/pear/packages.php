<?php
/**
* @author G. Giunta
* @version $Id$
* @copyright (C) 2011 G. Giunta
*
* @todo fix content-type http header
*/

require_once( "kernel/common/template.php" );

if ( $Params['package'] == 'packages.xml' && $Params['file'] == '' )
{
    $packages = eZPearServer::fetchPackages();
    $tpl = templateInit();
    $tpl->setVariable( 'packages', $packages );
    $Result['content'] = $tpl->fetch( "design:pear/packages/package.xml.tpl" );
}
else
{
    $package = eZPearServer::fetchPackage( $Params['package'] );
    if ( $package )
    {
        $tpl = templateInit();
        $tpl->setVariable( 'package', $package );
        switch( $Params['file'] )
        {
            case 'info.xml':
            case 'maintainers.xml':
            case 'maintainers2.xml':
                $Result['content'] = $tpl->fetch( "design:pear/packages/" . $Params['file'] . ".tpl" );;
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
}
$Result['pagelayout'] = 'design:plain_pagelayout.tpl';

?>
