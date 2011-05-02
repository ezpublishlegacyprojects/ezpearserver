<?php
/**
 * @author G. Giunta
 * @version $Id$
 * @copyright (C) 2011 G. Giunta
 */

class eZPearServer
{
    static function fetchCategories()
    {
        return array();
    }

    static function fetchCategory( $category )
    {
        return array( 'name' => '', 'alias' => '', 'description' => '' );
    }

    static function fetchMaintainers()
    {
        return array();
    }

    static function fetchMaintainer( $maintainer )
    {
        return array();
    }

    static function fetchPackages()
    {
        return array();
    }

    static function fetchPackage( $package )
    {
        return array();
    }

    static function fetchPackageReleases( $package )
    {
        return array();
    }

    static function fetchPackageRelease( $package, $release )
    {
        return array();
    }
}

?>