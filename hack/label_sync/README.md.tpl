# 3scale-sre GitHub Labels

## Table of Contents

- [3scale-sre GitHub Labels](#3scale-sre-github-labels)
  - [Table of Contents](#table-of-contents)
  - [Intro](#intro)
    - [Why these labels?](#why-these-labels)
    - [Configuration](#configuration)
    - [How do I add a new label?](#how-do-i-add-a-new-label)
{{ range $labelData := . -}}
  - [Labels that apply to {{ $labelData.Description }}](#labels-that-apply-to-{{ $labelData.Link }})
{{ end }}

## Intro

This file was auto generated by the [label_sync](https://github.com/3scale-sre/test-infra/tree/main/hack/label_sync) tool,
based on the [labels.yaml](https://github.com/3scale-sre/test-infra/blob/main/hack/label_sync/labels.yaml) that it uses to
sync GitHub labels across repos in the [3scale-sre GitHub org](https://github.com/3scale-sre) and  [3scale GitHub org](https://github.com/3scale).

### Why these labels?

The rule of thumb is that labels are here because they are intended to be produced or consumed by
our automation (primarily prow) across all repos. There are some labels that can only be manually
applied/removed, and where possible we would rather remove them or add automation to allow a
larger set of contributors to apply/remove them.

### Configuration

A typical labels.yaml file looks like:

```yaml
---
labels:
  - color: 00ff00
    name: lgtm
  - color: ff0000
    name: priority/P0
    previously:
    - color: 0000ff
      name: P0
  - name: dead-label
    color: cccccc
    deleteAfter: 2017-01-01T13:00:00Z
```

This will ensure that:

- there is a green `lgtm` label
- there is a red `priority/P0` label, and previous labels should be migrated to it:
  - if a `P0` label exists:
    - if `priority/P0` does not, modify the existing `P0` label
    - if `priority/P0` exists, `P0` labels will be deleted, `priority/P0` labels will be added
- if there is a `dead-label` label, it will be deleted after 2017-01-01T13:00:00Z

### How do I add a new label?

- Add automation that consumes/produces the label
- Open a PR, _with a single commit_, that:
  - Update [labels.yaml](https://github.com/3scale-sre/test-infra/blob/main/hack/label_sync/labels.yaml) with the new label(s)
  - Run `make docs` (to regenerate the labels README documentation)
- After the PR is merged, a GitHub Action is responsible for syncing labels after a change (and daily)

If the label needs to be seteable via prow command, using `/label foo/bar`,
it needs to be added to the `additional_labels` list of the prow `label` plugin.
That list is available in the `label` configuration section inside the
[Prow plugins ConfigMap](https://github.com/3scale-sre/test-infra/blob/main/manifests/prow/configmaps/plugins.yaml).

{{ range $labelData := . -}}
## Labels that apply to {{ $labelData.Description }}

| Name | Description | Added By | Prow Plugin |
| ---- | ----------- | -------- | ----------- |
{{ range $labelData.Labels -}}
  | <a id="{{ anchor .Name }}" href="#{{ anchor .Name }}">`{{ .Name }}`</a> | {{ if .DeleteAfter -}} REMOVING. This will be deleted after {{ .DeleteAfter }} <br><br> {{ end -}} {{ .Description }} {{- if .Previously }} <br><br> This was previously {{ range .Previously -}} `{{.Name }}`, {{ end -}}  {{ end -}} | {{.AddedBy }} | {{ if .ProwPlugin }} [{{.ProwPlugin}}](https://git.k8s.io/test-infra/prow/{{ if .IsExternalPlugin }}external-{{ end }}plugins/{{.ProwPlugin}}) {{ end }}|
{{ end }}
{{ end }}