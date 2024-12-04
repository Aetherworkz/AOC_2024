# This may be slow, but as a wise man once said: "If it works, it works".
$filePath = "C:\Users\japan\Desktop\AOC\D1\numbers.txt"

$content = Get-Content $filePath
$left_list = @()
$right_list = @()

foreach ($line in $content)
{
    $columns = $line -split '\s+'
    $left_list += [int]$columns[0]
    $right_list += [int]$columns[1]
}

$similarity = 0

foreach ($left_nut in $left_list)
{
    $right_count = ($right_list | Where-Object {$_ -eq $left_nut}).Count
    $similarity += $left_nut * $right_count
}

Write-Output "The similarity score is: $similarity"