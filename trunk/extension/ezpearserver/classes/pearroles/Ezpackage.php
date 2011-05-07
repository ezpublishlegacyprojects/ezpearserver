<?php
/**
 * Pear Role used to import eZ Publish package files
 *
 * @version $Id$
 * @copyright (C) 2011
 */

/// @see http://pear.php.net/manual/en/guide.migrating.customroles.defining.php
class eZPearInstaller_Installer_Role_eZPackage extends PEAR_Installer_Role_Common
{
    /**
     * Imports + Installs the eZP package in the file $file
     *
     * @param PEAR_Installer
     * @param PEAR_PackageFile_v2
     * @param array file attributes
     * @param string relative path to file in package.xml
     *
     * @see the ezpm.php cli script
     */
    function setup( &$installer, $pkg, $atts, $file )
    {
        // find package file in temp dir:
        // get package temp var + package name & version
        // tmp dir is slightly hackish: we access a 'private' package member
        $source = dirname( $pkg->_packageFile ) . '/' . $pkg->getName() . '-' . $pkg->getVersion() . '/' . $file;
        if ( is_readable( $source ) )
        {
            // find ezp installation
            $config = $installer->config;
            $ezpdir = $config->get( 'ezpublish_dir' );
            if ( $this->isValidEZPDir( $ezpdir ) )
            {
                // run the package import & install code
                $startdir = getcwd();
                chdir( $ezpdir );
                include( 'autoload.php' );
                /// @todo allow import into a separate repo (via eg. another pear variable)?
                $repositoryID = false;
                $siteaccess = false;
                $pkgname = false; // this might be different from pear pkg name...
                /// @todo shall we test if db is available before we pass true as 3rd param?
                try
                {
                    $package = eZPackage::import( $source, $pkgname, true, $repositoryID );
                    if ( $package instanceof eZPackage )
                    {
                        //$cli->notice( "Package " . $cli->stylize( 'emphasize', $packageName ) . " sucessfully imported" );
                        $user = eZUser::currentUser();
                        $installParameters = array(
                            'site_access_map' => array( '*' => $siteaccess ),
                            'top_nodes_map' => array( '*' => 2 ),
                            'design_map' => array( '*' => $siteaccess ),
                            'restore_dates' => true,
                            'user_id' => $user->attribute( 'contentobject_id' ),
                            'non-interactive' => true,
                            'language_map' => $package->defaultLanguageMap() );
                        $result = $package->install( $installParameters );
                        if ( $result )
                        {
                            chdir( $startdir );
                            return;
                        }
                        else
                        {
                            chdir( $startdir );
                            return PEAR::raiseError("ezpackage::setup: Failed to install package " . $package->attribute( 'name' ) );
                        }
                    }
                    else if ( $package == eZPackage::STATUS_ALREADY_EXISTS )
                    {
                        // @todo what to do here ???
                        return PEAR::raiseError("ezpackage::setup: Could not import package " . $pkg->getName() . ", it already exists" );
                    }
                    else if ( $package == eZPackage::STATUS_INVALID_NAME )
                    {
                        chdir( $startdir );
                        return PEAR::raiseError("ezpackage::setup: Could not import package " . $pkg->getName() . ", its name is invalid" );
                    }
                    else
                    {
                        chdir( $startdir );
                        return PEAR::raiseError("ezpackage::setup: Could not import package " . $pkg->getName() . ", invalid package file" );
                    }
                }
                catch( Exception $e )
                {
                    /// @todo return error
                    chdir( $startdir );
                    return PEAR::raiseError("ezpackage::setup: Could not import package " . $pkg->getName() . ", exception thrown: " . $e->getMessage() );
                }
            }
            else
            {
                return PEAR::raiseError( "ezpackage::setup: can not find a valid eZP installation in directory $ezpdir (check config var 'ezpublish_dir')" );
            }
        }
        else
        {
            return PEAR::raiseError( "ezpackage::setup: reading package file ($source) failed: does not exist/is not readable" );
        }
    }

    /// @todo better tests for an eZP installation?
    function isValidEZPDir( $ezpdir )
    {
        return ( is_dir( $ezpdir ) && is_file( "$ezpdir/autoload.php" ) && is_file( "$ezpdir/index.php" ) );
    }
}

/**
 * Need this double naming to satisfy both package creation and at install time
 */
class PEAR_Installer_Role_Ezpackage extends eZPearInstaller_Installer_Role_eZPackage
{
}

?>