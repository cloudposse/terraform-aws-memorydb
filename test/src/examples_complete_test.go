package test

import (
  "os"
  "strings"
  "testing"

  "github.com/gruntwork-io/terratest/modules/random"
  "github.com/gruntwork-io/terratest/modules/terraform"
  testStructure "github.com/gruntwork-io/terratest/modules/test-structure"
  "github.com/stretchr/testify/assert"
)

func cleanup(t *testing.T, terraformOptions *terraform.Options, tempTestFolder string) {
  terraform.Destroy(t, terraformOptions)
  os.RemoveAll(tempTestFolder)
}

// Test the Terraform module in examples/complete using Terratest.
func TestExamplesComplete(t *testing.T) {
  t.Parallel()
  randID := strings.ToLower(random.UniqueId())
  attributes := []string{randID}

  rootFolder := "../../"
  terraformFolderRelativeToRoot := "examples/complete"
  varFiles := []string{"fixtures.us-east-2.tfvars"}

  tempTestFolder := testStructure.CopyTerraformFolderToTemp(t, rootFolder, terraformFolderRelativeToRoot)

  terraformOptions := &terraform.Options{
    // The path to where our Terraform code is located
    TerraformDir: tempTestFolder,
    Upgrade:      true,
    // Variables to pass to our Terraform code using -var-file options
    VarFiles: varFiles,
    Vars: map[string]interface{}{
      "attributes": attributes,
      // avoid opentofu and terraform colliding on the same username during parallel tests
      "admin_username": "admin-" + randID,
      "ssm_parameter_name": "memorydb/eg-ue2-test-memorydb-" + randID,
    },
  }

  // At the end of the test, run `terraform destroy` to clean up any resources that were created
  defer cleanup(t, terraformOptions, tempTestFolder)

  // This will run `terraform init` and `terraform apply` and fail the test if there are any errors
  terraform.InitAndApply(t, terraformOptions)

  // Run `terraform output` to get the value of an output variable
  // id := terraform.Output(t, terraformOptions, "id")
  // arn := terraform.Output(t, terraformOptions, "arn")
  // cluster_endpoint := terraform.Output(t, terraformOptions, "cluster_endpoint")

  // Verify we're getting back the outputs we expect
  // Ensure we get a valid ARN
  //assert.Contains(t, arn, "eg-ue2-test-memorydb-" + randID)

  //// Ensure we get the expected id
  //assert.Equal(t, "eg-ue2-test-memorydb-" + randID, id)
  //assert.Contains(t, cluster_endpoint, "eg-ue2-test-memorydb")

}

func TestExamplesCompleteDisabled(t *testing.T) {
  t.Parallel()
  randID := strings.ToLower(random.UniqueId())
  attributes := []string{randID}

  rootFolder := "../../"
  terraformFolderRelativeToRoot := "examples/complete"
  varFiles := []string{"fixtures.us-east-2.tfvars"}

  tempTestFolder := testStructure.CopyTerraformFolderToTemp(t, rootFolder, terraformFolderRelativeToRoot)

  terraformOptions := &terraform.Options{
    // The path to where our Terraform code is located
    TerraformDir: tempTestFolder,
    Upgrade:      true,
    // Variables to pass to our Terraform code using -var-file options
    VarFiles: varFiles,
    Vars: map[string]interface{}{
      "attributes": attributes,
      "enabled":    "false",
    },
  }

  // At the end of the test, run `terraform destroy` to clean up any resources that were created
  defer cleanup(t, terraformOptions, tempTestFolder)

  // This will run `terraform init` and `terraform apply` and fail the test if there are any errors
  results := terraform.InitAndApply(t, terraformOptions)

  // Should complete successfully without creating or changing any resources
  assert.Contains(t, results, "Resources: 0 added, 0 changed, 0 destroyed.")
}
