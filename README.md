# Pete's first Posh repo
#### This project is my first PowerShell repo clone.

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

-----

# My github stats:
[![GitHub Streak](https://streak-stats.demolab.com/?user=bigpete-za)](https://git.io/streak-stats)

---

[![Professional Profile](https://github-readme-stats.vercel.app/api/pin/?username=petersoule-viadex&repo=posh-prof&theme=chartreuse-dark)](https://github.com/petersoule-viadex/posh-prof)
[![Personal Profile](https://github-readme-stats.vercel.app/api/pin/?username=bigpete-za&repo=posh-prof&theme=chartreuse-dark)](https://github.com/bigpete-za/posh-prof)
[![Pete's github stats](https://github-readme-stats.vercel.app/api?username=petersoule-viadex&show_icons=true&count_private=true&theme=chartreuse-dark)](https://github.com/petersoule-viadex)

---

## Commit History

| Commit ID | Author | Date | Message |
|-----------|--------|------|---------|
| d12de32   | [Peter Soule](mailto:Peter.Soule@viadex.com) | 2024-03-03 13:52:22 +0200 | Cleanup |
|31d63a6 |[Peter Soule](mailto:Peter.Soule@viadex.com) |2024-03-03 13:37:04 +0200 | Updated handlers and alias prompt
|b2ffc57 |[Peter Soule](mailto:Peter.Soule@viadex.com) |2024-03-03 12:17:08 +0200 | Added Commit History
| 98d25fb   | [Peter Soule](mailto:Peter.Soule@viadex.com) | 2024-03-03 12:03:42 +0200 | Updated |
| 989d163   | [Peter Soule](mailto:Peter.Soule@viadex.com) | 2024-03-03 11:58:28 +0200 | Updated |
| 37d933b   | [Peter Soule](mailto:Peter.Soule@viadex.com) | 2024-03-03 11:55:03 +0200 | Updated |
| 7d09225   | [Peter Soule](mailto:Peter.Soule@viadex.com) | 2024-03-03 11:48:38 +0200 | Updated registered autocompleters |
| 8d73712   | [Peter Soule](mailto:Peter.Soule@viadex.com) | 2024-03-03 11:37:21 +0200 | Updated registered autocompleters |
| 2e2e541   | [Peter Soule](mailto:Peter.Soule@viadex.com) | 2024-03-03 11:31:30 +0200 | Added function to autocomplete services |
| a0c4abe   | [Peter Soule](mailto:Peter.Soule@viadex.com) | 2024-03-03 11:10:14 +0200 | Added code omitted by Copilot |
| fc2b2f1   | [Peter Soule](mailto:Peter.Soule@viadex.com) | 2024-03-03 11:07:56 +0200 | updated Release history |
| a354bc7   | [Peter Soule](mailto:Peter.Soule@viadex.com) | 2024-03-03 11:03:50 +0200 | Removed Commit_history.md |
| 5511799   | [Peter Soule](mailto:Peter.Soule@viadex.com) | 2024-03-03 11:03:07 +0200 | Merged Commit_history.md with Readme.md |
| f1cc457   | [Peter Soule](mailto:Peter.Soule@viadex.com) | 2024-03-03 10:58:44 +0200 | Added commit_history.md |
| 8a6af43   | [Peter Soule](mailto:Peter.Soule@viadex.com) | 2024-03-03 10:55:48 +0200 | Added code omitted by Copilot |
| 9824e13   | [Peter Soule](mailto:Peter.Soule@viadex.com) | 2024-03-03 10:49:11 +0200 | Refactor code to improve performance and readability |
| b997ea3   | [Peter Soule](mailto:Peter.Soule@viadex.com) | 2024-03-03 10:36:49 +0200 | updated formatting |
| b108054   | [Peter Soule](mailto:Peter.Soule@viadex.com) | 2024-03-03 10:35:22 +0200 | updated wheel of lunch |
| 797505d   | [Peter Soule](mailto:Peter.Soule@viadex.com) | 2024-03-03 10:29:54 +0200 | updated readme |
| d1d35c3   | [Peter Soule](mailto:Peter.Soule@viadex.com) | 2024-03-03 10:14:42 +0200 | Added ReadME |
| 8648977   | [Peter Soule](mailto:Peter.Soule@viadex.com) | 2024-03-03 10:10:37 +0200 | Initial init on Main |
