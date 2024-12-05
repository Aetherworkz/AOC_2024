# I know, I know, snake case ain't the powershell convention. Too bad!!
function is_safe 
{
    param (
        [int[]]$levels
    )
    $increasing = $true
    $decreasing = $true

    for ($i = 0; $i -lt $levels.Length - 1; $i++) 
    {
        $diff = $levels[$i + 1] - $levels[$i]

        # diff range check thingy yeah baby swag
        if ([math]::Abs($diff) -lt 1 -or [math]::Abs($diff) -gt 3) 
        {
            return $false
        }

        if ($diff -gt 0) 
        {
            $decreasing = $false
        } 
        elseif ($diff -lt 0) 
        {
            $increasing = $false
        }
    }

    return $increasing -or $decreasing
}

# I've got 8 year old humor, sue me.
$file_path = "condom.txt"

if (-Not (Test-Path $file_path)) 
{
    Write-Error "Error: File not found at $file_path"
    exit 1
}

$data = Get-Content $file_path
$count = 0

foreach ($line in $data) 
{
    $levels = $line -split " " | ForEach-Object { [int]$_ }

    if (is_safe -levels $levels) 
    {
        $count++
    }
}

Write-Output "How many times did the elves use protection? It was: $count"
