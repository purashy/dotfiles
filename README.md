🏠 **Dotfiles**

My personal configuration files and desktop setup for Arch Linux.

This repository contains configuration for my shell, terminal, editor, Fastfetch, Kitty, Wallpapers, SMB credentials, and other personal settings.

🚀 **Installation**

⚠️ Warning: The installation commands below copy files directly into your home directory and modify /etc/fstab. Existing files with the same names may be overwritten. Back up your current configuration first if needed.

Clone the repository
```
git clone https://github.com/purashy/dotfiles.git
cd dotfiles
```

Run the following command from inside the repository:
```
cp -r .zshrc .zshenv .zsh_aliases .nanorc .nano .smbcreds .config Pictures ~/
```

This copies the configuration files and directories into their appropriate locations under `$HOME`.

🔐 **Change the SMB credentials**

`.smbcreds` contains credentials used to access the Samba shares, so it should only be readable by your user.

Set the permissions to 600:
```
chmod 600 ~/.smbcreds
```

Then change the content to your own credentials (`nano ~/.smbcreds`):
```
username=your-username
password=your-password
```

💾 **Configure `/etc/fstab`**

The following entries mount the personal storage drives and Samba shares.

Append them to `/etc/fstab`:
```
sudo tee -a /etc/fstab > /dev/null <<EOF

############
##Personal##
############

UUID=944dc8fe-c8a8-4835-b5f6-0b6eba7ca8b8 /mnt/games ext4 defaults 0 0
UUID=79e4d950-0701-42da-b925-5cafce81360c /mnt/localbackup ext4 defaults 0 0
UUID=a81dc590-74d2-4bbf-8f40-822583fa291a /mnt/ai ext4 defaults 0 0
UUID=845c1b3a-09d3-4dbd-912d-455db8daa411 /mnt/misc ext4 defaults 0 0

###########
## SAMBA ##
###########

//192.168.3.153/archive /mnt/archive cifs credentials=/home/$USER/.smbcreds,uid=1000,gid=1000,iocharset=utf8,_netdev,x-systemd.automount,nofail 0 0
//192.168.3.153/backup /mnt/backup cifs credentials=/home/$USER/.smbcreds,uid=1000,gid=1000,iocharset=utf8,_netdev,x-systemd.automount,nofail 0 0
//192.168.3.204/media /mnt/media cifs credentials=/home/$USER/.smbcreds,uid=1000,gid=1000,iocharset=utf8,_netdev,x-systemd.automount,nofail 0 0
EOF
```

Create the required mount points:
```
sudo mkdir -p /mnt/games /mnt/localbackup /mnt/ai /mnt/misc
sudo mkdir -p /mnt/archive /mnt/backup /mnt/media
```

Then reload systemd and test the configuration:
```
sudo systemctl daemon-reload
sudo mount -a
```

🖥️ **System**

These dotfiles are primarily intended for:

**OS:** Arch Linux  
**Shell:** Zsh  
**Editor:** Nano  
**Terminal:** Kitty  
**System information:** Fastfetch  
**Network shares:** Samba / CIFS
