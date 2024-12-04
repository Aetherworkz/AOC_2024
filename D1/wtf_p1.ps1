# Yeah.
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

$sorted_left = $left_list | Sort-Object
$sorted_right = $right_list | Sort-Object

$total_distance = 0

for ($i = 0; $i -lt $sorted_left.Count; $i++)
{
    $distance = [math]::Abs($sorted_left[$i] - $sorted_right[$i])
    $total_distance += $distance
}

Write-Output "Our grand distance be: $total_distance"
