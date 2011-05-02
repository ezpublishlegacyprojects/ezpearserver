<?xml version="1.0" encoding="utf-8" ?>
<a xmlns="http://pear.php.net/dtd/rest.allcategories"
   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
   xmlns:xlink="http://www.w3.org/1999/xlink"
   xsi:schemaLocation="http://pear.php.net/dtd/rest.allcategories http://pear.php.net/dtd/rest.allcategories.xsd"
>
    <ch>{ezini('SiteSettings','SiteURL')}</ch>
    {foreach $categories as $category}
    <c xlink:href={concat('pear/c/',$category.name,'info.xml')|ezurl()}>{$category.name|washxml()}</c>

    {/foreach}
</a>
