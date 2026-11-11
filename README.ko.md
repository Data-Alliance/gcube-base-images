# gcube-base-images

[English](README.md) | **한국어**

gcube GPU 플랫폼용 기본 이미지 모음입니다. PyTorch·TensorFlow·CUDA 등 공식 환경에 gcube 공통 설정만 얹어, 실습 환경의 출발점으로 사용합니다.

모든 이미지는 같은 이름·태그로 두 레지스트리에 있습니다.

| 레지스트리 | 주소 형식 |
|---|---|
| GitHub Container Registry | `ghcr.io/data-alliance/<이미지>:<태그>` |
| Docker Hub | `gcubeai/<이미지>:<태그>` ([hub.docker.com/u/gcubeai](https://hub.docker.com/u/gcubeai)) |

## 이미지 라인업

### PyTorch — `gcube-pytorch-<torch>-cuda<cuda>`

PyTorch·CUDA·cuDNN·Python이 포함되어 있습니다. PyTorch 공식 이미지(`pytorch/pytorch`)를 기반으로 하며, Ubuntu 버전은 공식 이미지를 따릅니다(PyTorch 2.8·2.9: Ubuntu 22.04, 2.10·2.11: Ubuntu 24.04).

| PyTorch \ CUDA | 12.6 | 12.8 | 13.0 |
|---|:---:|:---:|:---:|
| 2.8 | O | O | — |
| 2.9 | O | O | O |
| 2.10 | O | O | O |
| 2.11 | O | O | O |

각 이미지마다 `:runtime` / `:devel` 두 태그 제공.

### Ubuntu+CUDA — `gcube-ubuntu<ubuntu>-cuda<cuda>`

CUDA만 포함되어 있어, 사용자가 원하는 프레임워크를 직접 설치하는 환경입니다. NVIDIA 공식 CUDA 이미지(`nvidia/cuda`)를 기반으로 하며, NVIDIA가 제공하는 Ubuntu·CUDA 조합만 만듭니다.

| Ubuntu \ CUDA | 12.6 | 12.8 | 13.0 | 13.5 |
|---|:---:|:---:|:---:|:---:|
| 22.04 | O | O | O | — |
| 24.04 | O | O | O | — |
| 26.04 | — | — | — | O |

각 이미지마다 `:runtime` / `:devel` 두 태그 제공.

Ubuntu 26.04는 NVIDIA가 CUDA 13.3 이상만 제공하여 CUDA 13.5 조합으로 제공합니다. 기본 Python은 3.14이며, CUDA 13.5를 지원하는 NVIDIA 드라이버(`nvidia-smi`의 CUDA 버전 13.5 이상)가 필요합니다.

### TensorFlow — `gcube-tensorflow-<tf>-cuda<cuda>`

TensorFlow·CUDA·cuDNN·Python이 포함되어 있습니다. `gcube-ubuntu24.04-cuda12.8` 위에 NVIDIA NGC TensorFlow 25.02 컨테이너의 TensorFlow를 옮겨 담은 이미지입니다(Ubuntu 24.04).

TensorFlow 공식 pip 패키지는 CUDA 12.5 기준이라 RTX 50 시리즈(Blackwell)를 지원하지 않아, CUDA 12.8로 빌드된 NGC 버전을 사용합니다. NGC TensorFlow 컨테이너는 25.02가 마지막 릴리스이므로 이 방식은 TensorFlow 2.17에 머뭅니다.

| TensorFlow | CUDA | 태그 |
|---|---|---|
| 2.17 | 12.8 | `:runtime` |

## 사용

gcube 워크로드에서 직접 사용하거나, 자체 Docker 이미지를 빌드할 때 `FROM`으로 사용합니다. 아래는 `:runtime` 태그 주소이며, `:devel` 태그도 같은 방식으로 사용할 수 있습니다.

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
# 예: 베이스 이미지 위에 패키지를 추가한 이미지 만들기
FROM gcubeai/gcube-pytorch-2.11-cuda12.8:runtime
RUN pip install --no-cache-dir transformers
```

## 공통 설정

- 시스템 유틸: `git`, `curl`, `wget`, `vim`, `tmux`, `htop`
- 한글 폰트: 나눔고딕(NanumGothic), 로케일: `en_US.UTF-8`
- 작업 디렉터리: `/workspace`
- 캐시 경로: `HF_HOME=/workspace/.cache/huggingface`, `PIP_CACHE_DIR=/workspace/.cache/pip`

## 환경변수

모든 환경변수는 선택 사항입니다. 비공개 저장소를 사용하거나 커밋 작성자를 지정하려는 경우에만 입력합니다.

| 변수 | 기본값 | 설명 |
|---|---|---|
| `GIT_CLONE_REPO` | (없음) | 워크로드 시작 시 `/workspace`에 자동 clone할 저장소 URL. 네트워크 연결이 늦게 열리는 노드를 위해 실패 시 최대 1분간 재시도 |
| `GIT_USER_NAME` | (없음) | git 커밋 작성자 이름 |
| `GIT_USER_EMAIL` | (없음) | git 커밋 작성자 이메일 |
| `GIT_TOKEN` | (없음) | git 인증 토큰(PAT). private 저장소 clone/push 시 필요 |
| `GIT_HOST` | `github.com` | git 호스트. GitLab(`gitlab.com`) 또는 사내 git 서버 주소도 가능 |