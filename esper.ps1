echo "*** This program checks your ESP power!! ***" 
$target = Get-Random -Minimum 1 -Maximum 100

$count = 1
echo "The Magic Number is given."
$guess = Read-Host "Please input between 1-100"


while ($guess -ne $target){
    if($guess -gt $target){
        $guess = Read-Host "SMALLER than your guess!! TRY AGAIN !!!"
    }
    else{
        $guess = Read-Host "GRATER than your guess!! TRY AGAIN !!!"
    }
    $count++
}

Echo "Magic Number is $target"
if ($count -lt 2){
    echo " You Must be an Esper!!"
}
elseif($count -lt 4){
    echo "you might have ESP power"
}
else{
    echo "You are normal!!"
}




