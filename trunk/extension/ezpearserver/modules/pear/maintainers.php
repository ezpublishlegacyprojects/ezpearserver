<?php
/**
* @author G. Giunta
* @version $Id$
* @copyright (C) 2011 G. Giunta
*
* @todo fix content-type http header
*/

require_once( "kernel/common/template.php" );

if ( $Params['maintainer'] == 'allmaintainers.xml' && $Params['file'] == '' )
{
    $mantainers = eZPearServer::fetchMaintainers();
    $tpl = templateInit();
    $tpl->setVariable( 'mantainers', $mantainers );
    $Result['content'] = $tpl->fetch( "design:pear/maintainers/allmaintainers.xml.tpl" );
}
else
{
    $mantainer = eZPearServer::fetchMaintainer( $Params['maintainer'] );
    if ( $mantainer )
    {
        $tpl = templateInit();
        $tpl->setVariable( 'mantainers', $mantainer );
        switch( $Params['file'] )
        {
            case 'info.xml':
                $Result['content'] = $tpl->fetch( "design:pear/maintainers/" . $Params['file'] . ".tpl" );;
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
