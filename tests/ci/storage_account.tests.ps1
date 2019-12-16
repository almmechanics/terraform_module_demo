param 
(
    [string]
    $ResourceGroupName
)

Describe "Storage Account" {

    $res = @(Get-AzResource -ResourceType 'Microsoft.Storage/storageAccounts' -ResourceGroupName $ResourceGroupName)
    $resName = $res.name
    Context "Storage Account common" {
        It "Storage Account '$resName' exists" {
            $res.count | should be 1
        }

        It "Storage Account '$resName' located in uksouth" {
            $res.Location | should be 'uksouth'
        }
    }

    $sa = Get-AzStorageAccount -ResourceGroupName $ResourceGroupName -Name $resName -ErrorAction SilentlyContinue
   
    Context "Storage Account '$resName' configuration" {

        It "Storage Account '$resName' is Provisioned" {
            $sa.ProvisioningState | should be 'Succeeded'
        } 

        It "Storage Account '$resName' has a Standard GRS Sku" {
            $sa.Sku.name | should be 'Standard_GRS'
        } 

        It "Storage Account '$resName' is using standard V2 storage" {
            $sa.Kind | should be 'StorageV2'
        }  

        It "Storage Account '$resName' is using Hot storage" {
            $sa.AccessTier | should be 'Hot'
        } 

        It "Storage Account '$resName' is using https" {
            $sa.EnableHttpsTrafficOnly | should be 'True'
        } 
    }

    Context "Storage Account '$resName' Network configuration" {

        It "Storage Account '$resName' uses a default Deny rule" {
            $sa.NetworkRuleSet.DefaultAction | should be 'Deny'
        }

        It "Storage Account '$resName' allows access to AzureServices" {
            $sa.NetworkRuleSet.Bypass | should be 'AzureServices'
        }
    }
    
    Context "Storage Account '$resName' tags" {
    
        It "Storage Account '$resName' has at least two tags" {
            $sa.Tags.Count -ge 2 | should -BeGreaterOrEqual 2
        }

        $cases = @{ tag = 'usage' },@{ tag = 'environment' }
        it "The tag '<tag>' exists in '$resName'" -TestCases $cases {
            param ( $tag )
            $sa.Tags.Keys | should contain $tag
        }
    }   
}