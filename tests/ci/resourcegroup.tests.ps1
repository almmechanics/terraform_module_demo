param 
(
    [string]
    $ResourceGroupName
)

Describe "Resource Group" {

    $res = @(Get-AzResource -ResourceGroupName $ResourceGroupName)
    $resName = $res.name
    Context "Resource Group common" {
        It "Resource Group '$resName' exists" {
            $res.count | should not benullorempty
        }

        It "Resource Group '$resName' located in uksouth" {
            $res.Location | should be 'uksouth'
        }

        It "Only one resource exists in '$resName' " {
            $res.Count | should be 1
        }
    }
}