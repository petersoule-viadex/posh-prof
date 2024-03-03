# Start a transcript of all PowerShell commands and output
start-transcript -append -outputdirectory "C:\Users\psoule\OneDrive - VIADEX\Documents\WindowsPowerShell\PSLogs"

# Set aliases for various commands
Set-Alias pcx C:\sysTools\procexp.exe
set-alias ssh plink
set-alias sid resolve-sid
set-alias pop pop-location
set-alias push push-location
set-alias gs get-syntax
set-alias which get-command
set-alias npp 'C:\Program Files\Notepad++\notepad++.exe'

# Dot-source downloaded scripts to import them
Get-ChildItem -Path "C:\Users\psoule\OneDrive - VIADEX\PSDL" | ForEach-Object {. $($_.FullName)}

# Function to connect to Microsoft 365 services
function connect-365  {
    write-host "Valid connect cmdlets are: Connect-AzureAD" + "Connect-MicrosoftTeams" + "Connect-MsolService" + "Connect-ExchangeOnline"
}

# Function to open the current profile script in Notepad++
function prof {npp $profile}

# Function to resolve a security identifier (SID) to a user name
function resolve-sid($stringsid) {
    $objSID = New-Object System.Security.Principal.SecurityIdentifier ($sid)
    $objUser = $objSID.Translate([System.Security.Principal.NTAccount])
    $objUser.Value
}

# Get public IP address
$pubaddr = (Resolve-DnsName -Server resolver1.opendns.com -name myip.opendns.com).ipaddress

# Get private certificate
$privatecerts = (Get-ChildItem Cert:\CurrentUser\TrustedPublisher\)

# Check if current user is an admin
$amiadmin = [bool](([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -like "S-1-5-32-544")

# Get local IP address
$localipaddress = @(Get-CimInstance -ClassName Win32_NetworkAdapterConfiguration -Filter "IPEnabled=$true").IPAddress

# Register argument completer for winget command
Register-ArgumentCompleter -Native -CommandName winget -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)
        [Console]::InputEncoding = [Console]::OutputEncoding = $OutputEncoding = [System.Text.Utf8Encoding]::new()
        $Local:word = $wordToComplete.Replace('"', '""')
        $Local:ast = $commandAst.ToString().Replace('"', '""')
        winget complete --word="$Local:word" --commandline "$Local:ast" --position $cursorPosition | ForEach-Object {
            [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
        }
}
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
$privatecert = (Get-ChildItem Cert:\CurrentUser\TrustedPublisher\D8684644F851217AB26261D0A01BD8CD19F05FED)
$amiadmin = [bool](([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -like "S-1-5-32-544")
$localipaddress = @(Get-CimInstance -ClassName Win32_NetworkAdapterConfiguration -Filter "IPEnabled=$true").IPAddress


# Register an argument completer for the 'winget' command
Register-ArgumentCompleter -Native -CommandName winget -ScriptBlock {
    param(
        # The word being completed
        $wordToComplete, 
        # The command abstract syntax tree (AST)
        $commandAst, 
        # The cursor position relative to the start of the word being completed
        $cursorPosition
    )

    # Set the input and output encoding to UTF-8
    [Console]::InputEncoding = [Console]::OutputEncoding = $OutputEncoding = [System.Text.Utf8Encoding]::new()

    # Replace any double quotes in the word and command AST with two double quotes
    $Local:word = $wordToComplete.Replace('"', '""')
    $Local:ast = $commandAst.ToString().Replace('"', '""')

    # Execute the 'winget complete' command with the word, command line, and position parameters
    # For each output line, create a new CompletionResult object
    winget complete --word="$Local:word" --commandline "$Local:ast" --position $cursorPosition | ForEach-Object {
        [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
    }
}
# Define the script block for argument completion of the 'az' command
$azArgumentCompleter = {
    param(
        # The name of the command for which argument completion is being registered
        $commandName, 
        # The word being completed
        $wordToComplete, 
        # The cursor position relative to the start of the word being completed
        $cursorPosition
    )

    # Create a temporary file to store the completion results
    $completion_file = New-TemporaryFile

    # Set environment variables used by the 'az' command to generate completion results
    $env:ARGCOMPLETE_USE_TEMPFILES = 1
    $env:_ARGCOMPLETE_STDOUT_FILENAME = $completion_file
    $env:COMP_LINE = $wordToComplete
    $env:COMP_POINT = $cursorPosition
    $env:_ARGCOMPLETE = 1
    $env:_ARGCOMPLETE_SUPPRESS_SPACE = 0
    $env:_ARGCOMPLETE_IFS = "`n"
    $env:_ARGCOMPLETE_SHELL = 'powershell'

    # Execute the 'az' command and redirect its output to the temporary file
    az 2>&1 | Out-Null

    # Read the completion results from the temporary file, sort them, and create a new CompletionResult object for each result
    Get-Content $completion_file | Sort-Object | ForEach-Object {
        [System.Management.Automation.CompletionResult]::new($_, $_, "ParameterValue", $_)
    }

    # Remove the temporary file and the environment variables
    Remove-Item $completion_file, Env:\_ARGCOMPLETE_STDOUT_FILENAME, Env:\ARGCOMPLETE_USE_TEMPFILES, Env:\COMP_LINE, Env:\COMP_POINT, Env:\_ARGCOMPLETE, Env:\_ARGCOMPLETE_SUPPRESS_SPACE, Env:\_ARGCOMPLETE_IFS, Env:\_ARGCOMPLETE_SHELL
}
# Register an argument completer for the 'az' command using the script block
Register-ArgumentCompleter -Native -CommandName az -ScriptBlock $azArgumentCompleter
# Define a script block
$stopServiceArgumentCompleter = {
    param(
        # The name of the command for which argument completion is being registered
        $commandName, 
        # The name of the parameter for which argument completion is being registered
        $parameterName, 
        # The word being completed
        $wordToComplete, 
        # The command abstract syntax tree (AST)
        $commandAst, 
        # A hashtable that contains the parameter values of the command
        $fakeBoundParameters
    )

    # Get all running services whose names start with the word being completed
    $services = Get-Service | Where-Object {$_.Status -eq "Running" -and $_.Name -like "$wordToComplete*"}

    # For each service, create a new CompletionResult object
    $services | ForEach-Object {
        New-Object -Type System.Management.Automation.CompletionResult -ArgumentList $_.Name,
            $_.Name,
            "ParameterValue",
            $_.Name
    }
}
# Register an argument completer for the 'Stop-Service' command and the 'Name' parameter
Register-ArgumentCompleter -CommandName Stop-Service -ParameterName Name -ScriptBlock $stopServiceArgumentCompleter

## show all menu items
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadlineKeyHandler -Key ctrl+d -Function ViExit

$handlers = [Microsoft.PowerShell.PSConsoleReadLine]::GetKeyHandlers()

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

# Import the Chocolatey Profile that contains the necessary code to enable tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

##Message of the Day
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
    # Optional parameter for specifying the computer name
    [Parameter(Position=0,Mandatory=$false)]
    [ValidateNotNullOrEmpty()]
    [string[]]$ComputerName
    ,
    # Optional parameter for specifying the credential
    [Parameter(Position=1,Mandatory=$false)]
    [PSCredential]
    [System.Management.Automation.CredentialAttribute()]$Credential
  )

  Begin {
    # If no computer name is provided, set RemoteSession to null
    If (-Not $ComputerName) {
        $RemoteSession = $null
    }
    # Define ScriptBlock for data collection
    $ScriptBlock = {
        # Get operating system and logical disk information
        $Operating_System = Get-CimInstance -ClassName Win32_OperatingSystem
        $Logical_Disk = Get-CimInstance -ClassName Win32_LogicalDisk |
        Where-Object -Property DeviceID -eq $Operating_System.SystemDrive

        # Try to get the PowerCLi version
        Try {
            $PCLi = get-module vmware*
            $PCLiVer = ' | PowerCLi ' + [string]$PCLi.Major + '.' + [string]$PCLi.Minor + '.' + [string]$PCLi.Revision + '.' + [string]$PCLi.Build
        } Catch {$PCLiVer = ''}

        # Get the domain name
        If ($DomainName = ([System.Net.NetworkInformation.IPGlobalProperties]::GetIPGlobalProperties()).DomainName) {$DomainName = '.' + $DomainName}
        
        # Return a custom object with the collected data
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
    # If a computer name is provided and it's not the current computer
    If ($ComputerName) {
        If ("$ComputerName" -ne "$env:ComputerName") {
            # Build Hash to be used for passing parameters to New-PSSession commandlet
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
    # Build Hash to be used for passing parameters to Invoke-Command commandlet
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
    # If a remote session was created, remove it
    If ($RemoteSession) {
        Remove-PSSession $RemoteSession
    }
  }
} #End Function Get-MOTD

Clear-Host
get-motd
get-alias | get-random -count 10 | ft @{label='aliases'; expression={$_.displayname}},OutputType,helpuri
$handlers = [Microsoft.PowerShell.PSConsoleReadLine]::GetKeyHandlers()
$handlers |  get-random -count 10 | Format-Table key,function,Description

#set the enumerationlimit to extend long strings.
$formatenumerationlimit = -1
prompt