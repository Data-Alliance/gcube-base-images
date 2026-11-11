# gcube-base-images

**English** | [한국어](README.ko.md)

Base images for the gcube GPU platform. They add only the common gcube settings on top of official PyTorch, TensorFlow, and CUDA environments, and serve as a starting point for lab environments.

Every image is available in both registries with the same name and tag.

| Registry | Address format |
|---|---|
| GitHub Container Registry | `ghcr.io/data-alliance/<image>:<tag>` |
| Docker Hub | `gcubeai/<image>:<tag>` ([hub.docker.com/u/gcubeai](https://hub.docker.com/u/gcubeai)) |

## Image lineup

### PyTorch — `gcube-pytorch-<torch>-cuda<cuda>`

Includes PyTorch, CUDA, cuDNN, and Python. Based on the official PyTorch images (`pytorch/pytorch`); the Ubuntu version follows the official image (PyTorch 2.8 and 2.9: Ubuntu 22.04, 2.10 and 2.11: Ubuntu 24.04).

| PyTorch \ CUDA | 12.6 | 12.8 | 13.0 |
|---|:---:|:---:|:---:|
| 2.8 | O | O | — |
| 2.9 | O | O | O |
| 2.10 | O | O | O |
| 2.11 | O | O | O |

Each image comes with two tags: `:runtime` and `:devel`.

### Ubuntu+CUDA — `gcube-ubuntu<ubuntu>-cuda<cuda>`

Contains only CUDA, for users who want to install their own framework. Based on the official NVIDIA CUDA images (`nvidia/cuda`); only Ubuntu/CUDA combinations that NVIDIA publishes are built.

| Ubuntu \ CUDA | 12.6 | 12.8 | 13.0 | 13.5 |
|---|:---:|:---:|:---:|:---:|
| 22.04 | O | O | O | — |
| 24.04 | O | O | O | — |
| 26.04 | — | — | — | O |

Each image comes with two tags: `:runtime` and `:devel`.

For Ubuntu 26.04, NVIDIA only publishes CUDA 13.3 and later, so it is provided with CUDA 13.5. The default Python is 3.14, and an NVIDIA driver that supports CUDA 13.5 (CUDA version 13.5 or later in `nvidia-smi`) is required.

### TensorFlow — `gcube-tensorflow-<tf>-cuda<cuda>`

Includes TensorFlow, CUDA, cuDNN, and Python. Built by copying TensorFlow from the NVIDIA NGC TensorFlow 25.02 container onto `gcube-ubuntu24.04-cuda12.8` (Ubuntu 24.04).

The official TensorFlow pip packages are built for CUDA 12.5 and do not support the RTX 50 series (Blackwell), so the NGC build for CUDA 12.8 is used. NGC TensorFlow 25.02 is the last NGC TensorFlow release, so this image stays at TensorFlow 2.17.

| TensorFlow | CUDA | Tag |
|---|---|---|
| 2.17 | 12.8 | `:runtime` |

## Usage

Use these images directly in gcube workloads, or as the `FROM` image when building your own Docker image. The addresses below are for the `:runtime` tag; the `:devel` tag works the same way.

**GitHub Container Registry**

```
# PyTorch
ghcr.io/data-alliance/gcube-pytorch-2.8-cuda12.6:runtime
ghcr.io/data-alliance/gcube-pytorch-2.8-cuda12.8:runtime
ghcr.io/data-alliance/gcube-pytorch-2.9-cuda12.6:runtime
ghcr.io/data-alliance/gcube-pytorch-2.9-cuda12.8:runtime
ghcr.io/data-alliance/gcube-pytorch-2.9-cuda13.0:runtime
ghcr.io/data-alliance/gcube-pytorch-2.10-cuda12.6:runtime
ghcr.io/data-alliance/gcube-pytorch-2.10-cuda12.8:runtime
ghcr.io/data-alliance/gcube-pytorch-2.10-cuda13.0:runtime
ghcr.io/data-alliance/gcube-pytorch-2.11-cuda12.6:runtime
ghcr.io/data-alliance/gcube-pytorch-2.11-cuda12.8:runtime
ghcr.io/data-alliance/gcube-pytorch-2.11-cuda13.0:runtime

# Ubuntu+CUDA
ghcr.io/data-alliance/gcube-ubuntu22.04-cuda12.6:runtime
ghcr.io/data-alliance/gcube-ubuntu22.04-cuda12.8:runtime
ghcr.io/data-alliance/gcube-ubuntu22.04-cuda13.0:runtime
ghcr.io/data-alliance/gcube-ubuntu24.04-cuda12.6:runtime
ghcr.io/data-alliance/gcube-ubuntu24.04-cuda12.8:runtime
ghcr.io/data-alliance/gcube-ubuntu24.04-cuda13.0:runtime
ghcr.io/data-alliance/gcube-ubuntu26.04-cuda13.5:runtime

# TensorFlow
ghcr.io/data-alliance/gcube-tensorflow-2.17-cuda12.8:runtime
```

**Docker Hub**

```
# PyTorch
gcubeai/gcube-pytorch-2.8-cuda12.6:runtime
gcubeai/gcube-pytorch-2.8-cuda12.8:runtime
gcubeai/gcube-pytorch-2.9-cuda12.6:runtime
gcubeai/gcube-pytorch-2.9-cuda12.8:runtime
gcubeai/gcube-pytorch-2.9-cuda13.0:runtime
gcubeai/gcube-pytorch-2.10-cuda12.6:runtime
gcubeai/gcube-pytorch-2.10-cuda12.8:runtime
gcubeai/gcube-pytorch-2.10-cuda13.0:runtime
gcubeai/gcube-pytorch-2.11-cuda12.6:runtime
gcubeai/gcube-pytorch-2.11-cuda12.8:runtime
gcubeai/gcube-pytorch-2.11-cuda13.0:runtime

# Ubuntu+CUDA
gcubeai/gcube-ubuntu22.04-cuda12.6:runtime
gcubeai/gcube-ubuntu22.04-cuda12.8:runtime
gcubeai/gcube-ubuntu22.04-cuda13.0:runtime
gcubeai/gcube-ubuntu24.04-cuda12.6:runtime
gcubeai/gcube-ubuntu24.04-cuda12.8:runtime
gcubeai/gcube-ubuntu24.04-cuda13.0:runtime
gcubeai/gcube-ubuntu26.04-cuda13.5:runtime

# TensorFlow
gcubeai/gcube-tensorflow-2.17-cuda12.8:runtime
```

```dockerfile
# Example: build an image with extra packages on top of a base image
FROM gcubeai/gcube-pytorch-2.11-cuda12.8:runtime
RUN pip install --no-cache-dir transformers
```

## Common settings

- System utilities: `git`, `curl`, `wget`, `vim`, `tmux`, `htop`
- Korean font: NanumGothic; locale: `en_US.UTF-8`
- Working directory: `/workspace`
- Cache paths: `HF_HOME=/workspace/.cache/huggingface`, `PIP_CACHE_DIR=/workspace/.cache/pip`

## Environment variables

All environment variables are optional. Set them only to use a private repository or to set the commit author.

| Variable | Default | Description |
|---|---|---|
| `GIT_CLONE_REPO` | (none) | Repository URL to clone into `/workspace` when the workload starts. Retries for up to 1 minute on failure, for nodes whose network comes up late |
| `GIT_USER_NAME` | (none) | Git commit author name |
| `GIT_USER_EMAIL` | (none) | Git commit author email |
| `GIT_TOKEN` | (none) | Git access token (PAT). Needed to clone/push private repositories |
| `GIT_HOST` | `github.com` | Git host. GitLab (`gitlab.com`) or an internal git server also works |
