using namespace System.Net

# Input bindings are passed in via param block.
param($Request, $CosmosIn, $TriggerMetadata)

# Write to the Azure Functions log stream.
Write-Host "PowerShell HTTP trigger function processed a request."

if (-not $CosmosIn) { 
    $body = 'VisitorCounter item not found'
    Write-Host $body

    Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{ 
        StatusCode = [HttpStatusCode]::NotFound 
        Body = $body
    })
}
else {
    $Count = $CosmosIn.vCount
    Write-Host "Found Counter item,  current Count: $Count"

    $Count++
    Write-Host "New Count: $Count"

    $responseObject = @{
        vCount = $Count
    }

    $responseJson = ConvertTo-Json -InputObject $responseObject
 
    Push-OutputBinding -Name CosmosOut -Value @{
        id = $CosmosIn.id
        vCount = $Count
    }

    Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{ 
        StatusCode = [HttpStatusCode]::OK 
        Body = $responseJson
    })
}