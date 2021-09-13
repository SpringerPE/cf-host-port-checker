team: engineering-enablement
pipeline: host-port-checker

tasks:
- type: deploy-cf
  api: ((cloudfoundry.api-snpaas))
  space: live
  manifest: manifest-snpaas.yml
