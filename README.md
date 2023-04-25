# Bitbucket Pipelines Pipe: Google App Engine Cleanup

Pipe to clean old version of an application deployed on Google App Engine.

## YAML Definition

Add the following snippet to the script section of your `bitbucket-pipelines.yml` file:

```yaml
- pipe: atlassian/google-app-engine-deploy:1.0.0
  variables:
    KEY_FILE: '<string>'
    PROJECT: '<string>'
    SERVICES: '<string>'
    # DEBUG: '<boolean>' # Optional.
    # KEEP_VERSIONS: '<integer>' # Optional
```

## Variables

| Variable                   | Usage                                                |
| ----------------------------- | ---------------------------------------------------- |
| KEY_FILE (*)                  |  base64 encoded content of Key file for a [Google service account](https://cloud.google.com/iam/docs/creating-managing-service-account-keys). To encode this content, follow [encode private key doc][encode-string-to-base64].|
| PROJECT (*)                   |  The Project ID of the project that owns the app to deploy. |
| SERVICES (*)                  |  List of services on which run the cleanup. |
| DEBUG                         |  Turn on extra debug information. Default `false`. |
| KEEP_VERSIONS                 |  Number of version to keep. Default `10`. |

_(*) = required variable._


## Details

With the Google App Engine Cleanup pipe you can clean old version of your application deployed on Google App Engine.
All [gcloud components][gcloud components] are installed.


## Prerequisites

* An IAM user is configured with sufficient permissions to perform a cleanup of your application using gcloud.
* You have [enabled APIs and services](https://cloud.google.com/service-usage/docs/enable-disable) needed for your application.


## Examples

### Basic example:

```yaml
script:
  - pipe: tohero/google-app-engine-cleanup:1.0.0
    variables:
      KEY_FILE: $KEY_FILE
      PROJECT: 'my-project'
      SERVICES: 'my-services'
```

### Advanced example:

Cleanup multiple services.

```yaml
script:
  - pipe: tohero/google-app-engine-cleanup:1.0.0
    variables:
      KEY_FILE: $KEY_FILE
      PROJECT: 'my-project'
      SERVICES: 'my-services-1 my-services-2'
```

Update keep version limit
```yaml
script:
  - pipe: tohero/google-app-engine-cleanup:1.0.0
    variables:
      KEY_FILE: $KEY_FILE
      PROJECT: 'my-project'
      KEEP_VERSIONS: '5'
      SERVICES: 'my-services'
```

## Deployment

```
docker build -t tohero/google-app-engine-cleanup .
docker push tohero/google-app-engine-cleanup
``` 

## License
Apache 2.0 licensed, see [LICENSE.txt](LICENSE.txt) file.

[encode-string-to-base64]: https://confluence.atlassian.com/bitbucket/use-ssh-keys-in-bitbucket-pipelines-847452940.html#UseSSHkeysinBitbucketPipelines-UsemultipleSSHkeysinyourpipeline
[gcloud components]: https://cloud.google.com/sdk/docs/components#additional_components
