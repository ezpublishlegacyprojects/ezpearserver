<?xml version="1.0" encoding="utf-8" ?>
<m xmlns="http://pear.php.net/dtd/rest.allmaintainers"
   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
   xmlns:xlink="http://www.w3.org/1999/xlink"
   xsi:schemaLocation="http://pear.php.net/dtd/rest.allmaintainers http://pear.php.net/dtd/rest.allmaintainers.xsd"
>
    {foreach $maintainers as $maintainer}
    <h xlink:href={concat('pear/m/',$maintainer.nick)|ezurl}>{$maintainer.nick|washxml}</h>

    {/foreach}
</m>
