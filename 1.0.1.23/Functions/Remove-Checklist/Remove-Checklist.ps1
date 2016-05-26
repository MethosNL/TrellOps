function Remove-Checklist {
    <#
      .Synopsis 
       Removes a Trello Checklist.
      .Description 
      Removes a Trello Checklist.
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
            Invoke-RestMethod -Method "Delete" -Uri "https://api.trello.com/1/checklists/$($Id)/?token=$($Token.Token)&key=$($Token.AccessKey)"
        }
        catch
        {
        }
    }
    end
    {
    }
}

Export-ModuleMember Remove-Checklist