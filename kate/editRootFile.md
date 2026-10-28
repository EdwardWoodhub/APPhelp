### Kate 编辑 root 文件的验证流程总结

整个流程的核心原则是：**永远不要使用 `sudo kate`，始终以普通用户启动 Kate，由底层 Polkit 接管提权。**

---

#### 阶段一：准备测试文件（模拟真实配置文件）

Linux 系统中大多数核心配置文件（如 `/etc/fstab`、`/etc/hosts`）默认状态为 **“普通用户可读，仅 root 可写”**（`644` 权限）：

```bash
# 1. 创建属于 root 的测试文件
echo "Initial config line" | sudo tee /tmp/root_test.txt

# 2. 设置权限为 644（所有人可读，仅 root 可写）
sudo chmod 644 /tmp/root_test.txt

# 3. 确认权限为 -rw-r--r--
ls -l /tmp/root_test.txt

```

---

#### 阶段二：场景验证与操作

根据文件自身的读取权限，分为两种工作方式：

| 测试场景 | 目标文件权限 | 打开命令 | 触发提权时机 | 底层机制 |
| --- | --- | --- | --- | --- |
| **常规配置文件**（最常见） | `644`（普通用户可读） | `kate /tmp/root_test.txt` | 按下 **Ctrl + S** 保存时弹窗输入密码 | KAuth / KTextEditor 原生提权 |
| **机密限制文件**（如 shadow） | `600`（普通用户完全不可读） | `kate admin:///tmp/root_test.txt` | **刚打开文件时**立即弹窗输入密码 | `kio-admin` 虚拟文件系统协议 |

---

#### 阶段三：结果判定与排查

1. **验证成功标志**：
* 在界面修改文本后按 `Ctrl + S`，屏幕**成功弹出 Polkit 图形密码框**；
* 输入当前用户的 sudo 密码后文件保存成功，终端执行 `sudo cat /tmp/root_test.txt` 能看到修改内容。


2. **验证失败排查**：
* **报错 `could not be loaded / Check read access**`：文件设为了 `600` 且未加 `admin:///` 前缀。改用 `chmod 644` 或通过 `kate admin:///...` 打开。
* **保存时直接报 `Permission Denied` 且未弹窗**：当前 labwc 环境未启动 Polkit 认证代理（后台缺少 `polkit-kde-authentication-agent-1` 等进程）。
* **提示未知协议 `admin://**`：系统未安装 `kio-admin` 扩展包。



---

#### 阶段四：测试完毕清理

```bash
sudo rm /tmp/root_test.txt

```
