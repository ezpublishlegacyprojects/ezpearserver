<?php
/**
* @author G. Giunta
* @version $Id$
* @copyright (C) 2011 G. Giunta
*
* @todo fix content-type http header
*/

require_once( "kernel/common/template.php" );

/*$channel = array(
    'name' => '',
    'alias' => '',
    'summary' => '',
    'mirrors' => array() );*/

$tpl = templateInit();
//$tpl->setVariable( 'channel', $channel );
$Result['content'] = $tpl->fetch( "design:pear/channel.xml.tpl" );
$Result['pagelayout'] = 'design:plain_pagelayout.tpl';

?>
