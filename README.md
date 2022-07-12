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

Про добавление конфигурации с более чем одного сервера прилажений руками (без count):
очень много ручного труда = повышается вероятность ошибки,сложно поддерживать, не хватает автоматизированной повторяемости кода

Выполнено задание со звёздами (2 инстанса через count), однако не найдено решение как добавить в yandex_lb_target_group возможность скелить target, не прибегая к шаблонизации и использованию таргетов инстансов (instance_group) - что явно не рассматривалось в рамкох этой домашней работы.
# HW7 terraform-2
Terraform v1.2.4

Сделано основное задание
