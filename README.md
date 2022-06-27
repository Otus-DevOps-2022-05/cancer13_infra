# cancer13_infra
Kuznetsov Ivan's Infra repo

# HW3
`oneline`\
```
ssh -J appuser@51.250.92.254 appuser@someinternalhost.ru-central1.internal
# or
ssh -J appuser@51.250.92.254 appuser@10.128.0.15
```

`make 'ssh someinternalhost'`\
~~~
cat .ssh/config 
Host bastion
    HostName 51.250.92.254
    User appuser
    IdentityFile ~/.ssh/appuser
    IdentitiesOnly yes
    ForwardAgent yes

Host someinternalhost
    HostName someinternalhost.ru-central1.internal
    ProxyJump bastion
    User appuser
    IdentityFile ~/.ssh/appuser
    IdentitiesOnly yes
~~~

`vpn web interface with ssl`\
https://51.250.6.155.sslip.io

```
bastion_IP = 51.250.6.155
someinternalhost_IP = 10.128.0.15
```
