# LinuxFromScratch
Documentation Guide (Read Carefully)

# Before executing run.sh (Follow)
1. Download Ubuntu-Server ISO from https://ubuntu.com/download/server
2. Create VM with following specifications (for optimal performance):
   - `50 GB` min. VHDD (Preferred: 60GB)
   - `2 core` CPU
   - `4 GB` RAM
    
3. Start VM and select `Try and Install Ubuntu` while booting
4. Select appropriate options while installing
5. Create MANUAL Partitions with following specifications:
   - `ext4 (EFI)` - `1 GB` - Mount: `/boot/efi`
   - `Boot` - `1 GB` - Mount: `/boot`
   - `ext4` - `19 GB` - Mount: `/`
   - `ext4` - `30 GB`  / `40 GB` (Preferred) - Mount: `/mnt/lfs`
6. Once Complete, you can run:
```sh
sudo /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/anantkaul/LinuxFromScratch/main/run.sh)"
```
  > `OR` Download and run at your convenience
```sh
git clone https://github.com/anantkaul/LinuxFromScratch
cd LinuxFromScratch
chmod +x run.sh
sudo ./run.sh
```
 
