# install vs code
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
sudo dnf update -y
sudo dnf install code 

# setup geforce rtx 3080
sudo dnf install epel-release 
sudo dnf upgrade
# sudo reboot
sudo dnf config-manager --add-repo http://developer.download.nvidia.com/compute/cuda/repos/rhel9/$(uname -i)/cuda-rhel9.repo
sudo dnf install kernel-headers-$(uname -r) kernel-devel-$(uname -r) tar bzip2 make automake gcc gcc-c++ pciutils elfutils-libelf-devel libglvnd-opengl libglvnd-glx libglvnd-devel acpid pkgconfig dkms
sudo dnf module install nvidia-driver:latest-dkms
echo "blacklist nouveau" | sudo tee /etc/modprobe.d/blacklist-nouveau.conf
echo 'omit_drivers+=" nouveau "' | sudo tee /etc/dracut.conf.d/blacklist-nouveau.conf
sudo dracut --regenerate-all --force
sudo depmod -a
sudo mokutil --import /var/lib/dkms/mok.pub

# install tkinter
sudo dnf update -y
sudo dnf install -y python3-tkinter
python3 -c "import tkinter; print(tkinter.Tk().title())"

# add ntfs support
sudo dnf install ntfs-3g
lsmod | grep ntfs

# enable clip for menu
sudo dnf install xclip

# enable video codecs for firefox
sudo dnf install --nogpgcheck https://mirrors.rpmfusion.org/free/el/rpmfusion-free-release-9.noarch.rpm
sudo dnf install --nogpgcheck https://mirrors.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-9.noarch.rpm
sudo dnf config-manager --enable crb
sudo dnf groupupdate core
sudo dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
sudo dnf groupupdate sound-and-video

# install git
sudo dnf install git
git config --global user.name "Micael"
git config --global user.email "micaelsjogren.750129@gmail.com"

sudo reboot
