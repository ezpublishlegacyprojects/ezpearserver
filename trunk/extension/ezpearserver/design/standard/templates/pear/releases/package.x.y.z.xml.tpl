<?xml version="1.0" encoding="UTF-8"?>
<package
  xmlns="http://pear.php.net/dtd/package-2.1"
  xmlns:tasks="http://pear.php.net/dtd/tasks-1.0"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  {*xmlns:ezp="http://ez.no/ezpackage-1.0"*} {* @todo: use link to local copy instead? *}
  version="2.1"
  xsi:schemaLocation="http://pear.php.net/dtd/tasks-1.0 http://pear.php.net/dtd/tasks-1.0.xsd http://pear.php.net/dtd/package-2.1 http://pear.php.net/dtd/package-2.1.xsd">

    <name>{$package.name|xmlwash()}</name>

    {* @todo support having uri instead of channel <uri></uri> *}
    <channel>{$package.channel|xmlwash()}</channel> {* alternative: uri *}

    {* @todo <extends></extends> *}

    <summary>{$package.summary|xmlwash()}</summary>
    <description>{$package.description|xmlwash()}</description>

    {foreach $package.leads as $lead}
    <lead>
        <name>{$lead.name|xmlwash()}</name>
        <user>{$lead.user|xmlwash()}</user>
        <email>{$lead.email|xmlwash()}</email>
        <active>{if $lead.active}yes{else}no{/if}</active>
    </lead>

    {/foreach}
    {foreach $package.developers as $dev}
    <developer>
        <name>{$dev.name|xmlwash()}</name>
        <user>{$dev.user|xmlwash()}</user>
        <email>{$dev.email|xmlwash()}</email>
        <active>{if $dev.active}yes{else}no{/if}</active>
    </developer>

    {/foreach}
    {foreach $package.contributors as $cont}
    <contributor>
        <name>{$cont.name|xmlwash()}</name>
        <user>{$cont.user|xmlwash()}</user>
        <email>{$cont.email|xmlwash()}</email>
        <active>{if $cont.active}yes{else}no{/if}</active>
    </contributor>

    {/foreach}
    {foreach $package.helpers as $help}
    <helper>
        <name>{$help.name|xmlwash()}</name>
        <user>{$help.user|xmlwash()}</user>
        <email>{$help.email|xmlwash()}</email>
        <active>{if $help.active}yes{else}no{/if}</active>
    </helper>

    {/foreach}

    <date>{* @todo ... *}</date>
    <version>
        <release>{$package.version.release|xmlwash()}</release>
        <api>{$package.version.api|xmlwash()}</api>
    </version>
    <stability>
        <release>{$package.stability.release|xmlwash()}</release>{* snapshot devel alpha beta stable *}
        <api>{$package.stability.api|xmlwash()}</api>{* devel alpha beta stable *}
    </stability>
    <license {* @todo uri=""... *}{* @todo filesource=""... *}>{$package.license|xmlwash()}</license>
    <notes>{$package.notes|xmlwash()}</notes>

    <contents>
    <!-- "<contents> is used to describe the contents of a tarball. Nothing further.
         All files in the contents tag will be placed into the tarball regardless
         of whether they eventually get installed by the PEAR installer.
         This fact can be used to create a very versatile tarball, one that can
         be directly unzipped and work out of the box as well as be installed by
         the PEAR installer and work out of the box." -->
        {foreach $package.contents as $dir}
        <dir name="{$dir.name|washxml()}" {* @todo baseinstalldir="ext/$extname" ? *}>
            {* @todo recurse dirs ... *}
            {foreach $dir.files as $file}
            <file role="{$file.role|washxml()}" {* @todo baseinstalldir="/" *} name="{$file.name|washxml()}" md5sum="{$file.md5sum}">
                {if $file.postinstallscript|count()}
                <tasks:postinstallscript>
                    {foreach $file.postinstallscript as $id => $group}
                    <tasks:paramgroup>
                        <tasks:id>{$id|washxml()}</tasks:id>
                        {if {$group.instructions}<tasks:instructions>{$group.instructions|washxml()}</tasks:instructions>{/if}
                        {foreach $group.params as $param}
                        <tasks:param>
                            <tasks:name>{$param.name|washxml()}</tasks:name>
                            <tasks:prompt>{$param.prompt|washxml()}</tasks:prompt>
                            <tasks:type>{$param.type|washxml()}</tasks:type>
                        </tasks:param>

                        {/foreach}
                    </tasks:paramgroup>

                    {/foreach}
                </tasks:postinstallscript>
                {elseif $file.tasks|count()}
                {foreach $file.postinstallscript as $id => $group}
                    {* @todo ... *}
                {/foreach}
                {/if}
            </file>

            {/foreach}
        </dir>

        {/foreach}

        {* sample file description stuff

            <file role="script" baseinstalldir="/" name="bin/pake.sh" md5sum="">
                <!-- replace text in file -->
                <tasks:replace type="pear-config" from="@PHP-BIN@" to="php_bin"/>
            </file>

            <file role="php" baseinstalldir="/" name="bin/pake.php" md5sum=""/>

            <dir name="lib">
                <dir name="pake">
                    <file role="php" name="pakeApp.class.php">
                        <tasks:replace type="package-info" from="1.0.DEV" to="version"/>
                    </file>
                    ##CLASS_FILES##
                    <dir name="tasks">
                        ##TASK_FILES##
                    </dir>
                </dir>
            </dir>

            <file role="doc" baseinstalldir="/" name="LICENSE"/>

            <!-- defining a custom task -->
            <file role="php" baseinstalldir="/bin/php" name="task.php"/>
             <tasks:paramgroup>
              <tasks:id>first</tasks:id>
              <tasks:param>
               <tasks:name>test</tasks:name>
               <tasks:prompt>Testing Thingy</tasks:prompt>
               <tasks:type>string</tasks:type>
              </tasks:param>
             </tasks:paramgroup>
            </tasks:postinstallscript>
            </file>*}
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
    </dependencies>

    {if ne($package.name, 'ezpearinstaller')}
    <!-- custom file roles for our custom tasks -->
    <usesrole>
        <role>ezcontpackage</role>
        <package>eZPearServer</package>
        <channel>share.ez.no</channel>
    </usesrole>
    <!--<usesrole>
        <role>ezcontclass</role>
        <package>eZPearServer</package>
        <channel>share.ez.no</channel>
    </usesrole>
    <usesrole>
        <role>ezcontobject</role>
        <package>eZPearServer</package>
        <channel>share.ez.no</channel>
    </usesrole>-->

    <!-- custom tasks for our files -->
    <usestask>
      <task>installeZPackage</task>
      <package>eZPearClient</package>
      <channel>share.ez.no</channel>
    </usestask>
    <!--<usestask>
      <task>installeZContentObject</task>
      <package>eZPearClient</package>
      <channel>share.ez.no</channel>
    </usestask>
    <usestask>
      <task>installeZContentClass</task>
      <package>eZPearClient</package>
      <channel>share.ez.no</channel>
    </usestask>-->
    {/if}

    <phprelease>
        {*<installconditions>
            <os> or php, arch, extension
                <name>windows</name>
            </os>
        </installconditions>*}
        <filelist>
            {* @todo
            <install as="pake.bat" name="bin/pake.bat"/>
            ...

            <ignore name="bin/pake.sh"/>
            ...*}
        </filelist>
    </phprelease>

    {* other pear release types we do not currently support: extsrcrelease, extbinrelease, bundle *}

    {if $package.changelog|count()}
    <changelog>
        {foreach $package.changelog as $release}
            <release>
            <date>{$release.date|xmlwash()}</date>{* @todo format date instead! *}
            {* optional: time *}
            {* optional: lead 0..n *}
            {* optional: developer 0..n *}
            <version>
                <release>{$release.version.release|xmlwash()}</release>
                <api>{$release.version.api|xmlwash()}</api>
            </version>
            <stability>
                <release>{$release.stability.release|xmlwash()}</release>
                <api>{$release.stability.api|xmlwash()}</api>
            </stability>
            <license uri="{* @todo... *}" filesource="{* @todo ... *}">{$release.license|xmlwash()}</license>
            <notes>{$release.notes|xmlwash()}</notes>
        </release>

        {/foreach}
    </changelog>
    {/if}

    {*<ezp:type>...</ezp:type>*}

</package>
