# Load current feed
[xml]$feed = Get-Content .\rss.xml -Encoding utf8

# Set new publication date
$dateString = ([DateTime]::Now).ToString('r')
$feed.rss.channel.pubDate = $dateString

# Add oldest new post (i.e. if multiple pages are posted at once, only RSS-ify the oldest one to avoid spam)
[xml]$newPost = @'
<item>
	<title>Chapter 2, page 30</title>
	<link>https://gondolaquest.com/chapter_2/page_30/page.html</link>
	<guid isPermaLink="true">chapter_2/page_30</guid>
	<description>{{COMMIT}}</description>
	<pubDate>{{DATE}}</pubDate>
	<source url="https://www.gondolaquest.com/rss.xml">Gondolaquest</source>
</item>
'@ -creplace "\{\{COMMIT\}\}", $commit -replace "\{\{DATE\}\}", $dateString
