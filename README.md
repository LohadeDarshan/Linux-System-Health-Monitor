### Description:

Create a bash script that monitors system performance and logs key metrics such as CPU usage, memory usage, disk usage, and running processes. Sends email or Slack alert if thresholds are crossed.

### 📂 Features:

- Collect system stats (CPU, RAM, disk)
- Alert if disk > 90%, CPU > 80%, RAM > 85%
- Generate daily logs
- Email or webhook notification
- Can be added to `cron` for automation

### 🧱 Stack:

- Bash
- `cron`
- `mail` / `sendmail` or `curl` for API alert

- ### Sample Output:

```
[2025-04-11 10:00:00]
CPU Usage: 75%
Memory Usage: 63%
Disk Usage: 89%
Status: OK


## 🧠 Tips for Learning

- Use `man command` to read manual
- Practice on a Linux VM or WSL
- Read other people’s scripts on GitHub
- Set small goals and build up

