function Remove-Label {
    <#
      .Synopsis 
       Removes a Trello Label.
      .Description 
       Removes a Trello Label.
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
            Invoke-RestMethod -Method "Delete" -Uri "https://api.trello.com/1/labels/$($Id)/?token=$($Token.Token)&key=$($Token.AccessKey)" -Body $Hash
        }
        catch
        {
        }
    }
    end
    {
    }
}

Export-ModuleMember Remove-Label