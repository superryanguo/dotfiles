If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Output "Rerun as Admin!"
    Exit
}

function Add-PowerShellGoodies()
{

    (new-object Net.WebClient).DownloadString("http://psget.net/GetPsGet.ps1") | iex

    Install-Module PSReadline
    # Don't forget to install git to make this work
    Install-Module posh-git
}

#Choco Installs
function Install-Choco([string]$name, 
                       [string]$log_dir="$env:USERPROFILE\Documents\Choco_Install_Logs")
{
    $log_path = "$log_dir\$name.log"
    $date = Get-Date
    Write-Output "Date: $date" > $log_path
    # -append requires newer powershell
    choco install -y $name | Tee-Object -append -file $log_path
}

function Install-All([string]$app_list)
{
    $app_list.Split() | foreach { Install-Choco($_) }
}

$apps = "
firefox
notepadplusplus.install
putty
conemu
virtualbox
androidstudio
"

# add visualstudio2015 after making a config...
# pycharm not on here
# sumatraPDF not on here

$tools = "
jdk8
git.install
sharex
"


# Install-All($tools)
# Install-All($apps)