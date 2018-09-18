function Remove-ChecklistItem {
    <#
      .Synopsis 
       Removes a Trello Checklist Item.
      .Description 
      Removes a Trello Checklist Item.
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
        $Id,
        [parameter(
            Mandatory=$true,
            Position=1
        )]
        $ItemId
    )
    begin
    {
    }
    process
    {
        try
        {
            Invoke-RestMethod -Method "Delete" -Uri "https://api.trello.com/1/checklists/$Id/checkItems/$ItemId/?token=$($Token.Token)&key=$($Token.AccessKey)"
        }
        catch
        {
        }
    }
    end
    {
    }
}

Export-ModuleMember Remove-ChecklistItem