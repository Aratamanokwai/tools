# $Id: prof.ps1 239 2019-01-13 14:50:59Z 1234 $
#
# .SYNOPSIS
# �ݒ菑�ޏ��
# .DESCRIPTION
# PowerShell�̐ݒ菑�ނ̏���\�����܂��B
#
# .EXAMPLE
# Get-ProfileInfo
# �d�Z�@���ċN�����܂��B
function Get-ProfileInfo
{
    $obj = New-Object -TypeName PSObject
    $obj | Add-Member -MemberType NoteProperty -Name FileInfo -Value '$Id: prof.ps1 239 2019-01-13 14:50:59Z 1234 $'
    return $obj
}

# .SYNOPSIS
# �v�����v�g
# .DESCRIPTION
# �v�����v�g
#
function prompt
{
  "PS> "
}

# .SYNOPSIS
# �j��
# .DESCRIPTION
# ���ԛ�ɓK�������j���������Ԃ��܂��B
# .PARAMETER Name
# �j���̛��ۂƂȂ閼�O
#
# .EXAMPLE
# Get-Greeting -Name Yasu
# Yasu����Ɏ��ԛ�ɓK�������A�����܂��B
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
# find���ǂ�
# .DESCRIPTION
# UNIX��find�R�}���h�̋[�i���ǂ��j�ł��B
#
# .EXAMPLE
# find . -name *.ps1
# �J�����g�E�f�B���N�g���ȉ��̝����q��ps1�̓d�q���ނ��t���p�X�ŕ\�����܂��B
function find($Directory=".", $Name=$null, $Exec=$null)
{
    Get-ChildItem $Directory -Recurse -Include $Name | %{ $_.FullName }
}

# .SYNOPSIS
# �z�[���p�X�Ɉړ�
# .DESCRIPTION
# �z�[���p�X�Ɉړ����܂��B
#
# .EXAMPLE
# PS> home
# �z�[���p�X�Ɉړ����܂��B
function home
{
    Set-Location $home
}

# .SYNOPSIS
# �r���̃t�H���_�Ɉړ����܂��B
# .DESCRIPTION
# �r���̃t�H���_�Ɉړ����܂��B
#
# .EXAMPLE
# PS> ara
function ara
{
    Set-Location C:\Users\1234\Documents\GitHub\Aratamanokwai.github.io
}

# .SYNOPSIS
# EZO�t�H���_�Ɉړ����܂��B
# .DESCRIPTION
# EZO�t�H���_�Ɉړ����܂��B
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
