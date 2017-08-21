function Add-Attachment {
    <#
      .Synopsis 
       Adds an attachment a Trello Card.
      .Description 
       Adds an attachment a Trello Card.
    #>
    [cmdletbinding()]
    param(
        [parameter(
            Mandatory=$true,
            Position=0
        )]
        $Token,
        [parameter(
            Mandatory=$true,
            Position=1
        )]
        [string]$Id,
        [parameter(
            Mandatory=$true,
            Position=2
        )]
        [string]$Name,
        [parameter(
            Mandatory=$true,
            Position=3
        )]
        [string]$URL
    )
    begin
    {
    }
    process
    {
        try
        {
            $Hash = @{
                "name" = $Name
                "url" = $url
            }
            Invoke-RestMethod -Method "Post" -Uri "https://api.trello.com/1/cards/$($Id)/attachments?token=$($Token.Token)&key=$($Token.AccessKey)" -Body $Hash
        }
        catch
        {
            Write-Error $_
        }
    }
    end
    {
    }
}

Export-ModuleMember Add-Attachment