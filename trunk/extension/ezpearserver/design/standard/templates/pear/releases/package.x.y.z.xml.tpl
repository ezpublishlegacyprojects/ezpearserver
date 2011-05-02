<?xml version="1.0" encoding="UTF-8"?>
<package
  xmlns="http://pear.php.net/dtd/package-2.1"
  xmlns:tasks="http://pear.php.net/dtd/tasks-1.0"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:ezpackage="http://ez.no/ezpackage-1.0" {* @todo: use link to local copy instead? *}
  version="2.1"
  xsi:schemaLocation="http://pear.php.net/dtd/tasks-1.0 http://pear.php.net/dtd/tasks-1.0.xsd http://pear.php.net/dtd/package-2.1 http://pear.php.net/dtd/package-2.1.xsd http://ez.no/ezpackage-1.0 http://ez.no/ezpackage-1.0.dtd">

    <name>{$package.name|xmlwash()}</name>
    <channel>{$package.channel|xmlwash()}</channel> {* alternative: uri *}
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
    <license uri="{* @todo ... *}" filesource="{* @todo ... *}">{$package.license|xmlwash()}</license>
    <notes>{$package.notes|xmlwash()}</notes>

    <contents>
        <dir name="/">
            <file role="script" baseinstalldir="/" name="bin/pake.sh">
                <tasks:replace type="pear-config" from="@PHP-BIN@" to="php_bin"/>
                <tasks:replace type="pear-config" from="@BIN-DIR@" to="bin_dir"/>
                <tasks:replace type="pear-config" from="@PEAR-DIR@" to="php_dir"/>
            </file>
            <file role="script" baseinstalldir="/" name="bin/pake.bat">
                <tasks:replace type="pear-config" from="@PHP-BIN@" to="php_bin"/>
                <tasks:replace type="pear-config" from="@BIN-DIR@" to="bin_dir"/>
                <tasks:replace type="pear-config" from="@PEAR-DIR@" to="php_dir"/>
            </file>
            <file role="php" baseinstalldir="/" name="bin/pake.php"/>

            <dir name="lib">
                <dir name="pake">
                    <file role="php" name="pakeApp.class.php">
                        <tasks:replace type="package-info" from="1.0.DEV" to="version"/>
                    </file>
                    ##CLASS_FILES##
                    <dir name="tasks">
                        ##TASK_FILES##
                    </dir>

                    <dir name="sfYaml">
                        <file role="php" name="sfYaml.php"/>
                        <file role="php" name="sfYamlDumper.php"/>
                        <file role="php" name="sfYamlInline.php"/>
                        <file role="php" name="sfYamlParser.php"/>
                    </dir>
                </dir>
            </dir>

            <file role="doc" baseinstalldir="pake" name="LICENSE"/>
        </dir>
    </contents>

    <dependencies>
        <required>
            <php>
                <min>5.2.1</min>
            </php>
            <pearinstaller>
                <min>1.4.1</min>
            </pearinstaller>
            <package>{* pear package *}
                <name>YAML</name>
                <channel>pear.symfony-project.com</channel>
            </package>
            <extension>{* php ext *}
                <name>pcre</name>
            </extension>
        </required>

        <optional>
            <package>{* pear package *}
                <name>svn</name>
                <channel>pecl.php.net</channel>
            </package>
            <extension>{* php ext *}
                <name>phar</name>
            </extension>
        </optional>
    </dependencies>

    <phprelease>
        <installconditions>
            <os>
                <name>windows</name>
            </os>
        </installconditions>
        <filelist>
            <install as="pake.bat" name="bin/pake.bat"/>
            <install as="pake.php" name="bin/pake.php"/>
            <install as="pake/pakeApp.class.php" name="lib/pake/pakeApp.class.php"/>
            <install as="pake/sfYaml/sfYaml.php" name="lib/pake/sfYaml/sfYaml.php"/>
            <install as="pake/sfYaml/sfYamlDumper.php" name="lib/pake/sfYaml/sfYamlDumper.php"/>
            <install as="pake/sfYaml/sfYamlInline.php" name="lib/pake/sfYaml/sfYamlInline.php"/>
            <install as="pake/sfYaml/sfYamlParser.php" name="lib/pake/sfYaml/sfYamlParser.php"/>
            ##RENAMES##
            <ignore name="bin/pake.sh"/>
        </filelist>
    </phprelease>

    <phprelease>
        <filelist>
            <install as="pake" name="bin/pake.sh"/>
            <install as="pake.php" name="bin/pake.php"/>
            <install as="pake/pakeApp.class.php" name="lib/pake/pakeApp.class.php"/>
            <install as="pake/sfYaml/sfYaml.php" name="lib/pake/sfYaml/sfYaml.php"/>
            <install as="pake/sfYaml/sfYamlDumper.php" name="lib/pake/sfYaml/sfYamlDumper.php"/>
            <install as="pake/sfYaml/sfYamlInline.php" name="lib/pake/sfYaml/sfYamlInline.php"/>
            <install as="pake/sfYaml/sfYamlParser.php" name="lib/pake/sfYaml/sfYamlParser.php"/>
            ##RENAMES##
            <ignore name="bin/pake.bat"/>
        </filelist>
    </phprelease>

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

    <ezpackage:type>
</package>
