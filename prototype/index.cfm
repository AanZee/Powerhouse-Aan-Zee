<cfoutput>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Templates</title>
</head>
<body>
	<cfdirectory action="list" filter="*.cfm" directory="#getDirectoryFromPath(getCurrentTemplatePath())#" name="qDir"/>

	<ul>
	<cfloop query="qDir">
		<li><a href="#name#">#name#</a></li>
	</cfloop>
	</ul>
</body>
</html>
</cfoutput>