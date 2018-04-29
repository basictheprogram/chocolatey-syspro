﻿$ErrorActionPreference = 'Stop'; 

$pkg           = 'SYSPRO7Client.exe'
$toolsDir      = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$file          = Join-Path $toolsDir $pkg
$checksum      = 'b5c0783f4a9a7ee63c1d48fa7e2e879a553f80496304cacd6b3d4a93f8c59b24'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  file           = $file
  unzipLocation  = $toolsDir
  checksum       = $checksum
  checksumType   = 'sha256' 
}

# https://chocolatey.org/docs/helpers-install-chocolatey-zip-package
#
Install-ChocolateyZipPackage @packageArgs 

# https://forum.fortinet.com/tm.aspx?m=150054

$installArgs = @{
  packageName    = $env:ChocolateyPackageName
  file           = Join-Path $toolsDir 'FortiClient.msi'
  fileType       = 'msi'
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`"" 
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyInstallPackage @installArgs
Remove-Item -Force $packageArgs.file