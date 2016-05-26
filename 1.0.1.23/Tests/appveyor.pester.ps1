param([switch]$Finalize)

$PSVersion = $PSVersionTable.PSVersion.Major
$TestFile = "TestResults_PS$PSVersion.xml"
$ProjectRoot = $ENV:APPVEYOR_BUILD_FOLDER
Set-Location $ProjectRoot
#Run a test with the native version of PowerShell
if(-not $Finalize)
{
    "`tSTATUS: Testing with PowerShell $PSVersion"
    Import-Module Pester
    Invoke-Pester -Path "$ProjectRoot\Tests" -OutputFormat NUnitXml -OutputFile "$ProjectRoot\$TestFile" -PassThru | Export-Clixml -Path "$ProjectRoot\PesterResults_PS$PSVersion.xml"
} else {
    #Show status...
    $AllFiles = Get-ChildItem -Path $ProjectRoot\*Results*.xml | Select-Object -ExpandProperty FullName
    "`tSTATUS: Finalizing results"
    "COLLATING FILES:`n$($AllFiles | Out-String)"
    #Upload results for test page
    Get-ChildItem -Path "$ProjectRoot\TestResults_PS*.xml" | Foreach-Object {
        $Address = "https://ci.appveyor.com/api/testresults/nunit/$($env:APPVEYOR_JOB_ID)"
        $Source = $_.FullName
        "UPLOADING FILES: $Address $Source"
        (New-Object 'System.Net.WebClient').UploadFile( $Address, $Source )
    }
    #What failed?
    $Results = @( Get-ChildItem -Path "$ProjectRoot\PesterResults_PS*.xml" | Import-Clixml )
    $FailedCount = $Results | Select-Object -ExpandProperty FailedCount | Measure-Object -Sum | Select-Object -ExpandProperty Sum
    if ($FailedCount -gt 0) {
        $FailedItems = $Results | Select-Object -ExpandProperty TestResult | Where-Object {$_.Passed -notlike $True}
        "FAILED TESTS SUMMARY:`n"
        $FailedItems | ForEach-Object {
            $Test = $_
            [pscustomobject]@{
                Describe = $Test.Describe
                Context = $Test.Context
                Name = "It $($Test.Name)"
                Result = $Test.Result
            }
        } | Sort-Object -Property Describe, Context, Name, Result | Format-List
        throw "$FailedCount tests failed."
    }
}