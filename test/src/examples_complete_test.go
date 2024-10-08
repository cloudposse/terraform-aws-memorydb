package test

import (
	"os"
	"strings"
	"testing"

  "github.com/gruntwork-io/terratest/modules/aws"
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

  adminID := "admin-" + randID
  clusterID := "eg-ue2-test-memorydb-" + randID
  ssmParameterName := "/memorydb/" + clusterID
  region := "us-east-2"

  rootFolder := "../../"
  terraformFolderRelativeToRoot := "examples/complete"
  varFiles := []string{"fixtures." + region + ".tfvars"}

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
      "admin_username": adminID,
      "ssm_parameter_name": ssmParameterName,
    },
  }

  // At the end of the test, run `terraform destroy` to clean up any resources that were created
  defer cleanup(t, terraformOptions, tempTestFolder)

  // This will run `terraform init` and `terraform apply` and fail the test if there are any errors
  terraform.InitAndApply(t, terraformOptions)

  // Run `terraform output` to get the value of an output variable
  id := terraform.Output(t, terraformOptions, "id")
  assert.Equal(t, id, clusterID)

  arn := terraform.Output(t, terraformOptions, "arn")
  assert.Contains(t, arn, clusterID)

  cluster_endpoint := terraform.Output(t, terraformOptions, "cluster_endpoint")
  assert.Contains(t, cluster_endpoint, clusterID)

  admin_acl_arn := terraform.Output(t, terraformOptions, "admin_acl_arn")
  assert.Contains(t, admin_acl_arn, "acl/" + clusterID)
  
  admin_arn := terraform.Output(t, terraformOptions, "admin_arn")
  assert.Contains(t, admin_arn, adminID)

  admin_password_ssm_parameter_name := terraform.Output(t, terraformOptions, "admin_password_ssm_parameter_name")
  assert.Equal(t, admin_password_ssm_parameter_name, ssmParameterName)
  adminPassword, err := aws.GetParameterE(t, region, admin_password_ssm_parameter_name)
  if err != nil {
    assert.Fail(t, "Failed to retrieve admin password from SSM parameter: " + admin_password_ssm_parameter_name)
  } else {
    assert.NotEmpty(t, adminPassword)
  }
  
  admin_username := terraform.Output(t, terraformOptions, "admin_username")
  assert.Equal(t, admin_username, adminID)

  engine_patch_version := terraform.Output(t, terraformOptions, "engine_patch_version")
  assert.Contains(t, engine_patch_version, "6.2.") // 6.2.x since patch versions are not guaranteed to be the same over time

  parameter_group_arn := terraform.Output(t, terraformOptions, "parameter_group_arn")
  assert.Contains(t, parameter_group_arn, "parametergroup/" + clusterID)

  parameter_group_id := terraform.Output(t, terraformOptions, "parameter_group_id")
  assert.Equal(t, parameter_group_id, clusterID)

  subnet_group_arn := terraform.Output(t, terraformOptions, "subnet_group_arn")
  assert.Contains(t, subnet_group_arn, "subnetgroup/" + clusterID)

  subnet_group_id := terraform.Output(t, terraformOptions, "subnet_group_id")
  assert.Contains(t, subnet_group_id, clusterID)

  shards := terraform.Output(t, terraformOptions, "shards")
  assert.Contains(t, shards, clusterID + "-0001-001")
  // also make sure at least one of the availability zones is present
  assert.Contains(t, shards, "us-east-2a")

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
