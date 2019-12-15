param 
(
    [string]
    $ResourceGroupName
)

Describe "Resource Group" {

    $rg = Get-AzResourceGroup $ResourceGroupName
    Context "Resource Group common" {
        It "Resource Group '$ResourceGroupName' exists" {
            $rg | should not benullorempty
        }

        It "Resource Group '$ResourceGroupName' located in uksouth" {
            $rg.Location | should be 'uksouth'
        }

        $resources = @(Get-AzResource -ResourceGroupName $ResourceGroupName)
        It "Two Azure resource exist in '$ResourceGroupName' " {
            $resources.Count | should be 2
        }
    }
}