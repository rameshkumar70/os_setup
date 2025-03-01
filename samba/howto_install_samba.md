sudo apt install samba nautilus-share
systemctl status smbd --no-pager  # see current samba status
sudo systemctl enable --now smbd  # enable persistently samba and and also start it now
sudo usermod -aG sambashare $USER # add current user ($USER) into samba group to be able to share out $USER's folders
sudo smbpasswd -a $USER # set password for others to access folders of $USER
sudo systemctl restart smbd   # restart samba to apply changes		
