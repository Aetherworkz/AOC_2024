# I was made fun of for the snake case so here we are.
# Shifted to get the file content this way because it was easier :P
$input = Get-Content -Path "regex_boner.txt" -Raw

$sum = 0
$mulEnabled = $true

# This one's for Sathya
$pattern = 'mul\((\d+),(\d+)\)|do\(\)|don''t\(\)'

$input -split "`n" | ForEach-Object {
    $line = $_
    
    # line match
    $matches = [regex]::Matches($line, $pattern)
    
    foreach ($match in $matches)
    {
        $matchedVal = $match.Value
        
        if ($matchedVal -eq 'do()')
        {
            # Enable multiplication
            $mulEnabled = $true
        }
        elseif ($matchedVal -eq 'don''t()')
        {
            # Disable multiplication
            $mulEnabled = $false
        }
        elseif ($mulEnabled -and $matchedVal -match 'mul\((\d+),(\d+)\)')
        {
            $x = [int]$match.Groups[1].Value
            $y = [int]$match.Groups[2].Value
            $sum += $x * $y
        }
    }
}

Write-Output "Part 2: $sum"
