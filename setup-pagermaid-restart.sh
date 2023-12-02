#!/bin/bash

# 创建 pagermaid-restart.service 文件
cat <<EOF > /etc/systemd/system/pagermaid-restart.service
[Unit]
Description=Restart Pagermaid Service at 5 AM

[Service]
Type=oneshot
ExecStart=/bin/systemctl restart pagermaid.service
EOF

# 创建 pagermaid-restart.timer 文件
cat <<EOF > /etc/systemd/system/pagermaid-restart.timer
[Unit]
Description=Restart Pagermaid Service Daily at 5 AM

[Timer]
OnCalendar=*-*-* 05:00:00
Persistent=true

[Install]
WantedBy=timers.target
EOF

# 重新加载 systemd 配置
systemctl daemon-reload

# 启动并启用定时器
systemctl enable pagermaid-restart.timer
systemctl start pagermaid-restart.timer

echo "Pagermaid service restart setup complete."
