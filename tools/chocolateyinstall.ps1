$ErrorActionPreference = 'Stop'; 

$toolsDir       = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileLocation   = Join-Path $toolsDir 'SYSPRO7Client.msi'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'MSI' 
  file          = $fileLocation
  softwareName  = 'syspro-client*'

  # Checksums are now required as of 0.10.0.
  #
  checksum      = 'c6ddfaa90b25e5c404c3106c94f5fd49d8518ef561df591e1087d70d7d9a14ae'
  checksumType  = 'sha256'

  # Cygwin $env:TEMP is C:\tools\cygwin\tmp\chocolatey
  # Powershell $env:TEMP is C:\Users\tanner\AppData\Local\Temp
  #
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).log`" TRANSFORMS=SYSPRO7Client.mst"
  validExitCodes = @(0, 3010, 1641)
}

# https://chocolatey.org/docs/helpers-install-chocolatey-install-package
#
Install-ChocolateyInstallPackage @packageArgs 
