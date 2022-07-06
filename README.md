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
# HW4
```
testapp_IP = 51.250.67.131
testapp_port = 9292
```
# HW5 packer
Правильна дока Packer'а https://www.packer.io/docs/templates/legacy_json_templates/user-variables

Подготовка хоста вынесена в pre_host.sh
Доп задание выполнено
# HW6 terraform-1
Terraform v1.2.4
В задания со звёздочками не вышло вывести внешний балансироващика, получаю ошибку Error: Cannot index a set value (найти решения не вышло)

Добавил вторую прилагу руками, очень много ручного труда повышается вероятность ошибки,сложно становитс поддерживать, не хватает повторяемости (как с подами в кубере - сказал сколько он сделал)

