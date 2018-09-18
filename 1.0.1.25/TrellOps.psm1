$HelpersPath = "$PSScriptRoot\Helpers"
Get-ChildItem $HelpersPath -Directory -Exclude "Tests" | foreach {
    . (join-path $HelpersPath (Join-Path $_.BaseName "$($_.BaseName).ps1"))
}

$FunctionsPath = "$PSScriptRoot\Functions"
Get-ChildItem $FunctionsPath -Directory -Exclude "Tests" | foreach {
    . (join-path $FunctionsPath (Join-Path $_.BaseName "$($_.BaseName).ps1"))
}