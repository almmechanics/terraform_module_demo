param 
(
    [string]
    $ResourceGroupName
)

Describe "Resource Group" {

    $rg = Get-AzResourceGroup $ResourceGroupName
    $resName = $rg.ResourceGroupName
    Context "Resource Group common" {
        It "Resource Group '$resName' exists" {
            $rg | should not benullorempty
        }

        It "Resource Group '$resName' located in uksouth" {
            $rg.Location | should be 'uksouth'
        }

        It "Only one resource exists in '$resName' " {
            $rg.Count | should be 1
        }
    }
}