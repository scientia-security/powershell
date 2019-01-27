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
## 条件分岐
### if ・ elseif ・ else
```
PS C:\> $a = 3
PS C:\> if ($a -gt 0) {"TRUE"} else {"FALSE"}

◆プロセスの数による条件分岐
PS C:\> if  (((Get-Process).Count) -gt 20) {"Too Many"} else {"OK"}
```
### Switch
```
PS C:\> switch (3) { 1 {"One"} 2 {"Two"} default {"default"}}
default

PS C:\> switch -wildcard ('abcab') {a* {"A"} *b* {"B"} c* {"C"}}
A
B

◆ログの絞り込み
PS C:\> switch -Regex -File .\access.log { '/images/'{$_}}

burger.letters.com - - [01/Jul/1995:00:00:12 -0400] "GET /images/NASA-logosmall.gif HTTP/1.0" 304 0
unicomp6.unicomp.net - - [01/Jul/1995:00:00:14 -0400] "GET /images/NASA-logosmall.gif HTTP/1.0" 200 786
unicomp6.unicomp.net - - [01/Jul/1995:00:00:14 -0400] "GET /images/KSC-logosmall.gif HTTP/1.0" 200 1204
d104.aa.net - - [01/Jul/1995:00:00:15 -0400] "GET /images/NASA-logosmall.gif HTTP/1.0" 200 786
d104.aa.net - - [01/Jul/1995:00:00:15 -0400] "GET /images/KSC-logosmall.gif HTTP/1.0" 200 1204
```
## 繰り返し処理
- while() {}
- do {} while()
- do {} until()
- for(;;){}
- foreach ( in ){}
- ForEach-Object
- Where-Object

```
◆while文
PS C:\> $count = 3
PS C:\> while ($count -gt 0){
>> "Iteration $count"
>> $count--
>> }
Iteration 3
Iteration 2
Iteration 1

◆foreach文
PS C:\> foreach ($line in $proc){
>> $line.name
>> }
AcroRd32
AcroRd32
AdobeCollabSync
AdobeCollabSync

◆Foreach-Object
PS C:\> Get-ChildItem | ForEach-Object {$_.Name}
cygwin
...

◆Where-Object
PS C:\> Get-ChildItem C:\WORKSPACE\ | Where-Object {$_.Name -match ".txt"}

Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a----       2019/01/27     14:18         158482 process.txt
-a----       2019/01/27     15:00              0 test.txt
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
## モジュール化
モジュール化する際には以下の通りに記述する。

```
◆コマンドライン引数を受け付ける場合
PS C:\Users> function paramshow{ $args }
PS C:\Users> paramshow "Hi" "PowerShell"
Hi
PowerShell

PS C:\Users> function paramadd { $args[0] + $args[1] }
PS C:\Users> paramadd 2 3
5

◆変数を受け付ける場合
function test ($num1, $num2){ $num1 * $num2 }
test 2 4
test -num2 4 -num1 6

◆想定以上のパラメータを指定しても、$argsパラメータがかっくのうしてくれる
function varparam($a, $b){
    $a
    $b
    $args
    }
varparam "Hi" "Hello" "Power" "Shell"

◆関数の引数には、型指定をしてエラーを発生させることができる。
function addint([int]$a, [int]$b){ $a + $b }
addint 2 3b
→エラーが発生する。

◆引数にデフォルト値を設定しておくことも可能
function test($a = 10, $b){ $a}
test 52
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
