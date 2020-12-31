# $Id: prof.ps1 239 2019-01-13 14:50:59Z 1234 $
#
# .SYNOPSIS
# 設定書類情報
# .DESCRIPTION
# PowerShellの設定書類の情報を表示します。
#
# .EXAMPLE
# Get-ProfileInfo
# 電算機を再起動します。
function Get-ProfileInfo
{
    $obj = New-Object -TypeName PSObject
    $obj | Add-Member -MemberType NoteProperty -Name FileInfo -Value '$Id: prof.ps1 239 2019-01-13 14:50:59Z 1234 $'
    return $obj
}

# .SYNOPSIS
# プロンプト
# .DESCRIPTION
# プロンプト
#
function prompt
{
  "PS> "
}

# .SYNOPSIS
# 祝福
# .DESCRIPTION
# 時間帶に適合した祝福文字列を返します。
# .PARAMETER Name
# 祝福の對象となる名前
#
# .EXAMPLE
# Get-Greeting -Name Yasu
# Yasuさんに時間帶に適した挨拶をします。
function Get-Greeting([string] $Name="Yasu") {
  $date = Get-Date
  $hour = $date.Hour
  if (6 -le $hour -and $hour -le 11) {
    $greeting = "Good morning "
  } elseif (12 -le $hour -and $hour -le 17) {
    $greeting = "Good afternoon "
  } else {
    $greeting = "Good night "
  }

  $result = $greeting + $Name
  return $result
}

# .SYNOPSIS
# findもどき
# .DESCRIPTION
# UNIXのfindコマンドの擬（もどき）です。
#
# .EXAMPLE
# find . -name *.ps1
# カレント・ディレクトリ以下の擴張子がps1の電子書類をフルパスで表示します。
function find($Directory=".", $Name=$null, $Exec=$null)
{
    Get-ChildItem $Directory -Recurse -Include $Name | %{ $_.FullName }
}

# .SYNOPSIS
# ホームパスに移動
# .DESCRIPTION
# ホームパスに移動します。
#
# .EXAMPLE
# PS> home
# ホームパスに移動します。
function home
{
    Set-Location $home
}

# .SYNOPSIS
# 荒魂のフォルダに移動します。
# .DESCRIPTION
# 荒魂のフォルダに移動します。
#
# .EXAMPLE
# PS> ara
function ara
{
    Set-Location C:\Users\1234\Documents\GitHub\Aratamanokwai.github.io
}

# .SYNOPSIS
# EZOフォルダに移動します。
# .DESCRIPTION
# EZOフォルダに移動します。
#
# .EXAMPLE
# PS> ezo
function ezo
{
    Set-Location C:\Users\1234\Documents\GitHub\py3\ezo
}

Set-Alias -Name grep    -Value Select-String
Set-Alias -Name vi      -Value gvim
Set-Alias -Name sak     -Value "C:\App\sakura\sakura.exe"
Set-Alias -Name typ     -Value typora
Set-Alias -Name py3     -Value python
Set-Alias -Name touch   -Value Set-LastWriteTime
Set-Alias -Name which   -Value Get-Command
#Set-Alias -Name gfs     -Value Get-FileSize
#Set-Alias -Name gap     -Value Get-AllProperties
Set-Alias -Name pbcopy  -Value clip
Set-Alias -Name pbpaste -Value Get-Clipboard

#Import-Module Pester
#Import-Module Pester -MinimumVersion 4.0.3 -Force
