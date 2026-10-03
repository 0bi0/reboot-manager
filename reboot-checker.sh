# reboot-checker.sh

CONFIG_FILE="/etc/reboot-manager/config"
LOG_FILE="/var/log/reboot-manager.log"
 
log() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" | tee -a "${LOG_FILE}"; }
 
[[ -f "${CONFIG_FILE}" ]] || { log "Config not found at ${CONFIG_FILE}. Exiting."; exit 1; }
source "${CONFIG_FILE}"
 
# Uptime in days
UPTIME_SECS=$(awk '{print int($1)}' /proc/uptime)
UPTIME_DAYS=$(( UPTIME_SECS / 86400 ))
 
log "Uptime: ${UPTIME_DAYS} day(s) | Threshold: ${REBOOT_INTERVAL_DAYS} day(s)"
 
if [[ "${UPTIME_DAYS}" -ge "${REBOOT_INTERVAL_DAYS}" ]]; then
    log "Updating packages and rebooting in 1 minute..."

    # Message before rebooting
    wall "NOTICE: Scheduled reboot triggered by reboot-manager (uptime ${UPTIME_DAYS}d >= ${REBOOT_INTERVAL_DAYS}d). Packages will be updated and the machine will reboot in 1 minute."
    if DEBIAN_FRONTEND=noninteractive apt-get update \
        && DEBIAN_FRONTEND=noninteractive apt-get -y upgrade; then
        log "Packages updated successfully."
    else
        log "Package update failed - rebooting anyway."
    fi
    shutdown -r +1 "Scheduled reboot by reboot-manager."
else
    log "No action needed (${UPTIME_DAYS}d uptime < ${REBOOT_INTERVAL_DAYS}d threshold)."
fi