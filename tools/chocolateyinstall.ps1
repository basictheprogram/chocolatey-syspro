$ErrorActionPreference = 'Stop';

$data = & (Join-Path -Path (Split-Path -Path $MyInvocation.MyCommand.Path) -ChildPath data.ps1)
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$mstFile = Join-Path $toolsDir $data.mstFile

$packageArgs = @{
    packageName   = $env:ChocolateyPackageName
    unzipLocation = $toolsDir
    fileType      = 'exe'
    silentArgs    = '/S /v"/qn /norestart TRANSFORMS="' + $mstFile + '"'
    softwareName  = 'syspro-client'

    url           = $data.url
    checksum      = $data.checksum
    checksumType  = $data.checksumType
}

# https://chocolatey.org/docs/helpers-install-chocolatey-install-package
#
Install-ChocolateyPackage @packageArgs
