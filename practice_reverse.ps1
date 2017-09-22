[Int]$pA = Read-Host "`nEnter the prime A"
[Int]$pB = Read-Host "`nEnter the prime B"

$n = $pA*$pB
$m = ($pA-1)*($pB-1)

function caculation{
    param($m)
    $take = 0
    for($i=2;$i -lt $m;$i++){

        if(($m%$i) -ne 0){
            $take =$i
            break
        }
    }
    return $take
}

$e = $(caculation($m))

[int]$mess = Read-Host "`nEnter the message"

$cipher = [math]::Pow($mess,$e)%$n





function findD{

    param($m, $e)
    $d = 0
    for($k=0;$k -lt 999999;$k++){
        
        $getd = (1+$k*$m)%$e
        if($getd -eq 0){
            $d = $k        
            break 
        }
    }
    return (1+$d*$m)/$e
}

$d = $(findD -m $m -e $e)
$decryp = [math]::pow($cipher,$d)%$n + $mess

$re = [pscustomobject]@{
 Publickey= $n,$e;
 Secretkey= $m,$d;
 TheMessage=$mess;
 TheCipher=$cipher;
 Decrypted= $decryp
}
$re|fl