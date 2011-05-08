<?xml version="1.0" encoding="UTF-8"?>
<package
  xmlns="http://pear.php.net/dtd/package-2.1"
  xmlns:tasks="http://pear.php.net/dtd/tasks-1.0"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  {*xmlns:ezp="http://ez.no/ezpackage-1.0"*} {* @todo: use link to local copy instead? *}
  version="2.1"
  xsi:schemaLocation="http://pear.php.net/dtd/tasks-1.0 http://pear.php.net/dtd/tasks-1.0.xsd http://pear.php.net/dtd/package-2.1 http://pear.php.net/dtd/package-2.1.xsd">

    <name>{$package.name|washxml()}</name>

    {* @todo support having uri instead of channel <uri></uri> *}
    <channel>{$package.channel|washxml()}</channel> {* alternative: uri *}

    {* @todo <extends></extends> *}

    <summary>{$package.summary|washxml()}</summary>
    <description>{$package.description|washxml()}</description>

    {foreach $package.leads as $lead}
    <lead>
        <name>{$lead.name|washxml()}</name>
        <user>{$lead.user|washxml()}</user>
        <email>{$lead.email|washxml()}</email>
        <active>{if $lead.active}yes{else}no{/if}</active>
    </lead>

    {/foreach}
    {foreach $package.developers as $dev}
    <developer>
        <name>{$dev.name|washxml()}</name>
        <user>{$dev.user|washxml()}</user>
        <email>{$dev.email|washxml()}</email>
        <active>{if $dev.active}yes{else}no{/if}</active>
    </developer>

    {/foreach}
    {foreach $package.contributors as $cont}
    <contributor>
        <name>{$cont.name|washxml()}</name>
        <user>{$cont.user|washxml()}</user>
        <email>{$cont.email|washxml()}</email>
        <active>{if $cont.active}yes{else}no{/if}</active>
    </contributor>

    {/foreach}
    {foreach $package.helpers as $help}
    <helper>
        <name>{$help.name|washxml()}</name>
        <user>{$help.user|washxml()}</user>
        <email>{$help.email|washxml()}</email>
        <active>{if $help.active}yes{else}no{/if}</active>
    </helper>

    {/foreach}

    <date>{$package.date|datetime('custom', '%Y-%m-%d')}</date>
    <version>
        <release>{$package.version.release|washxml()}</release>
        <api>{$package.version.api|washxml()}</api>
    </version>
    <stability>
        <release>{$package.stability.release|washxml()}</release>{* snapshot devel alpha beta stable *}
        <api>{$package.stability.api|washxml()}</api>{* devel alpha beta stable *}
    </stability>
    <license {* @todo uri=""... *}{* @todo filesource=""... *}>{$package.license|washxml()}</license>
    <notes>{$package.notes|washxml()}</notes>

    <contents>
    <!-- "<contents> is used to describe the contents of a tarball. Nothing further.
         All files in the contents tag will be placed into the tarball regardless
         of whether they eventually get installed by the PEAR installer.
         This fact can be used to create a very versatile tarball, one that can
         be directly unzipped and work out of the box as well as be installed by
         the PEAR installer and work out of the box." -->
        {foreach $package.contents as $topdir}
            {include uri='design:pear/releases/package_dir.tpl' dir=$topdir}
        {/foreach}
    </contents>

    <dependencies>
        <required>
            <php>{* nb: required *}
                {def $dep = $package.dependencies.php}
                <min>{$dep.min|washxml}</min>
                {if is_set($dep.max)}
                <max>{$dep.max|washxml}</max>
                {/if}
                {if is_set($dep.exclude)}
                {foreach $dep.exclude as $exclude}
                <exclude>{$dep.exclude|washxml}</exclude>
                {/foreach}
                {/if}
            </php>
            <pearinstaller>{* nb: required *}
                {set $dep = $package.dependencies.pearinstaller}
                <min>{$dep.min|washxml}</min>{* also avail: recommended *}
                {if is_set($dep.max)}
                <max>{$dep.max|washxml}</max>
                {/if}
                {if is_set($dep.exclude)}
                {foreach $dep.exclude as $exclude}
                <exclude>{$dep.exclude|washxml}</exclude>
                {/foreach}
                {/if}
            </pearinstaller>
            {foreach $package.dependencies.required.packages as $dep}
            <package>{* pear package *}
                <name>{$dep.name|washxml()}</name>
                <channel>{$dep.name|washxml()}</channel>
                {if is_set($dep.min)}
                <min>{$dep.min|washxml}</min>
                {/if}
                {if is_set($dep.max)}
                <max>{$dep.max|washxml}</max>
                {/if}
                {if is_set($dep.recommended)}
                <recommended>{$dep.recommended|washxml}</recommended>
                {/if}
                {if is_set($dep.exclude)}
                {foreach $dep.exclude as $exclude}
                <exclude>{$dep.exclude|washxml}</exclude>
                {/foreach}
                {/if}
                {if and(is_set($dep.conflicts), $dep.conflicts)}
                <conflicts/>
                {/if}
            </package>

            {/foreach}

            {* always depend on ezpearinstaller package *}
            {* @todo do not add this if ezpearinstaller listed in $package.dependencies.required.packages *}
            {if ne($package.name, 'ezpearinstaller')}
            <package>
                <name>ezpearinstaller</name>
                <channel>share.ez.no</channel>
            </package>
            {/if}

            {* <subpackage></subpackage> *}

            {foreach $package.dependencies.required.extensions as $dep}
            <extension>{* php ext *}
                <name>{$dep.name|washxml()}</name>
                {if is_set($dep.min)}
                <min>{$dep.min|washxml}</min>
                {/if}
                {if is_set($dep.max)}
                <max>{$dep.max|washxml}</max>
                {/if}
                {if is_set($dep.recommended)}
                <recommended>{$dep.recommended|washxml}</recommended>
                {/if}
                {if is_set($dep.exclude)}
                {foreach $dep.exclude as $exclude}
                <exclude>{$dep.exclude|washxml}</exclude>
                {/foreach}
                {/if}
                {if and(is_set($dep.conflicts), $dep.conflicts)}
                <conflicts/>
                {/if}
            </extension>

            {/foreach}

            {* @todo ...
            <os>
                <name>windows</name><!-- windows unix linux freebsd darwin (use for Mac OS X) sunos irix hpux aix and others... -->
                <!-- conflicts/ -->
            </os>
            <arch>
                <pattern></pattern>
                <!-- conflicts/ -->
            </arch>
            *}
        </required>

        {if or($package.dependencies.optional.packages|count(), $package.dependencies.optional.extensions|count())}
        <optional>
            {foreach $package.dependencies.optional.packages as $dep}
            <package>{* pear package *}
                <name>{$dep.name|washxml()}</name>
                <channel>{$dep.channel|washxml()}</channel>
                {if is_set($dep.min)}
                <min>{$dep.min|washxml}</min>
                {/if}
                {if is_set($dep.max)}
                <max>{$dep.max|washxml}</max>
                {/if}
                {if is_set($dep.recommended)}
                <recommended>{$dep.recommended|washxml}</recommended>
                {/if}
                {if is_set($dep.exclude)}
                {foreach $dep.exclude as $exclude}
                <exclude>{$dep.exclude|washxml}</exclude>
                {/foreach}
                {/if}
            </package>
            {/foreach}

            {foreach $package.dependencies.optional.extensions as $dep}
            <extension>{* php ext *}
                <name>{$dep.name|washxml()}</name>
                {if is_set($dep.min)}
                <min>{$dep.min|washxml}</min>
                {/if}
                {if is_set($dep.max)}
                <max>{$dep.max|washxml}</max>
                {/if}
                {if is_set($dep.recommended)}
                <recommended>{$dep.recommended|washxml}</recommended>
                {/if}
                {if is_set($dep.exclude)}
                {foreach $dep.exclude as $exclude}
                <exclude>{$dep.exclude|washxml}</exclude>
                {/foreach}
                {/if}
            </extension>

            {/foreach}
        </optional>
        {/if}
    </dependencies>

    {if ne($package.name, 'ezpearinstaller')}
    <!-- custom file roles for our files -->
    {* @see http://pear.php.net/manual/en/guide.developers.package2.usesrole,
             http://pear.php.net/manual/en/guide.migrating.customroles *}
    <usesrole>
        <role>ezcontpackage</role>
        <package>ezpearinstaller</package>
        <channel>share.ez.no</channel>
    </usesrole>
    {*<usesrole>
        <role>ezcontclass</role>
        <package>eZPearServer</package>
        <channel>share.ez.no</channel>
    </usesrole>
    <usesrole>
        <role>ezcontobject</role>
        <package>eZPearServer</package>
        <channel>share.ez.no</channel>
    </usesrole>*}

    <!-- custom tasks for our files -->
    {* @see http://pear.php.net/manual/en/guide.developers.package2.usestask,
             http://pear.php.net/manual/en/guide.migrating.customtasks *}
    <usestask>
      <task>ezupgradescript</task>
      <package>ezpearinstaller</package>
      <channel>share.ez.no</channel>
    </usestask>
    {*<usestask>
      <task>installeZContentObject</task>
      <package>eZPearClient</package>
      <channel>share.ez.no</channel>
    </usestask>
    <usestask>
      <task>installeZContentClass</task>
      <package>eZPearClient</package>
      <channel>share.ez.no</channel>
    </usestask>-->*}
    {/if}

    <phprelease>
        {*<installconditions>
            <os> or php, arch, extension
                <name>windows</name>
            </os>
        </installconditions>*}
        <filelist>
            {foreach $package.phprelease.filelist as $file}
            <install as="{$file.as|washxml}" name="{$file.name|washxml}"/>

            {/foreach}
            {* @todo
            <ignore name="bin/pake.sh"/>
            ...*}
        </filelist>
    </phprelease>

    {* other pear release types we do not currently support: extsrcrelease, extbinrelease, bundle *}

    {if $package.changelog|count()}
    <changelog>
        {foreach $package.changelog as $release}
            <release>
            <date>{$release.date|washxml()}</date>{* @todo format date instead! *}
            {* optional: time *}
            {* optional: lead 0..n *}
            {* optional: developer 0..n *}
            <version>
                <release>{$release.version.release|washxml()}</release>
                <api>{$release.version.api|washxml()}</api>
            </version>
            <stability>
                <release>{$release.stability.release|washxml()}</release>
                <api>{$release.stability.api|washxml()}</api>
            </stability>
            <license uri="{* @todo... *}" filesource="{* @todo ... *}">{$release.license|washxml()}</license>
            <notes>{$release.notes|washxml()}</notes>
        </release>

        {/foreach}
    </changelog>
    {/if}

    {*<ezp:type>...</ezp:type>*}

</package>
