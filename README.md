Lab
===

## Overview

Lab is designed to be a modular baseline for setting up a Platform for experimenting with technologies and workflows.

Lab is broken out into Tiers, which build upon each other. A "tier" is a platform layer that has a clear boundary of responsibility and a capability set to build subsequent "tiers" upon.

![Lab Tiers](https://docs.google.com/drawings/d/e/2PACX-1vR0Z41CYi1Hy2G5boTT0qymhU1cm7x7ze9UyeWiJQJDpx6ZGDSDTwn-GiZxJJF52n_6QptosIA59GZV/pub?w=491&amp;h=399)
[edit](https://docs.google.com/drawings/d/1rKnkHT9fBuF_aGeflyx3TT54dOQaebne8oeBdLCKT1Q/edit)

0. Terraform State: Deploy a _container_ for storage shared terraform state
1. Orchestration: Deploy the minimum set of resources for all subsequent automation
2. Runtimes: Support `n` number of "runtimes" where a "runtime" is an environment (production level + location) for running "services"


## Getting started

Start by cloning this Git repository.

### TerraformState (Tier 0)

For shared Terraform state, start by deploying 0-TerraformState:

1. Copy `stack/0-TerraformState/settings.auto.tfvars-TEMPLATE` to `stack/0-TerraformState/settings.auto.tfvars`
2. Edit `stack/0-TerraformState/settings.auto.tfvars`
3. deploy Tier 0:

```
    cd stack/0-TerraformState
    terraform init
    terraform apply
```

4. (Optional) Migrate 0-TerraformState to shared state.  The directions will be presented in outputs from `terraform apply`.
