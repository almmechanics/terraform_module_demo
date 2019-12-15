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

    Context "Resource Group '$resName' tags" {
    
        It "Resource Group '$resName' has at least two tags" {
            $rg.Tags.Count | should -BeGreaterOrEqual 2
        }

        $cases = @{ tag = 'usage' },@{ tag = 'environment' }
        it "The tag '<tag>' exists in '$resName'" -TestCases $cases {
            param ( $tag )
            $rg.Tags.Keys | should contain $tag
        }
    }  
}