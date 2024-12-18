# iac-gcp-foundation 

This repo shows how to build a secure cloud foundation / landing zone on GCP.

It is made up of following parts:
- core (0* and 99-vpc-sc)
- gke (1*)
- data (2*)
- onprem (9*)

## Credits
- [terraform-example-foundation](https://github.com/terraform-google-modules/terraform-example-foundation) (core)
- [terraform-example-foundation-app](https://github.com/GoogleCloudPlatform/terraform-example-foundation-app) (gke)
- [cloud-foundation-fabric](https://github.com/terraform-google-modules/cloud-foundation-fabric) (data, vpc-sc)

## Org hierarchy 
```
🏢 budita.dev (157305482127)
 +-- 📁 fldr-bootstrap (818226860401)
 |   +-- 📦 prj-b-seed-6949
 |   +-- 📦 prj-b-cicd-98fa
 +-- 📁 fldr-common (161434909087)
 |   +-- 📦 prj-c-base-net-hub-74f5
 |   +-- 📦 prj-gke-c-infra-pipeline-e6f5
 |   +-- 📦 prj-gke-c-cicd-pipeline-7989
 |   +-- 📦 prj-data-c-infra-pipeline-fb29
 |   +-- 📦 prj-bu1-c-infra-pipeline-eedb
 |   +-- 📦 prj-c-dns-hub-c4a2
 |   +-- 📦 prj-c-logging-8083
 +-- 📁 fldr-development (267943501446)
 |   +-- 📦 prj-data-d-loading-82c5
 |   +-- 📦 prj-data-d-lake-l0-ffe8
 |   +-- 📦 prj-gke-d-clusters-3c96
 |   +-- 📦 prj-data-d-landing-0816
 |   +-- 📦 prj-bu1-d-sample-base-9208
 |   +-- 📦 prj-d-shared-base-21a3
 +-- 📁 fldr-onprem (261068120484)
     +-- 📦 prj-onprem-o-connectivity-53cd
```
https://github.com/GoogleCloudPlatform/professional-services/tree/main/tools/gcp-org-hierarchy-viewer

## Org IP address space

```
🏢 budita.dev
- us-central1 10.0.0.0/16
  - Hub 10.0.0.0/18
    - sb 10.0.0.0/24
  - Dev 10.0.64.0/18
    - bu1 10.0.64.0/21
    - data 10.0.72.0/21
    - gke 10.0.80.0/21
      - budita
        - node 10.0.80.0/24
        - pod 100.64.64.0/18
        - svc 100.64.128.0/24
        - master 100.64.129.0/28
    - proxy-only 10.0.89.0/24
- us-west1 10.1.0.0/16
  - Hub 10.1.0.0/18
    - sb 10.1.0.0/24
  - Dev 10.1.64.0/18
    - bu1 10.1.64.0/21
    - data 10.1.72.0/21
    - gke 10.1.80.0/21
    - proxy-only 10.1.89.0/24
- Dev Private Service 10.16.64.0/21
```

## GKE platform admins repo

```
🏢 budita.dev
.
├── budita-app
│   ├── acm
│   │   ├── cluster
│   │   │   └── privileged-container-constraint.yaml
│   │   ├── namespaces
│   │   │   └── frontend
│   │   │       ├── admin-role-binding.yaml
│   │   │       ├── allow-all-ingress-networkpolicy.yaml
│   │   │       ├── istio-egress-googleapis.yaml
│   │   │       ├── istio-egress-metadata.yaml
│   │   │       ├── namespace.yaml
│   │   │       └── quota.yaml
│   │   └── system
│   │       ├── README.md
│   │       └── repo.yaml
│   └── kustomize-bases
│       └── frontend
│           ├── deployment.yaml
│           ├── istio-gateway.yaml
│           ├── istio-route.yaml
│           ├── ksa.yaml
│           ├── kustomization.yaml
│           └── service.yaml
└── README.md
```
## Validations
Some validations to see if things work as expected:
- Core foundation infra pipelines
- Project-level infra and cicd pipelines
- Basic python app deployed in a private gke cluster in shared vpc env
- Basic dataflow pipelines showing etl flow in shared vpc env
- Set up onprem connectivity via cloud ha vpn in hub shared vpc and conduct basic tests

## Costs
We get away with $0 bill on foundation resources:
- Create private dns zones on demand. The current state of private dns zones for this foundation is listed below:
```
enable_dns_zone_private_googleapis = false
enable_dns_zone_gcr                = false
enable_dns_zone_pkg_dev            = false
enable_dns_peering                 = false
enable_dns_forwarding              = false
```
- Disable container scanning api if it is enabled
- Skip hierarchical firewall policies
- Skip kms
- Limited use of log sinks
- Cleanup of artifact registry images in infra and cicd pipeline projects
