# Hey this function looks familiar....
function is_safe($levels) {
    $increasing = $true
    $decreasing = $true

    for ($i = 1; $i -lt $levels.Count; $i++)
    {
        $diff = $levels[$i] - $levels[$i - 1]

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

    return $increasing -or $decreasing # Must be either strictly increasing or decreasing
}

# Are we safe after removing one level? Let's find out.
function safe_with_dampener($levels)
{
    # Already safe w/o modification n such.
    if (is_safe $levels)
    {
        return $true
    }

    # Convert to ArrayList for mutability
    $modified = [System.Collections.ArrayList]@($levels)

    for ($i = 0; $i -lt $levels.Count; $i++)
    {
        # Remove one level
        $modified.RemoveAt($i)

        # Are we safe after the level is beaned?
        if (is_safe $modified)
        {
            return $true
        }

        # Restore ye ol' list
        $modified.Insert($i, $levels[$i])
    }

    # not safe, even w/ dampener. Sad!
    return $false
}

$filename = "condom.txt"
$safeCount = 0

if (-Not (Test-Path $filename))
{
    Write-Host "Error: Could not open file $filename"
    exit 1
}

Get-Content $filename | ForEach-Object { # mf did NOT like the bracket being on a new line.
    $line = $_
    $levels = $line -split '\s+' | ForEach-Object { [int]$_ }

    if (safe_with_dampener $levels)
    {
        $safeCount++
    }
}

Write-Host "We got: $safeCount"
