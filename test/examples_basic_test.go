package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestExamplesBasic(t *testing.T) {

	terraformOptions := &terraform.Options{
		TerraformDir: "../examples/basic",
		// Vars: map[string]interface{}{
		// 	"myvar":     "test",
		// 	"mylistvar": []string{"list_item_1"},
		// },
	}

	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)
}
