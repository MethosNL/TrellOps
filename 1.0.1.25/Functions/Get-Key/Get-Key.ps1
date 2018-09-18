function Get-Key {
    $IE = New-Object -ComObject InternetExplorer.Application
    $IE.Navigate('https://trello.com/app-key')
    while ($IE.LocationURL -ne 'https://trello.com/app-key') {
        Start-Sleep -Seconds 2
    }
    $InnerHTML = $IE.Document.body.innerHTML
    New-Object -TypeName PSObject -Property @{
        'Key' = . {
            [regex]::Match($InnerHTML,'[0-9a-z]{32}').value
        }
    }
    $IE.Quit()
}