# gcp-foundation 

Example repo showing how to build a secure cloud foundation / landing zone for quick prototyping and testing. It is made up of following parts:

- **example-foundations**
  - core (0* and $vpc-sc)
  - gke (1*)
  - data (2*)
- **onprem-connectivity** (9*): set of repos to build simulated onprem environment on gcp and conduct basic connectivity tests

## Credits
- [terraform-example-foundation](https://github.com/terraform-google-modules/terraform-example-foundation) (core)
- [terraform-example-foundation-app](https://github.com/GoogleCloudPlatform/terraform-example-foundation-app) (gke)
- [cloud-foundation-fabric](https://github.com/terraform-google-modules/cloud-foundation-fabric) (data, vpc-sc)

## Org Hierarchy
```
🏢 budita.dev (157305482127)
 +-- 📁 fldr-bootstrap (818226860401)
 |   +-- 📦 prj-b-seed-6949
 |   +-- 📦 prj-b-cicd-98fa
 +-- 📁 fldr-common (161434909087)
 |   +-- 📦 prj-m4ce-c-host-11c7
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
 |   +-- 📦 prj-ad-d-mgmt-6b1d
 |   +-- 📦 prj-gke-d-clusters-3c96
 |   +-- 📦 prj-data-d-landing-0816
 |   +-- 📦 prj-bu1-d-sample-base-9208
 |   +-- 📦 prj-d-shared-base-21a3
 +-- 📁 fldr-onprem (261068120484)
     +-- 📦 prj-onprem-o-connectivity-53cd
```
https://github.com/GoogleCloudPlatform/professional-services/tree/main/tools/gcp-org-hierarchy-viewer

## Org IP Address Space

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
    - ad-mgmt 10.0.88.0/24
    - proxy-only 10.0.89.0/24
- us-west1 10.1.0.0/16
  - Hub 10.1.0.0/18
    - sb 10.1.0.0/24
  - Dev 10.1.64.0/18
    - bu1 10.1.64.0/21
    - data 10.1.72.0/21
    - gke 10.1.80.0/21
    - ad-mgmt 10.1.88.0/24
    - proxy-only 10.1.89.0/24
- Dev Private Service 10.16.64.0/21
```

## GKE Admins Repo

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
- Core foundation infra pipelines
- Project-level infra and cicd pipelines
- Basic python app deployed in a private gke cluster in shared vpc env
- Basic dataflow pipelines showing etl flow in shared vpc env
- Set up onprem connectivity via cloud ha vpn and conduct basic tests

## To get $0 bill on foundation resources (0*)
- Enable private dns zones on demand
- Don't enable container scanning api
- Don't use hierarchical firewall policies
- Don't use kms
- Limit log sinks
- Regular cleanup of artifact registry images in infra and cicd pipeline projects
