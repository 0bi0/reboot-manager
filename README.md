# reboot-manager

> [!WARNING]
> By default, full system updates are enabled. To opt-out, run `sudo /usr/local/bin/reboot-manager sysupdate optout`.

---

Automatically reboots a Debian/Ubuntu machine when it has been up for a set number of days and updates it if the feature has been opted in for.

A one-shot installer writes a daily cron job that checks uptime once a day and, if thethreshold is reached, announces a reboot over `wall` and schedules it one minute later.


## Requirements

- Debian-based server
- Git


## Install

```bash
git clone https://github.com/0bi0/reboot-manager.git
cd reboot-manager
sudo /usr/local/bin/reboot-manager set restart <X_days>
```

Replace `X` with the number of days of uptime you want to tolerate. Minimum is `1`.


## Usage

```
sudo /usr/local/bin/reboot-manager set restart <X_days>
sudo /usr/local/bin/reboot-manager sysupdate <optin|optout>
```


## Uninstall

Remove the cron entry first so it stops firing, then delete the rest:

```bash
sudo rm /etc/cron.d/reboot-manager /usr/local/bin/reboot-checker
sudo rm -r /etc/reboot-manager
sudo rm /var/log/reboot-manager.log  # optional, keeps your history
```