`regctl` 是由 **Regclient** 项目开发的高性能容器镜像管理 CLI 工具。它的最大特点是**无需本地安装 Docker/Podman 守护进程**，直接通过 OCI / Docker Registry HTTP API 操作远程镜像仓库，执行复制、检查、删除、导出等操作，速度快且占用资源极少。

---

### 一、 安装配置

#### 1. 安装方式

* **Linux / macOS (预编译二进制):**
```bash
# 下载对应架构的可执行文件（以 Linux amd64 为例）
curl -L https://github.com/regclient/regclient/releases/latest/download/regctl-linux-amd64 -o regctl
chmod +x regctl
sudo mv regctl /usr/local/bin/

```


* **Homebrew (macOS / Linux):**
```bash
brew install regclient

```


* **作为容器运行 (无需本地安装):**
```bash
alias regctl='docker run -i --rm -v ~/.regctl:/home/appuser/.regctl ghcr.io/regclient/regctl:latest'

```



#### 2. 登录认证

`regctl` 会默认读取本地 `~/.docker/config.json` 的凭证，也可以通过内置命令登录：

```bash
# 登录 Docker Hub (省略域名时默认指向 docker.io)
regctl registry login

# 登录私有仓库或第三方镜像仓库
regctl registry login registry.example.com -u <username> -p <password>

```

---

### 二、 常用核心命令

#### 1. 查看与检查镜像 (`image inspect` / `manifest`)

在拉取镜像前快速查看镜像架构、体积或配置信息：

```bash
# 查看镜像详细元数据 (配置信息、构建历史等)
regctl image inspect alpine:latest

# 查看镜像清单 (多架构镜像的平台列表与 Digest)
regctl manifest get alpine:latest

```

#### 2. 仓库间快速同步/复制镜像 (`image copy`)

`regctl` 复制镜像时**无需本地拉取解压再推送**，如果两个仓库支持跨仓库挂载或直接流式传输，效率极高：

```bash
# 复制镜像（包含所有支持的平台架构）
regctl image copy docker.io/library/nginx:latest registry.example.com/mirror/nginx:latest

# 仅复制特定平台架构（如 linux/amd64）
regctl image copy --platform linux/amd64 alpine:latest myregistry.local/alpine:latest

# 同步多架构镜像所有层及清单列表
regctl image copy --digest-tags src.example.com/app:v1 dst.example.com/app:v1

```

#### 3. 标签管理 (`tag`)

快速添加别名、重命名或列出可用标签：

```bash
# 列出仓库中的镜像标签
regctl tag ls registry.example.com/my-app

# 为已存在的镜像添加新标签（不下载镜像内容）
regctl image copy registry.example.com/my-app:v1 registry.example.com/my-app:latest

# 删除指定标签
regctl tag rm registry.example.com/my-app:test-tag

```

#### 4. 删除远程镜像 (`image delete`)

根据 Digest 物理删除远程仓库中的镜像（需目标 Registry 开放写权限与支持删除）：

```bash
# 通过 digest 删除镜像
regctl image delete registry.example.com/my-app@sha256:abcd...

```

#### 5. 镜像打包与导出/导入 (`image export` / `image import`)

直接将远程镜像打包为 OCI/Docker 兼容的 tar 包，或将 tar 包推送到仓库：

```bash
# 直接从远程仓库下载并保存为 tar 包
regctl image export alpine:latest alpine.tar

# 将本地 tar 包直接推送到远程仓库
regctl image import registry.example.com/alpine:latest alpine.tar

```

---

### 三、 典型应用场景

* **CI/CD 流水线镜像同步：** 构建完成后快速将镜像推送到国内外多个镜像分发节点，无需启动额外的 Docker in Docker (DinD) 环境。
* **低开销检查：** 在无特权容器或受限主机上快速验证镜像是否存在某个 Tag 或某架构的构建。
* **私网离线搬迁：** 使用 `regctl image export` / `import` 快速打包和恢复容器镜像。

