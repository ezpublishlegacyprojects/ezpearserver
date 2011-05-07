<?php
/**
 *
 *
 * @version $Id$
 * @copyright 2011
 */

/// @see http://pear.php.net/manual/en/guide.migrating.customroles.defining.php
class eZPearInstaller_Installer_Role_eZPackage extends PEAR_Installer_Role_Common
{
    /**
     * @param PEAR_Installer
     * @param PEAR_PackageFile_v2
     * @param array file attributes
     * @param string relative path to file in package.xml
     */
    function setup(&$installer, $pkg, $atts, $file)
    {
        // do something special with the installer
        echo "Setup invoked\n";

        // find package file in temp dir:
        // get pear temp var + package name
        var_dump( $pkg->getName() . '-' . $pkg->getVersion() );

        //var_dump( $installer->config );

        // find ezp installation
        // run the package import & install scripts

        //var_dump($installer);
        //var_dump($pkg);
        var_dump($atts);
        var_dump($file);
        die();
    }
}

/**
 * Need this double naming to satisfy both package creation and at install time
 */
class PEAR_Installer_Role_Ezpackage extends eZPearInstaller_Installer_Role_eZPackage
{
}

?>