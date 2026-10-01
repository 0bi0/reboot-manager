# reboot-manager

Automatically reboot a Debian/Ubuntu machine when it has been up for a set number of days.

A one-shot installer writes a daily cron job that checks uptime once a day and, if the
threshold is reached, announces a reboot over `wall` and schedules it one minute later.

## Requirements

- Debian/Ubuntu (uses `/etc/cron.d`, `shutdown`, `wall`)
- `bash`, `cron`, `apt`
- root privileges

## Install

```bash
git clone https://github.com/0bi0/reboot-manager.git
cd reboot-manager
sudo ./reboot-manager.sh set restart X
```

Replace `X` with the number of days of uptime you want to tolerate. Minimum is `1`.

## Usage

```
sudo ./reboot-manager.sh set restart <X_days>
```

Master command, as-is; sets reboot interval.


## Uninstall

Remove the cron entry first so it stops firing, then delete the rest:

```bash
sudo rm /etc/cron.d/reboot-manager /usr/local/bin/reboot-checker
sudo rm -r /etc/reboot-manager
sudo rm /var/log/reboot-manager.log   # optional, keeps your history
```