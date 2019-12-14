
param 
(
    [string]
    $ResourceGroupName
)

Describe "Key vault" {

    $res = @(Get-AzResource -ResourceType 'Microsoft.KeyVault/vaults' -ResourceGroupName $ResourceGroupName)

    Context "Key Vault common" {
        It "Keyvault exists" {
            $res.count | should be 1
        }

        It "Keyvault located in uksouth" {
            $res.Location | should be 'uksouth'
        }

        $kv = Get-AzKeyVault -ResourceGroupName $ResourceGroupName -Name $resName
        It "Standard SKU provisioned" {
            $kv.SKU | should be 'Standard'
        } 
    }   
}