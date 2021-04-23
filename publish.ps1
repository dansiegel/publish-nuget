param(
  [string]$FeedUrl,
  [string]$ApiKey,
  [string]$SearchPath = "**/*.nupkg"
)

$recurse = $false
if($SearchPath.StartsWith("**/") -or $SearchPath.StartsWith("**\\")) {
    $SearchPath = $SearchPath.Substring(3)
    $recurse = $true
    Write-Host "Searching '$SearchPath' recursively"
}
else {
    Write-Host "Searching $SearchPath"
}

Get-ChildItem . -Filter $SearchPath -Recurse:$recurse |
ForEach-Object {
    Write-Host "Publishing $_.FullName"
    nuget push $_.FullName -Source $FeedUrl -ApiKey $ApiKey -SkipDuplicate
}

Write-Host "Packages Published"