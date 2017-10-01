$check = $true

# This function will check the input is prime number
function checkPrime{

    param($num)

    if(($num -le 1) -or ($num % 2 -eq 0 -and $num -gt 2)){

        Write-Host "`nThe number you just enter isn't prime number" -ForegroundColor Red
        $global:check = $false
        exit
    }

    for($i = 3; $i -lt $num/2; $i+=2){
        if($num % $i -eq 0){
            Write-Host "`nThe number you just enter isn't prime number" -ForegroundColor Red
            $global:check = $false
            exit       
        }
    }

}

# This function will check the input is empty
function checkEmpty{
    param($num)

    if($num -eq ""){
        Write-Host "`nInput can't be empty, Please enter a prime number" -ForegroundColor Red
        $global:check = $false
        exit
    }
}

[Int]$pA = Read-Host "`nEnter the prime A"
checkEmpty -num $pA
checkPrime -num $pA
[Int]$pB = Read-Host "`nEnter the prime B"
checkEmpty -num $pB
checkPrime -num $pB

# If the inputs have passed all the checks,it will execute it in main
function main{
    $n = $pA*$pB
    $m = ($pA-1)*($pB-1)

    # Find $e with the GCD($m,$e)=1
    function Get-GCD {
        [CmdletBinding()]
            Param (
                [Int32] $a,
                [Int32] $b
            )
        while ($a -ne $b) {
            if ($a -gt $b) {
                $a = $a - $b
            }
            else {
                $b = $b - $a
            }
        }
        return $a;   
    }

    for($e = 2; $e -lt $m;$e++){
        $x = Get-GCD -a $m -b $e
        if($x -eq 1){
            break
        } 
    }

    # ask for message here
    [int]$mess = Read-Host "`nEnter the message"

    $cipher = [math]::Pow($mess,$e)%$n

    function findD{

        param($m, $e)
        $d = 0
        for($k=1;$k -lt 999999;$k++){
        
            #$getd = (1+$k*$m)%$e
            $getd = ($k*$e)%$m
            if($getd -eq 1){
                $d = $k        
                break 
            }
        }
        return (1+$d*$m)/$e
    }

    $d = $(findD -m $m -e $e)
    $decryp = [math]::pow($cipher,$d)%$n

    $re = [pscustomobject]@{
     EncrytionKey= $e,$n;
     TheMessage=$mess;
     TheCipher=$cipher;
     DecryptionKey= $d,$n;
     Decrypted= $decryp
    }
    $re|fl

}

if($check -eq $true){
    main
}
else{
    exit
}
