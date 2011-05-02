{**
  Part describing a content dir in a pear package.xml file
  @param array $dir
*}
<dir name="{$dir.name|washxml()}"{if $dir.baseinstalldir} baseinstalldir="{$dir.baseinstalldir|washxml}"{/if}>
    {foreach $dir.files as $subdir}
        {include uri='design:pear/releases/package_dir.tpl' dir=$subdir}
    {/foreach}
    {foreach $dir.files as $file}
    <file role="{$file.role|washxml()}"{if $file.baseinstalldir} baseinstalldir="{$file.baseinstalldir|washxml}"{/if} name="{$file.name|washxml()}" md5sum="{$file.md5sum}">
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
