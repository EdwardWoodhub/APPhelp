# 详细介绍

btrfsprogs（或称 btrfs-progs）是用于管理与维护 Linux Btrfs（B-tree 文件系统）官方核心用户态实用工具链的总称。它包含 btrfs 主命令以及 mkfs.btrfs、fsck.btrfs 等底层维护工具，充当系统管理员控制 Btrfs 特性的主要接口。该套件负责文件系统的格式化创建、在线扩缩容、多盘 RAID 布局平衡与在线转换（balance），并提供即时创建与管理写时复制（CoW）子卷及快照的核心能力。此外，它还内置数据流发送与接收（send/receive）以实现快照级增量备份，支持后台静默数据损坏自愈与校验（scrub）以及深入的磁盘健康检查与修复。
