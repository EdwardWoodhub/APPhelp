# 详细介绍

adwaita-cursor-theme 是 GNOME 桌面环境官方设计语言（Adwaita）的鼠标指针（光标）主题资源包。它包含系统在不同交互场景下所显示的光标图像，例如标准箭头、文本选择工字光标、手型链接光标、等待加载动画以及窗口缩放光标等。在 Fedora 等遵循细粒度打包规范的发行版中，它常从完整图标或主题包（如 adwaita-icon-theme 或 gnome-themes-extra）中剥离为独立软件包，以零额外 GUI 库依赖的形式作为 X11 与 Wayland 图形栈全系统的通用保底（Fallback）默认指针；而在 NixOS 等忠于上游源码结构的发行版中，则直接合并包含在 adwaita-icon-theme 当中，安装后统一存放于 /usr/share/icons/Adwaita/cursors/ 等遵循 XDG 标准的路径下供各类桌面与窗口管理器调用。
