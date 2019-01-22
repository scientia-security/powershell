## PowerShell Basics
PowerShellの基礎を記載します。

### Get-Help
ヘルプコマンドとして機能。ワイルドカードを使って検索を絞り込むことも可能。

```
コマンドを検索する場合
PS C:\> Get-Help *alias

Name                              Category  Module                    Synopsis
----                              --------  ------                    --------
Export-Alias                      Cmdlet    Microsoft.PowerShell.U... ...
Get-Alias                         Cmdlet    Microsoft.PowerShell.U... ...
Import-Alias                      Cmdlet    Microsoft.PowerShell.U... ...
New-Alias                         Cmdlet    Microsoft.PowerShell.U... ...
Set-Alias                         Cmdlet    Microsoft.PowerShell.U... ...

Get-Processの詳細
PS C:\> Get-Help Get-Process

Get-Processの機能詳細（利用可能なパラメータなどについても記載されている）
PS C:\> Get-Help Get-Process -Full

Get-Processのパラメータのみ出力する。
PS C:\> Get-Help Get-Process -Parameter *

Get-Processの利用例（検証環境で機能せず）
PS C:\> Get-Help Get-Process -Examples

```
### Get-Command
利用できるコマンド群を一覧で取得できる。

```
PS C:\> Get-Command | more

CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
（中略）
Cmdlet          Invoke-History                                     3.0.0.0    Microsoft.PowerShell.Core
Cmdlet          Invoke-Item                                        3.1.0.0    Microsoft.PowerShell.Management
Cmdlet          Invoke-RestMethod                                  3.1.0.0    Microsoft.PowerShell.Utility
Cmdlet          Invoke-TroubleshootingPack                         1.0.0.0    TroubleshootingPack
Cmdlet          Invoke-WebRequest                                  3.1.0.0    Microsoft.PowerShell.Utility
Cmdlet          Invoke-WmiMethod                                   3.1.0.0    Microsoft.PowerShell.Management
Cmdlet          Invoke-WSManAction                                 3.0.0.0    Microsoft.WSMan.Management
（中略）
```

```
サービスに関連するcmdlet一覧を出力する
PS C:\> Get-Command -CommandType cmdlet -Name *service*

CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
Cmdlet          Get-Service                                        3.1.0.0    Microsoft.PowerShell.Management
Cmdlet          New-Service                                        3.1.0.0    Microsoft.PowerShell.Management
Cmdlet          New-WebServiceProxy                                3.1.0.0    Microsoft.PowerShell.Management
Cmdlet          Restart-Service                                    3.1.0.0    Microsoft.PowerShell.Management
Cmdlet          Resume-Service                                     3.1.0.0    Microsoft.PowerShell.Management
Cmdlet          Set-Service                                        3.1.0.0    Microsoft.PowerShell.Management
Cmdlet          Start-Service                                      3.1.0.0    Microsoft.PowerShell.Management
Cmdlet          Stop-Service                                       3.1.0.0    Microsoft.PowerShell.Management
Cmdlet          Suspend-Service                                    3.1.0.0    Microsoft.PowerShell.Management
```

```
Stop系コマンド
PS C:\> Get-Command -Verb stop

CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
Function        Stop-DscConfiguration                              1.1        PSDesiredStateConfiguration
Function        Stop-Dtc                                           1.0.0.0    MsDtc
Function        Stop-DtcTransactionsTraceSession                   1.0.0.0    MsDtc
（略）
Cmdlet          Stop-AppvClientConnectionGroup                     1.0.0.0    AppvClient
Cmdlet          Stop-AppvClientPackage                             1.0.0.0    AppvClient
Cmdlet          Stop-Computer                                      3.1.0.0    Microsoft.PowerShell.Management
Cmdlet          Stop-DtcDiagnosticResourceManager                  1.0.0.0    MsDtc
Cmdlet          Stop-Job                                           3.0.0.0    Microsoft.PowerShell.Core
Cmdlet          Stop-Process                                       3.1.0.0    Microsoft.PowerShell.Management
Cmdlet          Stop-Service                                       3.1.0.0    Microsoft.PowerShell.Management
Cmdlet          Stop-Transcript                                    3.0.0.0    Microsoft.PowerShell.Host
```
### Get-Alias
PowerShellでは、lsやpsなど、Linuxのコマンドが使うことができる。これらのコマンドが使える理由はAliasへ登録されているためである。
Get-Aliasはその設定を出力するコマンド。
```
PS C:\> Get-Alias

CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
（略）
Alias           ls -> Get-ChildItem
Alias           man -> help
Alias           md -> mkdir
（略）
```
### Get-Process & Stop-Process
```
PS C:\> Start-Process notepad.exe
PS C:\> Get-Process -Name notepad

Handles  NPM(K)    PM(K)      WS(K)     CPU(s)     Id  SI ProcessName
-------  ------    -----      -----     ------     --  -- -----------
    264      18     4540      18504       0.16  16624   2 notepad


PS C:\> Stop-Process -Id 16624
```
```
PS C:\> Start-Process notepad.exe
PS C:\> Get-Process -Name notepad

Handles  NPM(K)    PM(K)      WS(K)     CPU(s)     Id  SI ProcessName
-------  ------    -----      -----     ------     --  -- -----------
    264      18     4532      18456       0.20   1660   2 notepad


PS C:\> Stop-Process -Name notepad
```

### 良く使いそうなcmdlet
```
PS C:\> Get-Command -CommandType cmdlet -Name *service*

CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
Cmdlet          Get-Service                                        3.1.0.0    Microsoft.PowerShell.Management
Cmdlet          New-Service                                        3.1.0.0    Microsoft.PowerShell.Management
Cmdlet          New-WebServiceProxy                                3.1.0.0    Microsoft.PowerShell.Management
Cmdlet          Restart-Service                                    3.1.0.0    Microsoft.PowerShell.Management
Cmdlet          Resume-Service                                     3.1.0.0    Microsoft.PowerShell.Management
Cmdlet          Set-Service                                        3.1.0.0    Microsoft.PowerShell.Management
Cmdlet          Start-Service                                      3.1.0.0    Microsoft.PowerShell.Management
Cmdlet          Stop-Service                                       3.1.0.0    Microsoft.PowerShell.Management
Cmdlet          Suspend-Service                                    3.1.0.0    Microsoft.PowerShell.Management

PS C:\> Get-Command -CommandType cmdlet -Name *service* | Measure-Object

Count    : 9
```
```
PS C:\> Get-HotFix
HotFixの一覧を出すコマンド（アウトプットはダミーとして出力）
Source        Description      HotFixID      InstalledBy          InstalledOn
------        -----------      --------      -----------          -----------
（中略）
*********     Update           KB1111111     NT AUTHORITY\SYSTEM  2019/01/11 0:00:00
*********     Update           KB2222222     NT AUTHORITY\SYSTEM  2019/01/11 0:00:00
*********     Security Update  KB3333333     NT AUTHORITY\SYSTEM  2019/01/11 0:00:00
*********     Security Update  KB4444444     NT AUTHORITY\SYSTEM  2019/01/11 0:00:00
（中略）
```

