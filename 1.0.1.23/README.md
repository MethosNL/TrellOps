[![Build status](https://ci.appveyor.com/api/projects/status/gy0t1yxqwalbdwpb?svg=true)](https://ci.appveyor.com/project/MethosIT/trellops)
##
# **TrellOps**
## This Windows PowerShell is for the management of Trello through.
##
## Help and examples for this module will be uploaded on the 28th of May 2016.
##
##
## Written by: Jeff Wouters
##
##
##
##
##
##
# Example
##
## Get your secret and key from here: https://trello.com/app-key

$Secret = "YourSecret"
$Key = "YourKey"

$AuthRead = New-TrelloToken -Key $Key -AppName "TrellOpsRead" -Expiration "never" -Scope 'read'
$AuthWrite = New-TrelloToken -Key $Key -AppName "TrellOpsWrite" -Expiration "never" -Scope 'read,write'

Get-TrelloBoard -Token $AuthRead -All

## Set up a demo board
#endregion Initial setup
#Board
$TrelloBoard = New-TrelloBoard -Token $AuthWrite -Name "MethosIT - Demo" -Description "This is demo board of Methos IT"

#Lists
$TrelloBoardList_UnprioritisedBacklog = New-TrelloList -Token $AuthWrite -Id $TrelloBoard.id -Name "Un-prioritised Backlog" -Position "bottom"
$TrelloBoardList_Backlog = New-TrelloList -Token $AuthWrite -Id $TrelloBoard.id -Name "Backlog" -Position "bottom"
$TrelloBoardList_Sprint = New-TrelloList -Token $AuthWrite -Id $TrelloBoard.id -Name "Sprint" -Position "bottom"
$TrelloBoardList_WIP = New-TrelloList -Token $AuthWrite -Id $TrelloBoard.id -Name "WIP (Work in Progress)" -Position "bottom"
$TrelloBoardList_Done = New-TrelloList -Token $AuthWrite -Id $TrelloBoard.id -Name "Done" -Position "bottom"
$TrelloBoardList_Impediments = New-TrelloList -Token $AuthWrite -Id $TrelloBoard.id -Name "Impediments" -Position "bottom"

#Labels
$TrelloBoardLabel_Daily = New-TrelloLabel -Token $AuthWrite -Id $Trelloboard.id -Name "Daily" -Color "red"
$TrelloBoardLabel_Weekly = New-TrelloLabel -Token $AuthWrite -Id $Trelloboard.id -Name "Weekly" -Color "blue"
$TrelloBoardLabel_Monthly = New-TrelloLabel -Token $AuthWrite -Id $Trelloboard.id -Name "Monthly" -Color "black"

#Cards
$NewTrelloCard = New-TrelloCard -Token $AuthWrite -Id $TrelloBoardList_Backlog.id -Name "TestCard" -Description "Just some description" -Label $TrelloBoardLabel_Daily.id -Position "bottom"
$NewTrelloCard2 = New-TrelloCard -Token $AuthWrite -Id $TrelloBoardList_Backlog.id -Name "TestCard2" -Description "Just some description" -Label $TrelloBoardLabel_Weekly.id -Position "bottom"
$NewTrelloCard3 = New-TrelloCard -Token $AuthWrite -Id $TrelloBoardList_Backlog.id -Name "TestCard3" -Description "Just some description" -Label $TrelloBoardLabel_Weekly.id -Position "bottom"
$NewTrelloCard4 = New-TrelloCard -Token $AuthWrite -Id $TrelloBoardList_Backlog.id -Name "TestCard4" -Description "Just some description" -Label $TrelloBoardLabel_Monthly.id -Position "bottom"
$NewTrelloCard5 = New-TrelloCard -Token $AuthWrite -Id $TrelloBoardList_Backlog.id -Name "TestCard5" -Description "Just some description" -Label $TrelloBoardLabel_Monthly.id -Position "bottom"
$NewTrelloCard6 = New-TrelloCard -Token $AuthWrite -Id $TrelloBoardList_Backlog.id -Name "TestCard6" -Description "Just some description" -Label $TrelloBoardLabel_Monthly.id -Position "bottom"
$NewTrelloCard7 = New-TrelloCard -Token $AuthWrite -Id $TrelloBoardList_Backlog.id -Name "TestCard7" -Description "Just some description" -Position "bottom"

#Card - CheckList
$TrelloCardChecklist = Add-TrelloChecklist -Token $AuthWrite -Id $NewTrelloCard.id -Name "Checklist" -Position "top"
$TrelloCardChecklistItem1 = Add-TrelloChecklistItem -Token $AuthWrite -Id $TrelloCardChecklist.id -Name "TestItem1"
$TrelloCardChecklistItem2 = Add-TrelloChecklistItem -Token $AuthWrite -Id $TrelloCardChecklist.id -Name "TestItem2"
$TrelloCardChecklistItem3 = Add-TrelloChecklistItem -Token $AuthWrite -Id $TrelloCardChecklist.id -Name "TestItem3"

$TrelloCardChecklist2 = Add-TrelloChecklist -Token $AuthWrite -Id $NewTrelloCard3.id -Name "Checklist" -Position "top"
$TrelloCardChecklistItem4 = Add-TrelloChecklistItem -Token $AuthWrite -Id $TrelloCardChecklist2.id -Name "This is my rifle,"
$TrelloCardChecklistItem5 = Add-TrelloChecklistItem -Token $AuthWrite -Id $TrelloCardChecklist2.id -Name "This is my gun."
$TrelloCardChecklistItem6 = Add-TrelloChecklistItem -Token $AuthWrite -Id $TrelloCardChecklist2.id -Name "This is for fighting,"
$TrelloCardChecklistItem7 = Add-TrelloChecklistItem -Token $AuthWrite -Id $TrelloCardChecklist2.id -Name "This is for fun."

#Attachment
$TrelloCardAttachment = Add-TrelloAttachment -Token $AuthWrite -Id $NewTrelloCard.id -Name "Some attachment" -Url "http://www.desktopbackgroundsi.net/wp-content/uploads/Picture_6.jpg"
$TrelloCardAttachment2 = Add-TrelloAttachment -Token $AuthWrite -Id $NewTrelloCard7.id -Name "Some attachment" -Url "http://www.freewebheaders.com/wordpress/wp-content/gallery/global/global-franchise-blue-header.jpg"
#endregion Initial setup

## Clean up the demo board
#region Cleanup
Remove-TrelloChecklistItem -Token $AuthWrite -Id $TrelloCardChecklist.id -ItemId $TrelloCardChecklistItem3.id
Remove-TrelloChecklistItem -Token $AuthWrite -Id $TrelloCardChecklist.id -ItemId $TrelloCardChecklistItem2.id
Remove-TrelloChecklistItem -Token $AuthWrite -Id $TrelloCardChecklist.id -ItemId $TrelloCardChecklistItem1.id
Remove-TrelloChecklist -Token $AuthWrite -Id $TrelloCardChecklist.id

Remove-TrelloChecklistItem -Token $AuthWrite -Id $TrelloCardChecklist.id -ItemId $TrelloCardChecklistItem7.id
Remove-TrelloChecklistItem -Token $AuthWrite -Id $TrelloCardChecklist.id -ItemId $TrelloCardChecklistItem6.id
Remove-TrelloChecklistItem -Token $AuthWrite -Id $TrelloCardChecklist.id -ItemId $TrelloCardChecklistItem5.id
Remove-TrelloChecklistItem -Token $AuthWrite -Id $TrelloCardChecklist.id -ItemId $TrelloCardChecklistItem4.id
Remove-TrelloChecklist -Token $AuthWrite -Id $TrelloCardChecklist2.id

Remove-TrelloAttachment -Token $AuthWrite -Id $TrelloCardAttachment.id -CardId $NewTrelloCard.id
Remove-TrelloAttachment -Token $AuthWrite -Id $TrelloCardAttachment2.id -CardId $NewTrelloCard7.id

Remove-TrelloCard -Token $AuthWrite -Id $NewTrelloCard7.id
Remove-TrelloCard -Token $AuthWrite -Id $NewTrelloCard6.id
Remove-TrelloCard -Token $AuthWrite -Id $NewTrelloCard5.id
Remove-TrelloCard -Token $AuthWrite -Id $NewTrelloCard4.id
Remove-TrelloCard -Token $AuthWrite -Id $NewTrelloCard3.id
Remove-TrelloCard -Token $AuthWrite -Id $NewTrelloCard2.id
Remove-TrelloCard -Token $AuthWrite -Id $NewTrelloCard.id

Remove-TrelloLabel -Token $AuthWrite -Id $TrelloBoardLabel_Daily.id
Remove-TrelloLabel -Token $AuthWrite -Id $TrelloBoardLabel_Weekkly.id
Remove-TrelloLabel -Token $AuthWrite -Id $TrelloBoardLabel_Monthly.id
#endregion Cleanup