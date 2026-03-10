# Oh CI!

> Minimal tooling for CI via O(h)CI.

Oh CI is an Alpine based image maintained for bash/sh style CI in a container environment. Just the essentials, like trees, and Pokémon because it is not safe out there in this world if you do not have at least one.

---

## What's Inside

| Tool | Why It's Here |
|------|---------------|
| `bash` | Because `sh` alone is pain |
| `coreutils` | The GNU classics — `date`, `stat`, `env`, friends |
| `curl` | Talk to things |
| `gettext` | Provides `envsubst` — template all the things |
| `git` | Clone, fetch, diff |
| `jq` | Speak JSON fluently |
| `rsync` | Move files with grace |
| `tree` | See what you're working with |
| `yq` | Like `jq` but for YAML |
| `krabby` | Display Pokémon in your terminal. No, it's not negotiable. |

---

## Quick Start

```bash
# Run it
docker run --rm -it docker.io/prplanit/oh-ci:latest

# Template a config file from environment variables
docker run --rm \
  -e DB_HOST=postgres.local \
  -e DB_PORT=5432 \
  -v ./template.conf:/template.conf \
  docker.io/prplanit/oh-ci:latest \
  sh -c 'envsubst < /template.conf'

# Greet yourself properly
docker run --rm docker.io/prplanit/oh-ci:latest krabby random
```

---

## Use Cases

| Scenario | Example |
|----------|---------|
| **K8s init container** | Render config templates with `envsubst` before the app starts |
| **CI pipeline step** | Clone a repo, `jq` an API response, `rsync` artifacts |
| **Config generation** | Substitute `${VAR}` placeholders in YAML/HCL/TOML files |
| **Debugging** | Drop into a pod with actual tools instead of crying into busybox |

---

## Kubernetes Init Container Example

```yaml
initContainers:
  - name: render-config
    image: docker.io/prplanit/oh-ci:latest
    command: ["/bin/sh", "-c"]
    args:
      - envsubst < /template/app.conf > /config/app.conf
    envFrom:
      - secretRef:
          name: app-secrets
    volumeMounts:
      - name: template
        mountPath: /template
      - name: config
        mountPath: /config
```

---

## Looking For Something Else?

| Image | What It's For |
|-------|---------------|
| [`prplanit/ansible-oci`](https://hub.docker.com/r/prplanit/ansible-oci) | Ansible playbooks, Python, collections, the whole orchestra |
| [`prplanit/stagefreight`](https://hub.docker.com/r/prplanit/stagefreight) | Declarative CI/CD — detect, build, scan, and release container images |
| [`alpine/k8s`](https://hub.docker.com/r/alpine/k8s) | kubectl, helm, and the Kubernetes toolkit |

---

## Building

```bash
docker build -t prplanit/oh-ci:latest .
```

---

## License

Distributed under the [AGPL-3.0-only](LICENSE) License. See [LICENSING.md](docs/LICENSING.md) for commercial licensing.
