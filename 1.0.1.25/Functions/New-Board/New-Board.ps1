function New-Board {
    <#
      .Synopsis 
       Adds a new Trello Board.
      .Description 
       Adds a new Trello Board.
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
        [string]$Description,
        [parameter(
            Mandatory=$true,
            Position=2
        )]
        [string]$Name,
        [parameter(
            Mandatory=$false,
            Position=3
        )]
        [ValidateSet("calendar","cardAging","recap","voting")]
        [string[]]$PowerUps = "All",
        [parameter(
            Mandatory=$false,
            Position=4
        )]
        [ValidateSet("org","private","public")]
        [string]$PermissionLevel,
        [parameter(
            Mandatory=$false,
            Position=5
        )]
        [ValidateSet("disabled","members","observers","org","public")]
        [string]$Voting,
        [parameter(
            Mandatory=$false,
            Position=6
        )]
        [ValidateSet("disabled","members","observers","org","public")]
        [string]$Comments,
        [parameter(
            Mandatory=$false,
            Position=7
        )]
        [ValidateSet("admins","members")]
        [string]$Invitations,
        [parameter(
            Mandatory=$false,
            Position=8
        )]
        [ValidateSet("true","false")]
        [string]$SelfJoin
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
                "desc" = $Description
            }
            switch ($PSBoundParameters.Keys)
            {
                {$_ -contains "PermissionLevel"} {
                    $Hash.Add("prefs_permissionLevel",$PermissionLevel)
                }
                {$_ -contains "Voting"} {
                    $Hash.Add("prefs_voting",$Voting)
                }
                {$_ -contains "PowerUps"} {
                    $PowerUps = $PowerUps -join ","
                }
                {$_ -contains "Comments"} {
                    $Hash.Add("prefs_comments",$Comments)
                }
                {$_ -contains "Invitations"} {
                    $Hash.Add("prefs_invitations",$Invitations)
                }
                {$_ -contains "SelfJoin"} {
                    $Hash.Add("prefs_selfJoin",$SelfJoin)
                }
            }
            $Hash.Add("powerUps",$PowerUps)
            Invoke-RestMethod -Method "Post" -Uri "https://api.trello.com/1/boards?token=$($Token.Token)&key=$($Token.AccessKey)" -Body $Hash
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

Export-ModuleMember New-Board