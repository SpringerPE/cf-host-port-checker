team: engineering-enablement
pipeline: host-port-checker
trigger_interval: 24h

tasks:
- type: deploy-cf
  api: ((cloudfoundry.api-snpaas))
  space: live
  manifest: manifest-snpaas.yml
