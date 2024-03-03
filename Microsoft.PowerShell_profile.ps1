start-transcript -append -outputdirectory "C:\Users\psoule\OneDrive - VIADEX\Documents\WindowsPowerShell\PSLogs"

Set-Alias pcx C:\sysTools\procexp.exe
set-alias ssh plink
set-alias sid resolve-sid
set-alias pop pop-location
set-alias push push-location
set-alias gs get-syntax
set-alias which get-command
set-alias npp 'C:\Program Files\Notepad++\notepad++.exe'

#dotsource downloaded scripts to import them.
Get-ChildItem -Path "C:\Users\psoule\OneDrive - VIADEX\PSDL" | ForEach-Object {. $($_.FullName)}

function connect-365  {
		write-host "Valid connect cmdlets are: Connect-AzureAD" + "Connect-MicrosoftTeams" + "Connect-MsolService" + "Connect-ExchangeOnline"
	}

function prof {npp $profile}
function resolve-sid($stringsid) {
	$objSID = New-Object System.Security.Principal.SecurityIdentifier ($sid)
	$objUser = $objSID.Translate([System.Security.Principal.NTAccount])
	$objUser.Value
}

$pubaddr = (Resolve-DnsName -Server resolver1.opendns.com -name myip.opendns.com).ipaddress
$privatecert = (dir Cert:\CurrentUser\TrustedPublisher\D8684644F851217AB26261D0A01BD8CD19F05FED)
$amiadmin = [bool](([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -like "S-1-5-32-544")
$localipaddress = @(Get-CimInstance -ClassName Win32_NetworkAdapterConfiguration -Filter "IPEnabled=$true").IPAddress


Register-ArgumentCompleter -Native -CommandName winget -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)
        [Console]::InputEncoding = [Console]::OutputEncoding = $OutputEncoding = [System.Text.Utf8Encoding]::new()
        $Local:word = $wordToComplete.Replace('"', '""')
        $Local:ast = $commandAst.ToString().Replace('"', '""')
        winget complete --word="$Local:word" --commandline "$Local:ast" --position $cursorPosition | ForEach-Object {
            [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
        }
}

Register-ArgumentCompleter -Native -CommandName az -ScriptBlock {
    param($commandName, $wordToComplete, $cursorPosition)
    $completion_file = New-TemporaryFile
    $env:ARGCOMPLETE_USE_TEMPFILES = 1
    $env:_ARGCOMPLETE_STDOUT_FILENAME = $completion_file
    $env:COMP_LINE = $wordToComplete
    $env:COMP_POINT = $cursorPosition
    $env:_ARGCOMPLETE = 1
    $env:_ARGCOMPLETE_SUPPRESS_SPACE = 0
    $env:_ARGCOMPLETE_IFS = "`n"
    $env:_ARGCOMPLETE_SHELL = 'powershell'
    az 2>&1 | Out-Null
    Get-Content $completion_file | Sort-Object | ForEach-Object {
        [System.Management.Automation.CompletionResult]::new($_, $_, "ParameterValue", $_)
    }
    Remove-Item $completion_file, Env:\_ARGCOMPLETE_STDOUT_FILENAME, Env:\ARGCOMPLETE_USE_TEMPFILES, Env:\COMP_LINE, Env:\COMP_POINT, Env:\_ARGCOMPLETE, Env:\_ARGCOMPLETE_SUPPRESS_SPACE, Env:\_ARGCOMPLETE_IFS, Env:\_ARGCOMPLETE_SHELL
}
## show all menu items
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadlineKeyHandler -Key ctrl+d -Function ViExit

#Spin-wheeloflunch
Function Invoke-WheelOfLunch {
    $FastFood = @(
                    "Burger King",
                    "McDonald's",
                    "KFC",
                    "ole cafe",
                    "Obs Cafe",
                    "Sunshine Take-Aways & Mini Market",
                    "Fionas Takeaway",
                    "Obz Fisheries and Take Out",
                    "Narona",
                    "Spar",
                    "Steers",
                    "Altomar Fish And Chips",
                    "Just drink some water dude."
                    )
    $Mexican = @(
                    "Fat Cactus",
                    "Panchos",
                    "Luis Mexican Food & Grill"
                    )
    $Authentic = @(
                    "Blue Marlin Asian Cuisine and Sushi Bar",
                    "1890 House Sushi and Grill",
                    "Simply Asia",
                    "Wok in a Box",
                    "Hibachi Buffet"
                    )
    $Indian = @(
                    "Metropolis Grill",
                    "Curry Mantra"
                    )
    $Italian = @(
                    "Olive Garden",
                    "Marco's Pizza",
                    "Mellow Mushroom",
                    "Atlanta Bread Company",
                    "Marco Ristorante",
                    "Mama Mia"
                    )
    $Pizza = @(
                    "Pizza Hut",
                    "Domino's Pizza",
					"Portalia",
					"Mica Schawarma and Pizza",
					"Pizza Co",
					"YARD DOGS BOLLOCKS AND PIZZA WAREHOUSE",
					"Col Cacchio",
					"love is pizza",
					"salt and sugar rondebosch",
					"Bin rashied rondebosch",
					"narona",
					"frozen meh"
                    )
    $Burgers = @(
                    "Burger King",
                    "McDonalds",
                    "Budddy's Burgers",
                    "Checkers",
                    "Jerry's Burger Bar",
                    "Anvil Burger Co",
                    "StickyBBQ",
                    "Redemption Real Burgers",
                    "Red Robin",
					"Steers",
					"Devils Peak",
					"Hog & Rose",
					"Burgerboss",
					"Rocomamas",
					"Barcelos",
					"Pedros",
					"Obs Cafe",
					"BURGRRR Woodstock",
					"The Mash Tun"
                    )
    $Buffet = @(
                    "Grill & Barrel",
					"Food Inn"		
                    )
    $Vietnamese = @(
                    "Monsoon Thai & Vietnamese",
                    "Thai Pepper"
                    )
    $BBQ = @(
                    "Sticky Fingers BBQ",
                    "Sonny's BBQ"
                    )
    $Frozen = @(
                    "mcdonalds shake?",
                    "marcels",
                    "milky lane"
                    )
    $All = @(
                $FastFood,
                $Mexican,
                $Authentic,
                $Pizza,
                $Burgers,
                $Frozen,
                $Vietnamese,
                $BBQ,
                $Buffet,
                $Italian,
                $Indian
                )
    $Captions = @(
                "Fast Food",
                "Mexican",
                "Authentic",
                "Pizza",
                "Burgers",
                "Frozen",
                "Vietnamese",
                "BBQ",
                "Buffet",
                "Italian",
                "Indian"
                )

    # The magic happens...

    $SelectionNum = Get-Random -Minimum 0 -Maximum $($All.Length-1)
    "Type: "+$Captions[$SelectionNum]
    "Restaurant: "+$All[$SelectionNum][$(Get-Random -Minimum 0 -Maximum $($All[$SelectionNum].Length-1))]
    }

#SYNTAX FUNCTION
function get-syntax([string] $cmdlet) {
   get-command $cmdlet -syntax
}

function Prompt {
	$env:COMPUTERNAME + "\" + (Get-Location) + "\PS#> "
}

# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

##MOTD
Function Get-MOTD {
<#
.NAME
    Get-MOTD
.SYNOPSIS
    Displays system information to a host.
.DESCRIPTION
    The Get-MOTD cmdlet is a system information tool written in PowerShell. 
.EXAMPLE
#>

  [CmdletBinding()]
	
  Param(
    [Parameter(Position=0,Mandatory=$false)]
	[ValidateNotNullOrEmpty()]
    [string[]]$ComputerName
    ,
    [Parameter(Position=1,Mandatory=$false)]
    [PSCredential]
    [System.Management.Automation.CredentialAttribute()]$Credential
  )

  Begin {
	
      If (-Not $ComputerName) {
          $RemoteSession = $null
        }
        #Define ScriptBlock for data collection
        $ScriptBlock = {
            $Operating_System = Get-CimInstance -ClassName Win32_OperatingSystem
            $Logical_Disk = Get-CimInstance -ClassName Win32_LogicalDisk |
            Where-Object -Property DeviceID -eq $Operating_System.SystemDrive
			Try {
				$PCLi = get-module vmware*
				#$PCLi = Get-PowerCLIVersion
				$PCLiVer = ' | PowerCLi ' + [string]$PCLi.Major + '.' + [string]$PCLi.Minor + '.' + [string]$PCLi.Revision + '.' + [string]$PCLi.Build
			} Catch {$PCLiVer = ''}
			If ($DomainName = ([System.Net.NetworkInformation.IPGlobalProperties]::GetIPGlobalProperties()).DomainName) {$DomainName = '.' + $DomainName}
			
           [pscustomobject]@{
               Operating_System = $Operating_System
                Processor = Get-CimInstance -ClassName Win32_Processor
                Process_Count = (Get-Process).Count
                Shell_Info = ("{0}.{1}" -f $PSVersionTable.PSVersion.Major,$PSVersionTable.PSVersion.Minor) + $PCLiVer
                Logical_Disk = $Logical_Disk
            }
        }
} #End Begin

  Process {
        If ($ComputerName) {
            If ("$ComputerName" -ne "$env:ComputerName") {
                # Build Hash to be used for passing parameters to 
                # New-PSSession commandlet
                $PSSessionParams = @{
                    ComputerName = $ComputerName
                    ErrorAction = 'Stop'
                }

                # Add optional parameters to hash
                If ($Credential) {
                    $PSSessionParams.Add('Credential', $Credential)
                }
                # Create remote powershell session   
                Try {
                    $RemoteSession = New-PSSession @PSSessionParams
                }
                Catch {
                    Throw $_.Exception.Message
                }
            } Else { 
                $RemoteSession = $null
            }
        }
        # Build Hash to be used for passing parameters to 
        # Invoke-Command commandlet
        $CommandParams = @{
            ScriptBlock = $ScriptBlock
            ErrorAction = 'Stop'
        }
        
        # Add optional parameters to hash
        If ($RemoteSession) {
            $CommandParams.Add('Session', $RemoteSession)
        }
               
        # Run ScriptBlock    
        Try {
            $ReturnedValues = Invoke-Command @CommandParams
        }
        Catch {
            If ($RemoteSession) {
            	Remove-PSSession $RemoteSession
            }
            Throw $_.Exception.Message
        }

        # Assign variables
        $Date = Get-Date
        $OS_Name = $ReturnedValues.Operating_System.Caption + ' [Installed: ' + ([datetime]$ReturnedValues.Operating_System.InstallDate).ToString('dd-MMM-yyyy') + ']'
        $Computer_Name = $ReturnedValues.Operating_System.CSName
		If ($DomainName) {$Computer_Name = $Computer_Name + $DomainName.ToUpper()}
        $Kernel_Info = $ReturnedValues.Operating_System.Version + ' [' + $ReturnedValues.Operating_System.OSArchitecture + ']'
        $Process_Count = $ReturnedValues.Process_Count
        $Uptime = "$(($Uptime = $Date - $($ReturnedValues.Operating_System.LastBootUpTime)).Days) days, $($Uptime.Hours) hours, $($Uptime.Minutes) minutes"
        $Shell_Info = $ReturnedValues.Shell_Info
        $CPU_Info = $ReturnedValues.Processor.Name -replace '\(C\)', '' -replace '\(R\)', '' -replace '\(TM\)', '' -replace 'CPU', '' -replace '\s+', ' '
        $Current_Load = $ReturnedValues.Processor.LoadPercentage    
        $Memory_Size = "{0} MB/{1} MB " -f (([math]::round($ReturnedValues.Operating_System.TotalVisibleMemorySize/1KB))-
        ([math]::round($ReturnedValues.Operating_System.FreePhysicalMemory/1KB))),([math]::round($ReturnedValues.Operating_System.TotalVisibleMemorySize/1KB))
		$Disk_Size = "{0} GB/{1} GB" -f (([math]::round($ReturnedValues.Logical_Disk.Size/1GB)-
        [math]::round($ReturnedValues.Logical_Disk.FreeSpace/1GB))),([math]::round($ReturnedValues.Logical_Disk.Size/1GB))

        # Write to the Console
        Write-Host -Object ("")
        Write-Host -Object ("")
        Write-Host -Object ("         ,.=:^!^!t3Z3z.,                  ") -ForegroundColor Red
        Write-Host -Object ("        :tt:::tt333EE3                    ") -ForegroundColor Red
        Write-Host -Object ("        Et:::ztt33EEE ") -NoNewline -ForegroundColor Red
        Write-Host -Object (" @Ee.,      ..,     $($Date.ToString('dd-MMM-yyyy HH:mm:ss'))") -ForegroundColor Green
        Write-Host -Object ("       ;tt:::tt333EE7") -NoNewline -ForegroundColor Red
        Write-Host -Object (" ;EEEEEEttttt33#     ") -ForegroundColor Green
        Write-Host -Object ("      :Et:::zt333EEQ.") -NoNewline -ForegroundColor Red
        Write-Host -Object (" SEEEEEttttt33QL     ") -NoNewline -ForegroundColor Green
        Write-Host -Object ("User: ") -NoNewline -ForegroundColor Red
        Write-Host -Object ("$env:USERDOMAIN\$env:UserName") -ForegroundColor Cyan
        Write-Host -Object ("      it::::tt333EEF") -NoNewline -ForegroundColor Red
        Write-Host -Object (" @EEEEEEttttt33F      ") -NoNewline -ForeGroundColor Green
        Write-Host -Object ("Hostname: ") -NoNewline -ForegroundColor Red
        Write-Host -Object ("$Computer_Name") -ForegroundColor Cyan
        Write-Host -Object ("     ;3=*^``````'*4EEV") -NoNewline -ForegroundColor Red
        Write-Host -Object (" :EEEEEEttttt33@.      ") -NoNewline -ForegroundColor Green
        Write-Host -Object ("OS: ") -NoNewline -ForegroundColor Red
        Write-Host -Object ("$OS_Name") -ForegroundColor Cyan
        Write-Host -Object ("     ,.=::::it=., ") -NoNewline -ForegroundColor Cyan
        Write-Host -Object ("``") -NoNewline -ForegroundColor Red
        Write-Host -Object (" @EEEEEEtttz33QF       ") -NoNewline -ForegroundColor Green
        Write-Host -Object ("Kernel: ") -NoNewline -ForegroundColor Red
        Write-Host -Object ("NT ") -NoNewline -ForegroundColor Cyan
        Write-Host -Object ("$Kernel_Info") -ForegroundColor Cyan
        Write-Host -Object ("    ;::::::::zt33) ") -NoNewline -ForegroundColor Cyan
        Write-Host -Object ("  '4EEEtttji3P*        ") -NoNewline -ForegroundColor Green
        Write-Host -Object ("Uptime: ") -NoNewline -ForegroundColor Red
        Write-Host -Object ("$Uptime") -ForegroundColor Cyan
        Write-Host -Object ("   :t::::::::tt33.") -NoNewline -ForegroundColor Cyan
        Write-Host -Object (":Z3z.. ") -NoNewline -ForegroundColor Yellow
        Write-Host -Object (" ````") -NoNewline -ForegroundColor Green
        Write-Host -Object (" ,..g.        ") -NoNewline -ForegroundColor Yellow
        Write-Host -Object ("Shell: ") -NoNewline -ForegroundColor Red
        Write-Host -Object ("PowerShell $Shell_Info") -ForegroundColor Cyan
        Write-Host -Object ("   i::::::::zt33F") -NoNewline -ForegroundColor Cyan
        Write-Host -Object (" AEEEtttt::::ztF         ") -NoNewline -ForegroundColor Yellow
        Write-Host -Object ("CPU: ") -NoNewline -ForegroundColor Red
        Write-Host -Object ("$CPU_Info") -ForegroundColor Cyan
        Write-Host -Object ("  ;:::::::::t33V") -NoNewline -ForegroundColor Cyan
        Write-Host -Object (" ;EEEttttt::::t3          ") -NoNewline -ForegroundColor Yellow
        Write-Host -Object ("Processes: ") -NoNewline -ForegroundColor Red
        Write-Host -Object ("$Process_Count") -ForegroundColor Cyan
        Write-Host -Object ("  E::::::::zt33L") -NoNewline -ForegroundColor Cyan
        Write-Host -Object (" @EEEtttt::::z3F          ") -NoNewline -ForegroundColor Yellow
        Write-Host -Object ("Current Load: ") -NoNewline -ForegroundColor Red
        Write-Host -Object ("$Current_Load") -NoNewline -ForegroundColor Cyan
        Write-Host -Object ("%") -ForegroundColor Cyan
        Write-Host -Object (" {3=*^``````'*4E3)") -NoNewline -ForegroundColor Cyan
        Write-Host -Object (" ;EEEtttt:::::tZ``          ") -NoNewline -ForegroundColor Yellow
        Write-Host -Object ("Memory: ") -NoNewline -ForegroundColor Red
        Write-Host -Object ("$Memory_Size`t") -ForegroundColor Cyan -NoNewline
		New-PercentageBar -DrawBar -Value (([math]::round($ReturnedValues.Operating_System.TotalVisibleMemorySize/1KB))-([math]::round($ReturnedValues.Operating_System.FreePhysicalMemory/1KB))) -MaxValue ([math]::round($ReturnedValues.Operating_System.TotalVisibleMemorySize/1KB)); "`r"
        Write-Host -Object ("             ``") -NoNewline -ForegroundColor Cyan
        Write-Host -Object (" :EEEEtttt::::z7            ") -NoNewline -ForegroundColor Yellow
        Write-Host -Object ("System Volume: ") -NoNewline -ForegroundColor Red
        Write-Host -Object ("$Disk_Size`t") -ForegroundColor Cyan -NoNewline
		New-PercentageBar -DrawBar -Value (([math]::round($ReturnedValues.Logical_Disk.Size/1GB)-[math]::round($ReturnedValues.Logical_Disk.FreeSpace/1GB))) -MaxValue ([math]::round($ReturnedValues.Logical_Disk.Size/1GB)); "`r"
        Write-Host -Object ("                 'VEzjt:;;z>*``            ") -ForegroundColor Yellow -NoNewLine
		Write-Host -Object ("Am I Admin? ") -ForegroundColor Red -NoNewLine
		Write-Host -Object ($amiadmin) -ForegroundColor Cyan
        Write-Host -Object ("                      ````                  ") -ForegroundColor Yellow -NoNewLine
        Write-Host -Object ("Local IPs: ") -ForegroundColor Red -NoNewLine
		write-host $localipaddress -ForegroundColor Cyan -NoNewline
		Write-Host -Object (" Public IP: ") -ForegroundColor Red -NoNewLine
		Write-Host $pubaddr -ForegroundColor Cyan	
  } #End Process

  End {
        If ($RemoteSession) {
            Remove-PSSession $RemoteSession
        }
  }
} #End Function Get-MOTD

cls
get-motd
get-alias | get-random -count 10 | ft @{label='aliases'; expression={$_.displayname}},helpuri
#set the enumerationlimit to extend long strings.
$formatenumerationlimit = -1
prompt

# SIG # Begin signature block
# MIIaJgYJKoZIhvcNAQcCoIIaFzCCGhMCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCBO3S3NyDKj+0N9
# tHxEfDZnnDtXpfG+gwmx8/ifn6EvCaCCFI0wggafMIIEh6ADAgECAhMVAAAD5RV+
# B1ns5hBMAAAAAAPlMA0GCSqGSIb3DQEBDQUAMFcxEzARBgoJkiaJk/IsZAEZFgNj
# b20xGzAZBgoJkiaJk/IsZAEZFgtFeGNvdGVra2VyMTEjMCEGA1UEAxMaVmlhZGV4
# Q2VydGlmaWNhdGVBdXRob3JpdHkwHhcNMjMwMjEwMDgyMDM1WhcNMjQwMjEwMDgy
# MDM1WjB4MRMwEQYKCZImiZPyLGQBGRYDY29tMRswGQYKCZImiZPyLGQBGRYLRXhj
# b3Rla2tlcjExFzAVBgNVBAsTDlZpYWRleC1FeGNvdGVrMRcwFQYDVQQLEw5BZG1p
# bmlzdHJhdG9yczESMBAGA1UEAxMJQURNIFBldGVyMIGfMA0GCSqGSIb3DQEBAQUA
# A4GNADCBiQKBgQDrlMW6me5Dv5zYQn61AzABfeo5WXyomYzHz29M4ExIBSnvGRqZ
# FIAfKAXtk5uxJOgFj99nIioICjaF2Ht1KGlTHb3nWUzewMXJ51gQk25rRyWXb4D0
# 6X7cEWgOQxzPbgEvaVLvOQbpKJDsJp4IquLkUEVlD0hgJtIMS409I/LODwIDAQAB
# o4ICxTCCAsEwJQYJKwYBBAGCNxQCBBgeFgBDAG8AZABlAFMAaQBnAG4AaQBuAGcw
# EwYDVR0lBAwwCgYIKwYBBQUHAwMwCwYDVR0PBAQDAgeAMB0GA1UdDgQWBBTPjQgu
# CEpvNpyFc4GPiqt0/Z0cQDAfBgNVHSMEGDAWgBQowBz5p83JvlngO04U61JtTMvB
# jjCB3AYDVR0fBIHUMIHRMIHOoIHLoIHIhoHFbGRhcDovLy9DTj1WaWFkZXhDZXJ0
# aWZpY2F0ZUF1dGhvcml0eSxDTj1WSUFEQzAzLENOPUNEUCxDTj1QdWJsaWMlMjBL
# ZXklMjBTZXJ2aWNlcyxDTj1TZXJ2aWNlcyxDTj1Db25maWd1cmF0aW9uLERDPUV4
# Y290ZWtrZXIxLERDPWNvbT9jZXJ0aWZpY2F0ZVJldm9jYXRpb25MaXN0P2Jhc2U/
# b2JqZWN0Q2xhc3M9Y1JMRGlzdHJpYnV0aW9uUG9pbnQwgdAGCCsGAQUFBwEBBIHD
# MIHAMIG9BggrBgEFBQcwAoaBsGxkYXA6Ly8vQ049VmlhZGV4Q2VydGlmaWNhdGVB
# dXRob3JpdHksQ049QUlBLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNl
# cnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9RXhjb3Rla2tlcjEsREM9Y29tP2NB
# Q2VydGlmaWNhdGU/YmFzZT9vYmplY3RDbGFzcz1jZXJ0aWZpY2F0aW9uQXV0aG9y
# aXR5MDQGA1UdEQQtMCugKQYKKwYBBAGCNxQCA6AbDBlhZG0ucGV0ZXJARXhjb3Rl
# a2tlcjEuY29tME4GCSsGAQQBgjcZAgRBMD+gPQYKKwYBBAGCNxkCAaAvBC1TLTEt
# NS0yMS0xOTU3OTk0NDg4LTgyMzUxODIwNC02ODIwMDMzMzAtMTc3NDMwDQYJKoZI
# hvcNAQENBQADggIBAHYlR3HKxeHCCVnBXE+CjTFZXzVL1KBD+b655xnDIqVDwfnj
# uBnKj0GS0kB06SuvO4rU3ga3Qs+a0n9obK8P7Z80C/rpR4rF/PazQZAe82PnDXpP
# Xpx0mITS24OaJLcRMA5H9FrRVnhMayLwQLV0V4sxutJRO2oXyxbJN7O54WSYDEVb
# im+6Auj+kbpjKzR78KiJdInWXAqCmEFVPm8liIfk6K7qebodT0QoXbB0q4vUzPbS
# JR6XPAJ/x4ABCCBWr9y69HWJEjTZPVzeSKc9yqQrXsdKFpOoisOYdGpHoYGgAx4q
# piPDZsCa9AH2PRs137WlPQ1q28lSVNot3QDesnSUKHsoy56aRA87ijB8bhHxkTIj
# j6PWlzU0qvlc/yMVlhHYrivahkR2cO0aii7L22OzxPM+EGwSv5n/uCUKcIDhKr0m
# JL1jttINMJ4J1CwZM80R4j5mjQjairbv0ayoanFmlUgc0lFDoRQgCboB1mOIBb8G
# O/drN49gifDaVX4ZL/nnlBy//+4zQr+T1aavxBNGrsFEnTChvjkupbM5XXBG44il
# /XpoQPsW9iQ+0IjhDKuUNR9THjERKlZZMwhdwbwHCInwhZaywKAyRcmaulKTdjZv
# NuuZFgNbMgJsv6yE72fNR4h/MkETEdRzVDzAYLmrlBRi/gEtunkIP5oa2D1DMIIG
# 7DCCBNSgAwIBAgIQMA9vrN1mmHR8qUY2p3gtuTANBgkqhkiG9w0BAQwFADCBiDEL
# MAkGA1UEBhMCVVMxEzARBgNVBAgTCk5ldyBKZXJzZXkxFDASBgNVBAcTC0plcnNl
# eSBDaXR5MR4wHAYDVQQKExVUaGUgVVNFUlRSVVNUIE5ldHdvcmsxLjAsBgNVBAMT
# JVVTRVJUcnVzdCBSU0EgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkwHhcNMTkwNTAy
# MDAwMDAwWhcNMzgwMTE4MjM1OTU5WjB9MQswCQYDVQQGEwJHQjEbMBkGA1UECBMS
# R3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9T
# ZWN0aWdvIExpbWl0ZWQxJTAjBgNVBAMTHFNlY3RpZ28gUlNBIFRpbWUgU3RhbXBp
# bmcgQ0EwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDIGwGv2Sx+iJl9
# AZg/IJC9nIAhVJO5z6A+U++zWsB21hoEpc5Hg7XrxMxJNMvzRWW5+adkFiYJ+9Uy
# UnkuyWPCE5u2hj8BBZJmbyGr1XEQeYf0RirNxFrJ29ddSU1yVg/cyeNTmDoqHvzO
# WEnTv/M5u7mkI0Ks0BXDf56iXNc48RaycNOjxN+zxXKsLgp3/A2UUrf8H5VzJD0B
# KLwPDU+zkQGObp0ndVXRFzs0IXuXAZSvf4DP0REKV4TJf1bgvUacgr6Unb+0ILBg
# frhN9Q0/29DqhYyKVnHRLZRMyIw80xSinL0m/9NTIMdgaZtYClT0Bef9Maz5yIUX
# x7gpGaQpL0bj3duRX58/Nj4OMGcrRrc1r5a+2kxgzKi7nw0U1BjEMJh0giHPYla1
# IXMSHv2qyghYh3ekFesZVf/QOVQtJu5FGjpvzdeE8NfwKMVPZIMC1Pvi3vG8Aij0
# bdonigbSlofe6GsO8Ft96XZpkyAcSpcsdxkrk5WYnJee647BeFbGRCXfBhKaBi2f
# A179g6JTZ8qx+o2hZMmIklnLqEbAyfKm/31X2xJ2+opBJNQb/HKlFKLUrUMcpEmL
# QTkUAx4p+hulIq6lw02C0I3aa7fb9xhAV3PwcaP7Sn1FNsH3jYL6uckNU4B9+rY5
# WDLvbxhQiddPnTO9GrWdod6VQXqngwIDAQABo4IBWjCCAVYwHwYDVR0jBBgwFoAU
# U3m/WqorSs9UgOHYm8Cd8rIDZsswHQYDVR0OBBYEFBqh+GEZIA/DQXdFKI7RNV8G
# EgRVMA4GA1UdDwEB/wQEAwIBhjASBgNVHRMBAf8ECDAGAQH/AgEAMBMGA1UdJQQM
# MAoGCCsGAQUFBwMIMBEGA1UdIAQKMAgwBgYEVR0gADBQBgNVHR8ESTBHMEWgQ6BB
# hj9odHRwOi8vY3JsLnVzZXJ0cnVzdC5jb20vVVNFUlRydXN0UlNBQ2VydGlmaWNh
# dGlvbkF1dGhvcml0eS5jcmwwdgYIKwYBBQUHAQEEajBoMD8GCCsGAQUFBzAChjNo
# dHRwOi8vY3J0LnVzZXJ0cnVzdC5jb20vVVNFUlRydXN0UlNBQWRkVHJ1c3RDQS5j
# cnQwJQYIKwYBBQUHMAGGGWh0dHA6Ly9vY3NwLnVzZXJ0cnVzdC5jb20wDQYJKoZI
# hvcNAQEMBQADggIBAG1UgaUzXRbhtVOBkXXfA3oyCy0lhBGysNsqfSoF9bw7J/Ra
# oLlJWZApbGHLtVDb4n35nwDvQMOt0+LkVvlYQc/xQuUQff+wdB+PxlwJ+TNe6qAc
# Jlhc87QRD9XVw+K81Vh4v0h24URnbY+wQxAPjeT5OGK/EwHFhaNMxcyyUzCVpNb0
# llYIuM1cfwGWvnJSajtCN3wWeDmTk5SbsdyybUFtZ83Jb5A9f0VywRsj1sJVhGbk
# s8VmBvbz1kteraMrQoohkv6ob1olcGKBc2NeoLvY3NdK0z2vgwY4Eh0khy3k/ALW
# PncEvAQ2ted3y5wujSMYuaPCRx3wXdahc1cFaJqnyTdlHb7qvNhCg0MFpYumCf/R
# oZSmTqo9CfUFbLfSZFrYKiLCS53xOV5M3kg9mzSWmglfjv33sVKRzj+J9hyhtal1
# H3G/W0NdZT1QgW6r8NDT/LKzH7aZlib0PHmLXGTMze4nmuWgwAxyh8FuTVrTHurw
# ROYybxzrF06Uw3hlIDsPQaof6aFBnf6xuKBlKjTg3qj5PObBMLvAoGMs/FwWAKjQ
# xH/qEZ0eBsambTJdtDgJK0kHqv3sMNrxpy/Pt/360KOE2See+wFmd7lWEOEgbsau
# sfm2usg1XTN2jvF8IAwqd661ogKGuinutFoAsYyr4/kKyVRd1LlqdJ69SK6YMIIG
# 9jCCBN6gAwIBAgIRAJA5f5rSSjoT8r2RXwg4qUMwDQYJKoZIhvcNAQEMBQAwfTEL
# MAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UE
# BxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMSUwIwYDVQQDExxT
# ZWN0aWdvIFJTQSBUaW1lIFN0YW1waW5nIENBMB4XDTIyMDUxMTAwMDAwMFoXDTMz
# MDgxMDIzNTk1OVowajELMAkGA1UEBhMCR0IxEzARBgNVBAgTCk1hbmNoZXN0ZXIx
# GDAWBgNVBAoTD1NlY3RpZ28gTGltaXRlZDEsMCoGA1UEAwwjU2VjdGlnbyBSU0Eg
# VGltZSBTdGFtcGluZyBTaWduZXIgIzMwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAw
# ggIKAoICAQCQsnE/eeHUuYoXzMOXwpCUcu1aOm8BQ39zWiifJHygNUAG+pSvCqGD
# thPkSxUGXmqKIDRxe7slrT9bCqQfL2x9LmFR0IxZNz6mXfEeXYC22B9g480Saogf
# xv4Yy5NDVnrHzgPWAGQoViKxSxnS8JbJRB85XZywlu1aSY1+cuRDa3/JoD9sSq3V
# AE+9CriDxb2YLAd2AXBF3sPwQmnq/ybMA0QfFijhanS2nEX6tjrOlNEfvYxlqv38
# wzzoDZw4ZtX8fR6bWYyRWkJXVVAWDUt0cu6gKjH8JgI0+WQbWf3jOtTouEEpdAE/
# DeATdysRPPs9zdDn4ZdbVfcqA23VzWLazpwe/OpwfeZ9S2jOWilh06BcJbOlJ2ij
# WP31LWvKX2THaygM2qx4Qd6S7w/F7KvfLW8aVFFsM7ONWWDn3+gXIqN5QWLP/Hvz
# ktqu4DxPD1rMbt8fvCKvtzgQmjSnC//+HV6k8+4WOCs/rHaUQZ1kHfqA/QDh/vg6
# 1MNeu2lNcpnl8TItUfphrU3qJo5t/KlImD7yRg1psbdu9AXbQQXGGMBQ5Pit/qxj
# YUeRvEa1RlNsxfThhieThDlsdeAdDHpZiy7L9GQsQkf0VFiFN+XHaafSJYuWv8at
# 4L2xN/cf30J7qusc6es9Wt340pDVSZo6HYMaV38cAcLOHH3M+5YVxQIDAQABo4IB
# gjCCAX4wHwYDVR0jBBgwFoAUGqH4YRkgD8NBd0UojtE1XwYSBFUwHQYDVR0OBBYE
# FCUuaDxrmiskFKkfot8mOs8UpvHgMA4GA1UdDwEB/wQEAwIGwDAMBgNVHRMBAf8E
# AjAAMBYGA1UdJQEB/wQMMAoGCCsGAQUFBwMIMEoGA1UdIARDMEEwNQYMKwYBBAGy
# MQECAQMIMCUwIwYIKwYBBQUHAgEWF2h0dHBzOi8vc2VjdGlnby5jb20vQ1BTMAgG
# BmeBDAEEAjBEBgNVHR8EPTA7MDmgN6A1hjNodHRwOi8vY3JsLnNlY3RpZ28uY29t
# L1NlY3RpZ29SU0FUaW1lU3RhbXBpbmdDQS5jcmwwdAYIKwYBBQUHAQEEaDBmMD8G
# CCsGAQUFBzAChjNodHRwOi8vY3J0LnNlY3RpZ28uY29tL1NlY3RpZ29SU0FUaW1l
# U3RhbXBpbmdDQS5jcnQwIwYIKwYBBQUHMAGGF2h0dHA6Ly9vY3NwLnNlY3RpZ28u
# Y29tMA0GCSqGSIb3DQEBDAUAA4ICAQBz2u1ocsvCuUChMbu0A6MtFHsk57RbFX2o
# 6f2t0ZINfD02oGnZ85ow2qxp1nRXJD9+DzzZ9cN5JWwm6I1ok87xd4k5f6gEBdo0
# wxTqnwhUq//EfpZsK9OU67Rs4EVNLLL3OztatcH714l1bZhycvb3Byjz07LQ6xm+
# FSx4781FoADk+AR2u1fFkL53VJB0ngtPTcSqE4+XrwE1K8ubEXjp8vmJBDxO44IS
# Yuu0RAx1QcIPNLiIncgi8RNq2xgvbnitxAW06IQIkwf5fYP+aJg05Hflsc6MlGzb
# A20oBUd+my7wZPvbpAMxEHwa+zwZgNELcLlVX0e+OWTOt9ojVDLjRrIy2NIphskV
# XYCVrwL7tNEunTh8NeAPHO0bR0icImpVgtnyughlA+XxKfNIigkBTKZ58qK2GpmU
# 65co4b59G6F87VaApvQiM5DkhFP8KvrAp5eo6rWNes7k4EuhM6sLdqDVaRa3jma/
# X/ofxKh/p6FIFJENgvy9TZntyeZsNv53Q5m4aS18YS/to7BJ/lu+aSSR/5P8V2mS
# S9kFP22GctOi0MBk0jpCwRoD+9DtmiG4P6+mslFU1UzFyh8SjVfGOe1c/+yfJnat
# ZGZn6Kow4NKtt32xakEnbgOKo3TgigmCbr/j9re8ngspGGiBoZw/bhZZSxQJCZrm
# rr9gFd2G9TGCBO8wggTrAgEBMG4wVzETMBEGCgmSJomT8ixkARkWA2NvbTEbMBkG
# CgmSJomT8ixkARkWC0V4Y290ZWtrZXIxMSMwIQYDVQQDExpWaWFkZXhDZXJ0aWZp
# Y2F0ZUF1dGhvcml0eQITFQAAA+UVfgdZ7OYQTAAAAAAD5TANBglghkgBZQMEAgEF
# AKCBhDAYBgorBgEEAYI3AgEMMQowCKACgAChAoAAMBkGCSqGSIb3DQEJAzEMBgor
# BgEEAYI3AgEEMBwGCisGAQQBgjcCAQsxDjAMBgorBgEEAYI3AgEVMC8GCSqGSIb3
# DQEJBDEiBCCfSU83y+wpEzqAZyBAY8AXln20EGYblez29VbY3JJn1zANBgkqhkiG
# 9w0BAQEFAASBgJWUY0GW1eC/8jqaJU8jh5ahZlMUrHvO3MNYrGugqGwd+CUMsZEn
# UXCdJaBM+cKpMR6kkkYnT9Gpqc2mbGX29u24bCaROV1u1chUwNjUqIUbv0RQDflO
# AoUK1ig9ZaAqCKmpXTqYx7RCR9KvPy92N3XdbkiN9tJB8sbvbuSepkeioYIDTDCC
# A0gGCSqGSIb3DQEJBjGCAzkwggM1AgEBMIGSMH0xCzAJBgNVBAYTAkdCMRswGQYD
# VQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGDAWBgNV
# BAoTD1NlY3RpZ28gTGltaXRlZDElMCMGA1UEAxMcU2VjdGlnbyBSU0EgVGltZSBT
# dGFtcGluZyBDQQIRAJA5f5rSSjoT8r2RXwg4qUMwDQYJYIZIAWUDBAICBQCgeTAY
# BgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMzAzMjEw
# MDI2NThaMD8GCSqGSIb3DQEJBDEyBDD3lk+dsyproCSPZQlcIfxR1GZa3jNG68FG
# cojwg8ZIq4GLw6ckVKUCJoqSvvwht7gwDQYJKoZIhvcNAQEBBQAEggIAdfOKwD+n
# viVdtFibaDSHl5kujfg4ZvokFx8aDdVlgSmkBz/Ae+8WbGbJ/z/LP3Cutu5SwnDw
# 3VjlYX6FLx23JLQWeRCR3ODN/0QRNNvzcFWBex2AeCI1q0W/FxEeXyk4BzzfZTH4
# XX+BYyas0QJu1g+WMhRqat6Q6PyxcN36vDYCNiPQsGf/70tNExzluaE73lul9Dy9
# CXuP6O1OYJDZE53fTAuBDBshgp/wMtdwZfttsTT5yERc/Lp2LSN+D6fmYkyI7xUM
# c9eMa6u1UDXU4AcZp8/r5upUYnN35FgOEdzG3JNv9yLvbcYURJGElYNfQVreoGQr
# RxB+MG+JYC3XSpQ42EiCJQmF1rcbA5dCJjxqOe1BZ77jIkIk7Wr3rQ3d/HaEnYga
# hpaxsYwGx0RJpSdGzcRSCScZcs0MNVjVo5LmctpnNSOUkzygbCabT3vCZXTOvggw
# OWGdEGi7XLG6MYwzOMXLfPqmx20gi8wFWxgojDRqgJ3DtF6lUFP0Ucj2ywyJrFP5
# UAgY7gU/cVzUFU7aIF5FHgzdsbGeEatWKNia1k6Wrm5kMxQ7yEeRQOhoeMrdOGpC
# o6uNjEuohvoiWsAROsp7cNSWt3+rSOypvW5YhKoD2nI9ikwuzSwTKa1ryiC5sCvi
# D3wAHz+q2PF781VCVOaEcNDl1Ic03kp4NaI=
# SIG # End signature block
