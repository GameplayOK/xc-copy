#!/usr/bin/env sh

echo '<!DOCTYPE html>'
echo '<html lang="en">'
echo '	<head>'
echo '		<meta charset="utf-8" />'
echo '	</head>'
echo '	<body>'
sed 's/^.*/		<a href="&">&<\/a><br \/>/' | sed '/index.html/d'
echo '	</body>'
echo '</html>'
