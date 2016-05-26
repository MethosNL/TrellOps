function New-Token {
    <# 
      .Synopsis 
       Logs into Trello and returns a token that may be used to make calls. 
      .Description 
       Logs into Trello and returns a token that may be used to make calls. Use with other commands to work with private boards 
      .Parameter BoardId 
       The id of the board 
      .Example 
       # Get all cards on a private board 
       $auth = New-TrelloToken -Key abc -AppName "My App" 
       Get-TrelloCardsInBoard -BoardId fDsPBXFt -Token $auth 
    #>
    [cmdletbinding()]
    param(
        [Parameter(
            Mandatory=$true,
            Position=0
        )]
        $Key,
        [Parameter(
            Mandatory=$true,
            Position=1
        )]
        $AppName,
        [Parameter(
            Mandatory=$false,
            Position=2
        )]
        $Expiration="30days",
        [Parameter(
            Mandatory=$false,
            Position=3
        )]
        [ValidateSet("read","read,write")]
        $Scope="read"
    )
    begin
    {
        function Get-oAuth2AccessToken { 
            <# 
                .Synopsis 
                Retrieves an oAuth 2.0 access token from the specified base authorization 
                URL, client application ID, and callback URL. 
  
                .Parameter AuthUrl 
                The base authorization URL defined by the service provider. 
  
                .Parameter ClientId 
                The client ID (aka. app ID, consumer ID, etc.). 
  
                .Parameter RedirectUri 
                The callback URL configured on your application's registration with the 
                service provider. 
  
                .Parameter SleepInterval 
                The number of seconds to sleep while waiting for the user to authorize the 
                application. 
  
                .Parameter Scope 
                A string array of "scopes" (permissions) that your application will be 
                requesting from the user's account. 
            #> 
            [CmdletBinding()] 
            param ( 
                [Parameter(
                    Mandatory=$true,
                    Position=0
                )]
                [string]$AuthUrl,
                [Parameter(
                    Mandatory=$false,
                    Position=1
                )]
                [int]$SleepInterval = 2 
            )
            begin
            {
                try {
                    # Create the Internet Explorer object
                    $IE = New-Object -ComObject InternetExplorer.Application
                    $IE.Visible = $true
                }
                catch
                {
                    Write-Error $_
                }
            }
            process
            {
                try {
                    # Navigate to the constructed authorization URL 
                    $IE.Navigate($AuthUrl)
 
                    # Sleep the script for $X seconds until callback URL has been reached 
                    # NOTE: If user cancels authorization, this condition will not be satisifed 
                    while ($IE.LocationUrl -notmatch ‘token=’) {
                        Write-Debug -Message (‘Sleeping {0} seconds for access URL’ -f $SleepInterval)
                        Start-Sleep -Seconds $SleepInterval
                    } 
 
                    # Parse the access token from the callback URL and exit Internet Explorer 
                    Write-Debug -Message (‘Callback URL is: {0}’ -f $IE.LocationUrl)
                    [Void]($IE.LocationUrl -match ‘=([\w\.]+)’)
                    $AccessToken = $Matches[1]
  
                    # Write the access token to the pipeline inside of a HashTable (in case we want to return other properties later) 
                    Write-Debug -Message (‘Access token is: {0}’ -f $AccessToken)
                }
                catch
                {
                    Write-Error $_
                }
                Write-Output $AccessToken
            }
            end
            {
                try {
                    $IE.Quit()
                }
                catch
                {
                    Write-Error $_
                }
            }
        }
    }
    process
    {
        $Output = @{}
        try
        {
            [string]$token = Get-oAuth2AccessToken -AuthUrl "https://trello.com/1/authorize?key=$Key&name=$AppName&expiration=$Expiration&scope=$Scope&response_type=token&callback_method=fragment&return_url=https://trello.com?"

            $Output.Add("Token",$token.Replace(' ',''))
            $Output.Add("AccessKey",$Key)
        }
        catch
        {
            Write-Error $_
        }
        Write-Output $Output
    }
    end
    {
    }
}

Export-ModuleMember New-Token