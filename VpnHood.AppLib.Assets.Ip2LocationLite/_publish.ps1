$SoultionDir = Split-Path -Parent $PSScriptRoot
$ProjectDir = $PSScriptRoot
$ProjectFile = Path.Combine($ProjectDir, 'VpnHood.AppLib.Assets.Ip2LocationLite.csproj')
echo "Publishing project file: $ProjectFile"
exits


# Common git directory/work-tree arguments
$GitDirArgs = @('--git-dir', "$SoultionDir/.git", '--work-tree', $SoultionDir)

# update
git $GitDirArgs commit -a -m Publish
git $GitDirArgs pull
git $GitDirArgs push

# extract version amd increment its build number then save it back to the project file
Function UpdateProjectVersion([string] $projectFile) 
{
	[xml]$xml = Get-Content $projectFile
	$versionNode = $xml.SelectSingleNode("Project/PropertyGroup/Version");
	if ($versionNode -ne $null) 
	{
		$versionParts = $versionNode.InnerText.Split('.')
		if ($versionParts.Length -eq 4) 
		{
			$buildNumber = [int]$versionParts[2]
			$buildNumber++
			$versionParts[2] = $buildNumber.ToString()
			$newVersion = $versionParts -join '.'
			$versionNode.InnerText = $newVersion
			$xml.Save($projectFile)
			return $newVersion
		}
	}
	return $null
}