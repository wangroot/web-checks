# Web-Check 本地部署

Web-Check 是用于分析网站公开信息的开源工具，原项目由 [Alicia Sykes / Lissy93](https://github.com/lissy93/web-check) 维护，沿用 [MIT 许可证](LICENSE)。完整项目介绍见 [上游 README](.github/README.md)。

此分支补充 Windows + Docker Desktop 的本地部署配置、启停脚本和中文使用说明。应用使用官方 `lissy93/web-check` 镜像，默认只监听本机 `127.0.0.1:3000`。

## 快速启动

前提：已安装 Docker Desktop，并启用 Linux 容器引擎。

```powershell
git clone --branch local-deploy/windows-docker https://github.com/wangroot/web-checks.git web-check
cd web-check
```

1. 下载或克隆本分支，将项目放入可写目录。
2. 双击 [start-local.bat](start-local.bat)，等待镜像下载和容器启动。
3. 打开 [http://127.0.0.1:3000](http://127.0.0.1:3000)。
4. 在输入框填写待分析网站的域名或完整 URL，启动分析。

使用有权限分析的网站作为目标。各项检查依赖目标可达性及外部服务，部分检查需自行配置 API Key。

## 文档与脚本

| 文件 | 用途 |
| --- | --- |
| [使用说明.md](使用说明.md) | 使用流程、可选 API 配置、维护与故障排查 |
| [docker-compose.local.yml](docker-compose.local.yml) | 仅绑定本机端口的部署配置 |
| [start-local.bat](start-local.bat) | 启动 Docker Desktop 和 Web-Check |
| [stop-local.bat](stop-local.bat) | 停止 Web-Check |
| [status-local.bat](status-local.bat) | 查看容器状态与最近日志 |
| [.env.sample](.env.sample) | 上游提供的可选配置示例 |

## PowerShell 启停

```powershell
cd <项目目录>
$env:DOCKER_HOST = 'npipe:////./pipe/dockerDesktopLinuxEngine'
$env:DOCKER_CONFIG = "$PWD\.docker-local"
docker compose -f docker-compose.local.yml up -d
docker compose -f docker-compose.local.yml ps
docker compose -f docker-compose.local.yml logs --tail=50
docker compose -f docker-compose.local.yml stop
```

Linux / macOS 直接使用上述 `docker compose` 命令即可，省略两个 Windows 专用环境变量。

## Git 分支

本地部署分支：`local-deploy/windows-docker`。`upstream` 用于追踪原项目，`origin` 指向个人 Fork；不需要改动上游默认分支。

`.env`、Docker 客户端状态及本机验证记录均已排除在 Git 提交之外。
