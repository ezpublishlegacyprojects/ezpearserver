<?xml version="1.0" encoding="utf-8" ?>
<l xmlns="http://pear.php.net/dtd/rest.categorypackages"
   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
   xmlns:xlink="http://www.w3.org/1999/xlink"
   xsi:schemaLocation="http://pear.php.net/dtd/rest.categorypackages
                       http://pear.php.net/dtd/rest.categorypackages.xsd"
>
    {foreach $packages as $package}
    <p xlink:href={concat('pear/p/',$package.name)|ezurl()}>{$package.name|washxml()}</p>

    {/foreach}
</l>