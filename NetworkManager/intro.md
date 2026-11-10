
# 详细介绍

NetworkManager 是 Linux 生态中最主流、功能最完备的开源网络配置与守护进程套件。它旨在实现网络连接的自动化与动态管理，能够无缝处理以太网、Wi-Fi、移动宽带（WWAN）、蓝牙、VPN 以及网桥、VLAN 等复杂虚拟网络接口的自动发现与切换。NetworkManager 采用客户端/服务端架构，后台常驻 NetworkManager 守护进程，对外通过 D-Bus 接口通信，并提供丰富的控制端工具：包括用于终端脚本与自动化控制的命令行工具 nmcli、基于文本交互界面的 nmtui，以及适配 GNOME、KDE 等桌面环境的图形托盘组件（如 nm-applet），是现代 Linux 桌面及多数服务器发行版默认的网络管理标准方案。

源于各发行版的打包规范差异，openSUSE 的 RPM 系统严格区分大小写，保留了软件上游原始的大写命名（如 `NetworkManager`）；而 Ubuntu 或 Arch 的官方规范严禁包名包含大写字母，均强制改为了全小写（如 `network-manager`）。
