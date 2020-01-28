team: engineering-enablement
pipeline: host-port-checker

triggers:
- type: timer
  cron: "0 1 * * *"

tasks:
- type: deploy-cf
  api: ((cloudfoundry.api-snpaas))
  space: live
  manifest: manifest-snpaas.yml
