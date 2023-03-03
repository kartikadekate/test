#!/bin/bash

# List of regions to delete rule from
regions=("us-east-1")

# Loop through each region
for region in "${regions[@]}"
do
  # Get the remediation configuration name
  remediation_config=$(aws configservice describe-remediation-configurations --region $region --config-rule-name cleardata_ec2_compliance-rapid7 --query "RemediationConfigurations[0].Name" --output text)

  # Delete the remediation configuration
  if [[ -n "$remediation_config" ]]; then
    aws configservice delete-remediation-configuration --region $region --config-rule-name cleardata_ec2_compliance-rapid7
    echo "Deleted Remediation Configuration $remediation_config associated with Config Rule cleardata_ec2_compliance-rapid7 in region $region"
  fi

  # Delete the config rule
  aws configservice delete-config-rule --region $region --config-rule-name cleardata_ec2_compliance-rapid7
  echo "Deleted Config Rule cleardata_ec2_compliance-rapid7 in region $region"
done
