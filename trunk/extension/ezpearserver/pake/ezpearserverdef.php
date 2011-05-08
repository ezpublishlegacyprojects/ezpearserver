<?php
/**
 * Definition for building as PEAR package the extension
 * Ideally we should use the ezextbuilder extension to derive this
 *
 * @version $Id$
 * @copyright (C) 2011
 */

return array(
    'name' => 'ezpearserver',
    'channel' => 'share.ez.no',
    'summary' => 'The "eZ Pear Server" package allows to ...',
    'description' => 'The "eZ Pear Server" package allows ...',
    'date' => time(),
    'leads' => array( array( 'name' => 'gggeek', 'user' => 'gggeek', 'email' => 'gg@ez.no', 'active' => true ) ),
    'developers' => array(),
    'contributors' => array(),
    'helpers' => array(),
    'version' => array( 'release' => '0.1.0', 'api' => '0.1.0' ),
    'stability' => array( 'release' => 'beta', 'api' => 'beta' ),
    'license' => 'GNU General Public License v2.0',
    'notes' => 'To be done',
    'contents' => array(
        array(
            'name' => '/',
            'dirs' => array(),
            'files' => array(
                array(
                    'name' => 'dist/ezpearsever-0.1.0.tar.gz',
                    'role' => 'ezpackage',
                )
            )
        )
    ),
    'phprelease' => array(
    ),
    'dependencies' => array(
        'php' => array( 'min' => '5.2' ), /// @todo check min reqs for ezp 4.0
        'pearinstaller' => array( 'min' => '1.4.1' ),
        'required' => array(
            'packages' => array(),
            'extensions' => array(),
        ),
        'optional' => array(
            'packages' => array(),
            'extensions' => array(),
        )
    ),
    'changelog' => array()
);

?>