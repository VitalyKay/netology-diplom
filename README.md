Host vitalykay-netology-diplom.tk
  User ubuntu
  IdentityFile ~/.ssh/id_ed25519

Host 51.250.69.94
  User ubuntu
  IdentityFile ~/.ssh/id_ed25519

Host 192.168.200.*
  User centos
  ProxyJump vitalykay-netology-diplom.tk
  IdentityFile ~/.ssh/id_ed25519
