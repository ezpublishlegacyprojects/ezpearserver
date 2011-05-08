<?php
/**
 * Definition for building as PEAR package the tools needed to ensure proper
 * integration of eZP packages into pear
 * Ideally we should use the ezextbuilder extension to derive this
 *
 * @version $Id$
 * @copyright (C) 2011
 */

return array(
    'name' => 'ezpearinstaller',
    'channel' => 'share.ez.no',
    'summary' => 'The "eZ Pear Installer" package allows to install eZ Publish packages via PEAR',
    'description' => 'The "eZ Pear Installer" package allows to install eZ Publish packages via PEAR',
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
                // TASKS
                array(
                    'name' => 'extension/ezpearserver/classes/peartasks/Ezupgradescript.php',
                    'role' => 'php',
                    'baseinstalldir' => 'PEAR/Task'
                ),
                // POST INSTALL SCRIPTS

                // ROLES
                array(
                    'name' => 'extension/ezpearserver/classes/pearroles/Ezpackage.php',
                    'role' => 'php',
                    'baseinstalldir' => 'PEAR/Installer/Role'
                ),
                array(
                    'name' => 'extension/ezpearserver/classes/pearroles/Ezpackage.xml',
                    'role' => 'php',
                    'baseinstalldir' => 'PEAR/Installer/Role'
                ),
                /*array(
                    'name' => 'ezpackage.php',
                    'role' => 'php',
                    'postinstallscript' => array(
                        array( // 1st param group
                            //'description' => '',
                            'params' => array(
                                array( // 1st param
                                    'name' => 'ezprootdir',
                                    'prompt' => 'Location of eZ Publish installation',
                                    'type' => 'string'
                                )
                            )
                        )
                    )
                )*/
            )
        )
    ),
    'phprelease' => array(
        'filelist' => array(
            array( 'name' => 'extension/ezpearserver/classes/pearroles/Ezpackage.php', 'as' =>'Ezpackage.php' ),
            array( 'name' => 'extension/ezpearserver/classes/pearroles/Ezpackage.php', 'as' =>'Ezpackage.xml' ),
            array( 'name' => 'extension/ezpearserver/classes/peartasks/Ezupgradescript.php', 'as' =>'Ezupgradescript.php' ),
        )
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