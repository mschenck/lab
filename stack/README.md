Lab - Stack
===========

The "stack" is the Tiered architecture for all of the lab infrastructure-related gitops management.

## Components

- `modules`
  - `<#-TierName>` - Tier modules: intended to managed `n`-supported vendors for a given Tier
  - `<vendor>` - Vendor modules: to present a common capability set across `n` different vendors
- `<#-TierName>` - Tier terraform roots: the Terraform root for managing the given Tier
- `env` - (DEPRECATED) Legacy holding place for reference until all capabilities have been migrated to Tiers
