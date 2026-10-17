# 1. 列举VPS

## 1.1 简单列举

```
cntb get instances
```

## 1.2 查看所有实例的详细硬件配置清单

```
cntb get instances -o json | jq '.[] | {instanceId, name, productId, vcpu: .cpuCores, ram: .ramMb, disk: .diskMb, region}'
```

# 2. 重启VPS

```
cntb restart instance "$TARGET_VPS_ID"
```


