<channel
  xmlns="http://pear.php.net/channel-1.0"
  version="1.0"
  xsi:schemaLocation="http://pear.php.net/channel-1.0 http://pear.php.net/dtd/channel-1.0.xsd">

<name>{ezini('SiteSettings','SiteURL')}</name>
<suggestedalias>{ezini('Channel', 'Alias', 'pearserver.ini')|washxml()}</suggestedalias>
<summary>{ezini('Channel', 'Summary', 'pearserver.ini')|washxml()}</summary>

{* package validation: to be implemented *}
{* <validatepackage version="1.3.4">Foo_Validate</validatepackage> *}

<servers>
    <primary port="{* @todo *}" ssl="{* @todo *}">

        {*<xmlrpc path={'webservices/execute/xmlrpc'|ezurl()}>
            <function version="1.0">logintest</function>
            <function version="1.0">package.listLatestReleases</function>
            <function version="1.0">package.listAll</function>
            <function version="1.0">package.info</function>
            <function version="1.0">package.getDownloadURL</function>
            <function version="1.1">package.getDownloadURL</function>
            <function version="1.0">package.getDepDownloadURL</function>
            <function version="1.1">package.getDepDownloadURL</function>
            <function version="1.0">package.search</function>
            <function version="1.0">channel.listAll</function>
        </xmlrpc>*}

        <rest>
            <baseurl type="REST1.0">{'pear'|ezurl(no)}</baseurl>
            <baseurl type="REST1.1">{'pear'|ezurl(no)}</baseurl>
            <baseurl type="REST1.2">{'pear'|ezurl(no)}</baseurl>
            <baseurl type="REST1.3">{'pear'|ezurl(no)}</baseurl>
        </rest>

        {*<soap path={'webservices/execute/phpsoap'|ezurl()}>
            <function version="1.0">package.listAll</function>
        </soap>*}
    </primary>

    {foreach ezini('Channel', 'Mirrors', 'pearserver.ini') as $mirror}
    <mirror server="">
        {* @todo ... *}
    </mirror>
    {/foreach}

    <_lastmodified>
        <Etag>{* @todo ... *}</Etag>
    </_lastmodified>

</servers>
</channel>
