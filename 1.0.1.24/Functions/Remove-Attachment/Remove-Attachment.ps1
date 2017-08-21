function Remove-Attachment {
    <#
      .Synopsis 
       Removes a Trello Checklist Attachment.
      .Description 
       Removes a Trello Checklist Attachment.
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
        [string]$Id,
        [parameter(
            Mandatory=$true,
            Position=2
        )]
        [string]$CardId
    )
    begin
    {
    }
    process
    {
        try
        {
            Invoke-RestMethod -Method "Delete" -Uri "https://api.trello.com/1/cards/$CardId/attachments/$Id/?token=$($Token.Token)&key=$($Token.AccessKey)"
        }
        catch
        {
        }
    }
    end
    {
    }
}

Export-ModuleMember Remove-Attachment