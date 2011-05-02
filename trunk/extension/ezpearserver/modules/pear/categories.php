<?php
/**
* @author G. Giunta
* @version $Id$
* @copyright (C) 2011 G. Giunta
*
* @todo fix content-type http header
*/

require_once( "kernel/common/template.php" );

if ( $Params['category'] == 'categories.xml' && $Params['file'] == '' )
{
    $categories = eZPearServer::fetchCategories();
    $tpl = templateInit();
    $tpl->setVariable( 'categories', $categories );
    $Result['content'] = $tpl->fetch( "design:pear/categories/categories.xml.tpl" );
}
else
{
    $category = eZPearServer::fetchCategory( $Params['category'] );
    if ( $category )
    {
        $tpl = templateInit();
        $tpl->setVariable( 'category', $category );
        switch( $Params['file'] )
        {
            case 'info.xml':
            case 'packages.xml':
            case 'packagesinfo.xml':
                $Result['content'] = $tpl->fetch( "design:pear/categories/" . $Params['file'] . ".tpl" );;
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
