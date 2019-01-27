# メニュー読み込み
$menu = ConvertFrom-Csv -Header No, Name, Price  @"
1, Scientia Burger, 300
2, Scientia Double Burger, 400
3, French Fries, 150
4, Soft Drink, 150
5, Beer, 350
6, Smile, 0
"@

$menu | Add-Member  -MemberType NoteProperty -Name "Qt" -Value 0
Write-Output("*** Welcome to Scientia Burgers!!! ***")
Write-Output("--- This is our menu for today ---")

While(1){
    # メニューを表示し、注文を記録する。
    $menu | Format-Table
    $order = Read-Host "Order Please (1 - 6)"
    $menu[$order-1].Qt +=1

    # ハンバーガを注文し、かつフライドポテトが注文されていないとき
    if((($order -eq 1) -or ($order -eq 2)) -and ($menu[2].Qt -eq 0)){
        Write-Output("Would you like our delicious French Fries?")
        Write-Output("1: Yes, I Love it!!")
        Write-Output("2: No Thank You")

        $order_FF = Read-Host "Your Answer:"
        if ($order_FF -eq 1){
            $menu[2].Qt += 1
        }
    }  
    
    # 繰り返しの処理
    Write-Output("Do you continue to order!")
    Write-Output("1: Yes!!")
    Write-Output("2: No Thank You!! Please have check.")
    $endFlag = Read-Host "Your Answer:"
    
    if($endFlag -eq 2){
        break
    }
}

## 計算
$total = 0
foreach($line in $menu){
    $total += [int]$line.Price * [int]$line.Qt
}

Write-Output("Your order is ...")
$menu | Format-Table
Write-Output("Your Total is $total")

$paymentFF = 0
for($cnt=0; $cnt -lt 3; $cnt ++){
    $cc = Read-Host "Please input your Credit Number"
    $ccArray = $cc -split ""
    
    if(($ccArray.length)-2 -ne 16) {
        Write-Output("Your Credit Card Number is Error. Please Try Again!!")
    }
    else{
        $sum = 0
        for($i=16; $i -gt 0; $i--){
            $value = 0
            $oddEven = $i%2
            if($oddEven -eq 0){
                $value = [int]$ccArray[$i]
            }
            else{
                $value = [int]$ccArray[$i] * 2
                if($value -gt 9){
                    $value = $value - 9
                }
            }
            $sum = $sum + $value
        }
        if($sum%10 -eq 0){
            Write-Output("This Card Number is valid...")
            $paymentFF = 1
            break
        }
        else{
            Write-Output("This Card is invalid ...")
        }
    }
}

if($paymentFF -eq 1){
    Write-Output("Thank you for Your Order")
}
else{
    Write-Output("Your credit card is wrong....Go Away!!")
}
