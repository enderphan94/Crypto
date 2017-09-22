[int]$p = Read-Host "`nEnter the prime number"
[int]$b = Read-Host "Enter the base number"

[int]$as = Read-Host "Enter the secret a"
[int]$bs = Read-Host "Enter the secret b"

$mess_a = [math]::Pow($b,$as)%$p
$mess_b = [math]::Pow($b,$bs)%$p

$key_a = [math]::Pow($mess_b,$as)%$p
$key_b = [math]::Pow($mess_a,$bs)%$p

Write-host "`nMessage a is: $mess_a" -ForegroundColor Green
Write-host "Message b is: $mess_b" -ForegroundColor Green

Write-host "`nKey a is: $key_a" -ForegroundColor red
Write-host "Key b is: $key_b" -ForegroundColor red

