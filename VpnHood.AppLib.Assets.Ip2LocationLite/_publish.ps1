$SoultionDir = Split-Path -Parent $PSScriptRoot
$ProjectDir = $PSScriptRoot
$ProjectFile = join-Path $ProjectDir "VpnHood.AppLib.Assets.Ip2LocationLite.csproj"

# extract version amd increment its build number then save it back to the project file
Function UpdateProjectVersion([string] $projectFile) 
{
	[xml]$xml = Get-Content $projectFile
	$versionNode = $xml.SelectSingleNode("Project/PropertyGroup/Version");
	if ($versionNode -eq $null) {
		throw "Version node not found or invalid format in project file."
	}

	# parse version using version class
	$version = [System.Version]::Parse($versionNode.InnerText)
		
	# increment build number
	$newVersion = New-Object System.Version($version.Major, $version.Minor, ($version.Build + 1))
	
	$versionNode.InnerText = $newVersion.ToString(3)
	$xml.Save($projectFile)
}

# Increase Version
Write-Host "Increase Version"
UpdateProjectVersion $ProjectFile

# Common git directory/work-tree arguments
$GitDirArgs = @('--git-dir', "$SoultionDir/.git", '--work-tree', $SoultionDir)

# update
git $GitDirArgs commit -a -m Publish
git $GitDirArgs pull
git $GitDirArgs push
