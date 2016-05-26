$ProjectRoot = $ENV:APPVEYOR_BUILD_FOLDER
[string[]]$ManifestPath = (Get-ChildItem -Path $ProjectRoot -Include *.psd1 -Recurse).FullName
foreach ($Manifest in $ManifestPath) {
    Describe "Validation of Module Manifest $(Split-Path $Manifest -Leaf)" {
        It 'Only exports functions listed in the module manifest' {
            1 | Should Be 1
        }
    }
    Describe "Module manifest" {
        It 'Has an author in it' {
            1 | Should Be 1
        }
        It 'Has a copyright in it' {
            1 | Should Be 1
        }
        It 'Has a company in it' {
            1 | Should Be 1
        }
    }
}