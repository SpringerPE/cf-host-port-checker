# https://concourse.halfpipe.io/teams/engineering-enablement/pipelines/host-port-checker
team: engineering-enablement
pipeline: host-port-checker
slack_channel: '#ee-alerts'

feature_toggles:
  - update-pipeline

tasks:
  - type: parallel
    tasks:
      - type: deploy-cf
        api: ((cloudfoundry.api-snpaas))
        space: live
        manifest: manifest-snpaas.yml
      - type: sequence
        tasks:
          - name: docker-build
            type: docker-push
            image: eu.gcr.io/halfpipe-io/ee-host-port-checker
            tag: version
          - type: run
            name: deploy-host-port-checker-dev
            script: \/exe vela up -f ci/vela-dev.yaml
            docker:
              image: eu.gcr.io/halfpipe-io/ee-katee-vela-cli:latest
            vars:
              KATEE_TEAM: engineering-enablement
              KATEE_GKE_CREDENTIALS: ((katee-service-account-dev.key))
              KATEE_APPFILE: ci/vela-dev.yaml
              KATEE_GKE_PROJECT: dev
          - type: run
            name: deploy-host-port-checker-prod
            script: \/exe vela up -f ci/vela-prod.yaml
            docker:
              image: eu.gcr.io/halfpipe-io/ee-katee-vela-cli:latest
            vars:
              KATEE_TEAM: engineering-enablement
              KATEE_GKE_CREDENTIALS: ((katee-service-account.key))
              KATEE_APPFILE: ci/vela-prod.yaml
              KATEE_GKE_PROJECT: prod



