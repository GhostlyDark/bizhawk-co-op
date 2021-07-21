#Download and move files for mzm-coop

$shell_app=new-object -com shell.application

mkdir BizHawk

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

#Download Bizhawk
$url = "https://github.com/GhostlyDark/BizHawk/releases/download/2021-07-21/BizHawk_Developer-2021-07-21.zip"
$filename = "BizHawk_Developer-2021-07-21.zip"
Invoke-WebRequest -Uri $url -OutFile $filename
#Unzip
$zip_file = $shell_app.namespace((Get-Location).Path + "\$filename")
$destination = $shell_app.namespace((Get-Location).Path + "\BizHawk")
$destination.Copyhere($zip_file.items())
Remove-Item $filename

#Download prereq
$url = "https://github.com/TASVideos/BizHawk-Prereqs/releases/download/2.4.8_1/bizhawk_prereqs_v2.4.8_1.zip"
$filename = "bizprereq.zip"
Invoke-WebRequest -Uri $url -OutFile $filename
#unzip prereq
$zip_file = $shell_app.namespace((Get-Location).Path + "\$filename")
$destination = $shell_app.namespace((Get-Location).Path)
$destination.Copyhere($zip_file.items())
Remove-Item $filename

#Download luasocket
$url = "http://files.luaforge.net/releases/luasocket/luasocket/luasocket-2.0.2/luasocket-2.0.2-lua-5.1.2-Win32-vc8.zip"
$filename = "luasocket-2.0.2-lua-5.1.2-Win32-vc8.zip"
Invoke-WebRequest -Uri $url -OutFile $filename
#unzip
$zip_file = $shell_app.namespace((Get-Location).Path + "\$filename")
mkdir luasocket
$destination = $shell_app.namespace((Get-Location).Path + "\luasocket")
$destination.Copyhere($zip_file.items())
Remove-Item $filename

#download bizhawk-co-op
$url = "https://github.com/GhostlyDark/bizhawk-co-op/archive/master.zip"
$filename = "bizhawk-co-op.zip"
Invoke-WebRequest -Uri $url -OutFile $filename
#unzip
$zip_file = $shell_app.namespace((Get-Location).Path + "\$filename")
$destination = $shell_app.namespace((Get-Location).Path)
$destination.Copyhere($zip_file.items())
Remove-Item $filename

#Copy files into Bizhawk
Move-Item -Path .\bizhawk-co-op-master\* -Destination .\BizHawk\
Remove-Item .\bizhawk-co-op-master -Recurse

Move-Item -Path .\luasocket\mime -Destination .\BizHawk\
Move-Item -Path .\luasocket\socket -Destination .\BizHawk\
Move-Item -Path .\luasocket\lua\* -Destination .\BizHawk\Lua\
Move-Item -Path .\luasocket\lua5.1.dll -Destination .\BizHawk\dll\
Remove-Item .\luasocket -Recurse

Start-Process .\bizhawk_prereqs.exe -Wait
Remove-Item .\bizhawk_prereqs.exe
pause
