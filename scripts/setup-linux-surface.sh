sudo dnf config-manager \
    addrepo --from-repofile=https://pkg.surfacelinux.com/fedora/linux-surface.repo
sudo dnf install --allowerasing kernel-surface iptsd libwacom-surface -y
sudo dnf install surface-secureboot -y
sudo systemctl enable --now linux-surface-default-watchdog.path
sudo linux-surface-default-watchdog.py

# -- Termal settings
sudo dnf install thermald
# Stop the service while we configure it
sudo systemctl stop thermald
sudo mkdir -p /etc/thermald/
sudo cp ./thermal-conf.xml /etc/thermald/

sudo dnf install -y surface-control
sudo surface profile set performance


