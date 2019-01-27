# PowerShell Basics
PowerShellの基礎を記載します。

## 演算子
- 計算 (+, -, *, /, %)
- 代入 (=, +=, -=, *=, /=, %=)
- 比較 (-eq, -ne, -gt, -lt, -le, -ge, -match, -notmatch, -replace, -like, -notlike, -in, -notin, -contains, -notcontains)
- リダイレクト(>, >>, 2>, 2>, and 2>&1)
- 論理演算 (-and, -or, -xor, -not, !)
- 分割•結合 (-split, -join)
- 型 (-is, -isnot, -as)

```
◆論理演算
PS C:\> (1 -lt 3) -and (1 -gt 0)
True
PS C:\> (1 -lt 0) -and (1 -gt 0)
False
PS C:\>

◆分割
PS C:\> "Welcome to Powershell Programming" -split " "
Welcome
to
Powershell
Programming
PS C:\> "Welcome to Powershell Programming" -split "t"
Welcome
o Powershell Programming
PS C:\> "Welcome to Powershell Programming" -split " ",2
Welcome
to Powershell Programming

◆結合
PS C:\> "Wel", "Please" -join "come "
Welcome Please
PS C:\>
```
## 型・配列

```
◆型は基本的に最初が優先される。
PS C:\> $value = "string" + 1
PS C:\> $value.GetType()
IsPublic IsSerial Name                                     BaseType
-------- -------- ----                                     --------
True     True     String                                   System.Object

◆シングルクォート・ダブルクォートの違い
PS C:\> $str = "test"
PS C:\> "Welcome, $str"
Welcome, test
PS C:\> 'Welcome, $str'
Welcome, $str

◆型変換
PS C:\> $a = 2.3 + 3
PS C:\> $a
5.3
PS C:\> $a.GetType()

IsPublic IsSerial Name                                     BaseType
-------- -------- ----                                     --------
True     True     Double                                   System.ValueType

PS C:\> [int]$a
5

◆配列（配列）
PS C:\> $array = 1,2,3
PS C:\> $array
1
2
3
PS C:\> $array.length
3
PS C:\> $array[1]
2
PS C:\> $emptyArray = @()　// 空の配列を作成する。

◆オブジェクト
PS C:\> $result = Get-ChildItem
PS C:\> $result.GetType()

IsPublic IsSerial Name                                     BaseType
-------- -------- ----                                     --------
True     True     Object[]                                 System.Array
```


## 出力形式

### Format系出力
Format-* を使うことで結果の出力形式を操作することができる。
```
PS C:\> Get-Command -CommandType cmdlet -Name Format*
CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
Cmdlet          Format-Custom                                      3.1.0.0    Microsoft.PowerShell.Utility
Cmdlet          Format-List                                        3.1.0.0    Microsoft.PowerShell.Utility
Cmdlet          Format-SecureBootUEFI                              2.0.0.0    SecureBoot
Cmdlet          Format-Table                                       3.1.0.0    Microsoft.PowerShell.Utility
Cmdlet          Format-Wide                                        3.1.0.0    Microsoft.PowerShell.Utility

PS C:\> Get-ChildItem | Format-Table

Mode                LastWriteTime         Length Name
----                -------------         ------ ----
d-----       2017/12/21      7:32                cygwin
(中略)


PS C:\> Get-ChildItem | Format-Table *
*をつけると、より詳細なテーブル情報（持っている情報を全て出力）が出力される。
```

### Out-系出力
コチラも出力を行うcmdlet。
```
PS C:\> Get-Command -CommandType cmdlet -Name Out*

CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
Cmdlet          Out-Default                                        3.0.0.0    Microsoft.PowerShell.Core
Cmdlet          Out-File                                           3.1.0.0    Microsoft.PowerShell.Utility
Cmdlet          Out-GridView                                       3.1.0.0    Microsoft.PowerShell.Utility
Cmdlet          Out-Host                                           3.0.0.0    Microsoft.PowerShell.Core
Cmdlet          Out-Null                                           3.0.0.0    Microsoft.PowerShell.Core
Cmdlet          Out-Printer                                        3.1.0.0    Microsoft.PowerShell.Utility
Cmdlet          Out-String                                         3.1.0.0    Microsoft.PowerShell.Utility

PS C:\> Get-Process | Out-GridView
自動的に、GridViewを使って表示してくれる。

PS C:\> Get-Process | Out-File -FilePath C:\WORKSPACE\process.txt
PS C:\> Get-Content C:\WORKSPACE\process.txt | more

Handles  NPM(K)    PM(K)      WS(K)     CPU(s)     Id  SI ProcessName
-------  ------    -----      -----     ------     --  -- -----------
    299      16     3384       2700       0.56   2416   1 AdobeCollabSync
    487      24     7084       5356      19.81  20376   1 AdobeCollabSync
    288      24     5816       5984              4484   0 AppleMobileDeviceService

```

## 良く使うコマンド
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
（中略）

サービスに関連するcmdlet一覧を出力する
PS C:\> Get-Command -CommandType cmdlet -Name *service*

CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
Cmdlet          Get-Service                                        3.1.0.0    Microsoft.PowerShell.Management
Cmdlet          New-Service                                        3.1.0.0    Microsoft.PowerShell.Management
Cmdlet          New-WebServiceProxy                                3.1.0.0    Microsoft.PowerShell.Management
Cmdlet          Restart-Service                                    3.1.0.0    Microsoft.PowerShell.Management
(中略)

Stop系コマンドの一覧を取得する
PS C:\> Get-Command -Verb stop

CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
Function        Stop-DscConfiguration                              1.1        PSDesiredStateConfiguration
Function        Stop-Dtc                                           1.0.0.0    MsDtc
（略）
Cmdlet          Stop-Process                                       3.1.0.0    Microsoft.PowerShell.Management
Cmdlet          Stop-Service                                       3.1.0.0    Microsoft.PowerShell.Management
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

### Measure-Object
Objectの数を算出する。
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

### Get-HotFix
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
