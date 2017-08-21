function Remove-Card {
    <#
      .Synopsis 
       Removes a Trello Card.
      .Description 
      Removes a Trello Card.
    #>
    [cmdletbinding()]
    param (
        [parameter(
            Mandatory=$true,
            Position=0
        )]
        $Token,
        [parameter(
            Mandatory=$true,
            Position=1
        )]
        $Id
    )
    begin
    {
    }
    process
    {
        try
        {
            Invoke-RestMethod -Method "Delete" -Uri "https://api.trello.com/1/cards/$($Id)/?token=$($Token.Token)&key=$($Token.AccessKey)"
        }
        catch
        {
        }
    }
    end
    {
    }
}

Export-ModuleMember Remove-Card