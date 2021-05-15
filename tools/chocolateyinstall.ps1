$ErrorActionPreference = 'Stop';

$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$mstFile        = Join-Path $toolsDir 'SYSPRO7Client.mst'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'exe'
  silentArgs    = '/S /v"/qn /norestart TRANSFORMS="' + $mstFile + '"'
  url           = 'http://gold-images.int.celadonsystems.com/SYSPRO/SYSPRO7_Update1_2016 - Lucy/SYSPRO/SYSPRO7Client.exe'
  softwareName  = 'syspro-client'

  checksum      = 'b5c0783f4a9a7ee63c1d48fa7e2e879a553f80496304cacd6b3d4a93f8c59b24'
  checksumType  = 'sha256'
}

# https://chocolatey.org/docs/helpers-install-chocolatey-install-package
#
Install-ChocolateyPackage @packageArgs
