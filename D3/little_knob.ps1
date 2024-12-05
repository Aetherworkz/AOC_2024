# I got made fun of for the snake case.
$filePath = "regex_boner.txt"

$corruptedMemory = Get-Content -Path $filePath -Raw

$regex = 'mul\((\d+),(\d+)\)'
$sum = 0

$matches = [regex]::Matches($corruptedMemory, $regex)

foreach ($match in $matches)
{
    $x = [int]$match.Groups[1].Value
    $y = [int]$match.Groups[2].Value
    $sum += $x * $y
}

Write-Output "I couldn't think of a creative comment so uhhhhhhh: $sum"
