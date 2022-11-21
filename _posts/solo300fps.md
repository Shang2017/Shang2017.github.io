#  About Solo300 FPS
## Flow
1. App send "get vfs" cmd to device when start record.
   command as below:
       "VFPS"  ; get vfs
       "SSID"
       "PSWD"
       "CHAN"...
2. Device send back information:
   TRUE:  PHVFSOKxx;   xx is such as 25/30/60
   FALSE: PHVFSER
   
3. VFS can not change when record.

50 48 56 46 50 53 00 00 00 00 00 00 00 00 00 00 00 00 00   D7 01 00 00


                                                                                                                                                                                                                         #