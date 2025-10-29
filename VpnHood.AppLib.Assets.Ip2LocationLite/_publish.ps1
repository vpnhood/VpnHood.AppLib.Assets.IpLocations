$SoultionDir = Split-Path -Parent $PSScriptRoot
$ProjectDir = $PSScriptRoot

# Common git directory/work-tree arguments
$GitDirArgs = @('--git-dir', "$SoultionDir/.git", '--work-tree', $SoultionDir)

git $GitDirArgs commit -a -m Publish
git $GitDirArgs pull
git $GitDirArgs push
