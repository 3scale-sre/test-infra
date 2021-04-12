# Description

A ruby script which can be used to export an organization's team memberships to a YAML.


The CSV file will be written to a data subfolder, and lists, for each member:

```
team-slug-1:
- username1
- username2
team-slug-2:
- username1
- username4
- username5
...
```

# Setup:

Build the docker image

```shell
make build
```

As a user with administrative privileges in GitHub,
create a personal access token with `read:org` permissions in:

`Settings > Developer settings > Personal access tokens`

Export the GitHub access token:

```
export OCTOKIT_ACCESS_TOKEN='xxxx'
```

# Running

```
make run ORG=<Github Org Name>
```