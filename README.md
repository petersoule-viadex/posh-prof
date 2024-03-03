# Pete's first Posh repo
## This project is my first PowerShell repo clone.

# PowerShell Profiles

This repository contains two PowerShell profile scripts:

1. [`Microsoft.PowerShell_profile.ps1`](command:_github.copilot.openRelativePath?%5B%22Microsoft.PowerShell_profile.ps1%22%5D "Microsoft.PowerShell_profile.ps1")
2. [`CloudPWSH_profile.ps1`](command:_github.copilot.openRelativePath?%5B%22CloudPWSH_profile.ps1%22%5D "CloudPWSH_profile.ps1")

## Microsoft.PowerShell_profile.ps1

This PowerShell profile script is designed for a local environment. It includes a variety of functions and aliases to streamline your PowerShell experience. It also includes a system information display that shows at the start of each session.

Key features include:

- System information display (uptime, CPU info, process count, current load, memory size, disk size)
- Aliases for common commands (e.g., `pcx`, `ssh`, `sid`, `pop`, `push`, `gs`, `which`, `npp`)
- Function `connect-365` for connecting to Microsoft 365 services
- Function `resolve-sid` for resolving a security identifier (SID) to a user name
- Function `prof` for opening the current profile script in Notepad++

## CloudPWSH_profile.ps1

This PowerShell profile script is designed for a cloud environment. It includes similar functions and aliases to the local environment script, with some additions for cloud-specific tasks.

Key features include:

- Aliases for common commands (e.g., `pcx`, `ssh`, `sid`, `pop`, `push`, `gs`, `which`, `npp`)
- Function `connect-365` for connecting to Microsoft 365 services, with additional module imports for Azure AD, Exchange Online Management, Microsoft Teams, and MSOnline
- Function `resolve-sid` for resolving a security identifier (SID) to a user name
- Function `prof` for opening the current profile script in Notepad++
- Function `get-syntax` for getting the syntax of a specified cmdlet

## Usage

To use these profile scripts, place them in your PowerShell profile directory. The exact location will depend on your system configuration. You can find the location of your profile directory by running `$PROFILE` in a PowerShell session.

Once the scripts are in place, they will be loaded automatically when you start a new PowerShell session.