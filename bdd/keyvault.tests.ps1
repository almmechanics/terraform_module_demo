
param 
(
    [string]
    $ResourceGroupName
)

Describe "Key vault" {

    $res = @(Get-AzResource -ResourceType 'Microsoft.KeyVault/vaults' -ResourceGroupName $ResourceGroupName)
    $resName = $res.name
    Context "Key Vault common" {
        It "Keyvault '$resName' exists" {
            $res.count | should be 1
        }

        It "Keyvault '$resName' located in uksouth" {
            $res.Location | should be 'uksouth'
        }
    }

    $kv = Get-AzKeyVault -ResourceGroupName $ResourceGroupName -VaultName $resName -ErrorAction SilentlyContinue
   
    Context "Keyvault '$resName' configuration" {
        It "Keyvault '$resName' has a Standard SKU" {
            $kv.SKU | should be 'Standard'
        } 
    }

    Context "Keyvault '$resName' ACL configuration" {

        It "Keyvault '$resName' uses a default Deny rule" {
            $kv.NetworkAcls.DefaultAction | should be 'Deny'
        }

        It "Keyvault '$resName' allows access to AzureServices" {
            $kv.NetworkAcls.Bypass | should be 'AzureServices'
        }
    }

    Context "Keyvault '$resName' tags" {
    
        It "Keyvault '$resName' has at least two tags" {
            $kv.Tags.Count | should BeGreaterOrEqual 2
        }

        $cases = @{ tag = 'usage' },@{ tag = 'environment' }
        it "The tag '<tag>' exists in '$resName'" -TestCases $cases {
            param ( $tag )
            $kv.Tags.Keys | should contain $tag
        }
    }   
}