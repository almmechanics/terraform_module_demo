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

    $rg = Get-AzResourceGroup -ResourceGroupName $ResourceGroupName -ErrorAction SilentlyContinue

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