<?php
/**
 * Class used to manage PEAR packages
 *
 * @author G. Giunta
 * @version $Id$
 * @copyright (C) 2011 G. Giunta
 */

class eZPearPackageManager
{
    /// Builds the (array) definition of the PEAR package from an ezxisting ezpackage object
    static function fromeZPackage( $ezpackage )
    {
        $releasenr = $ezpackage->attribute( 'version-number' ) . '.' . $ezpackage->attribute( 'release-number' );
        $pearpackage = array(
            'name' => $ezpackage->attribute( 'name' ),
            'channel' => '',
            'summary' => $ezpackage->attribute( 'summary' ),
            'description' => $ezpackage->attribute( 'description' ),
            'leads' => array(),
            'developers' => array(),
            'contributors' => array(),
            'helpers' => array(),
            'version' => array( 'release' => $releasenr, 'api' => $releasenr ),
            'stability' => array( 'release' => $ezpackage->attribute( 'state' ), 'api' => $ezpackage->attribute( 'state' ) ),
            'license' => $ezpackage->attribute( 'license' ),
            'license_url' => '',
            'license_filesource' => '', // @todo take from ez package itself?
            'notes' => '',
            'changelog' => array()
        );
        // map ez roles to pear roles
        $role_mapping = array(
            'lead' => 'leads',
            'developer' => 'developers',
            'designer' => 'contributors',
            'contributor' => 'contributors',
            'tester' => 'helpers',
        );
        foreach( $ezpackage->attribute( 'maintainers' ) as $maintainer )
        {
            if ( isset( $role_mapping[$maintainer['role']] ) )
            {
                $pearpackage[$role_mapping[$maintainer['role']]][] = array(
                    'name' => $maintainer['name'],
                    'user' => '',
                    'email' => $maintainer['email'],
                    'active' => true ); /// missing info
            }
        }
        // map ez changelog to pear changelog (skip release 1)
        foreach( $ezpackage->attribute( 'changelog' ) as $entry )
        {
            if ( $entry['release'] != 1 )
            {
                $pearpackage['changelog'] = array(
                    'date' => $entry['timestamp'], /// @todo
                    'version' => array( 'release' => $releasenr . '-' . $entry['release'], 'api' => $releasenr . '-' . $entry['release'] ),
                    'stability' => array( 'release' => $releasenr . '-' . $entry['release'], 'api' => $releasenr . '-' . $entry['release'] ),
                    'license' => $ezpackage->attribute( 'license' ),
                    'notes' => $entry['changes'],
                );
            }
        }

        // map content files
        /// @todo

        return $ezpackage;
    }

    /// @todo
    static function toeZPackage( $package )
    {
        return null;
    }
}

?>