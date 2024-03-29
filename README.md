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

см. __stage__ конфигурацию

Сделано основное задание\
Сделано задание со *

Сделана часть задания с ** (provisioner) = работа приложения восстановлена не полностью - прилага не знает адрес БД, на БД необходимо править /etc/mongod.conf аргумент bindIp - база слушает localhost (не успел)

# HW8 ansible-1
С ансибл знаком.\
Формирование динамического инвентори до конца не разобрал.

Сделал автоматическое формаирование yml инвентори из терраформа по средствам `resource "local_file"` + `templatefile` (колхоз, но работает)

# HW9 ansible-2
В packer_db.yml пришлось использовать shell - установка локальных покетов, не стал вкладывать время в решение последовавших проблем.\
Пришлось добавить wait_for (аналог sleep в bash).

Сделано основное задание.

Ранее писал конфиг под наименоваение прилаги reddit (а не puma как в примерах) так и оставил.

# HW10 ansible-3
Выполнено основное задание

Задание с * не делал оно тянется с предыдущего где я его тоже не делал)) (не разбирался с динамическим инвентори)

В задание с ** предложен пакет для тестирования который более не существует (https://github.com/sethmlarson/trytravis) я так понимаю travis изменили правила игры и теперь надо подключать репы github через сайт travis,а сам travis хочет привязки карты за триал - чего мне делать не хочется
# HW11 ansible-4
### Vagrant
Выполнено основное задание.

Так как изначально использовал пользователя ubuntu не стал добавлять переменную `{{ deploy_user }}`

На конфигурации vargant в `v.memory = 512`, dbserver при попытке поставить базу)) = чуть кастомизировал настройки vm

box надо скачать на локальную машину и сказать vagrant где он (напрямую скачивание не проходит 401)

Задание `*` выполнено\
Добавлениe в Vargantfile extra_vars\
добавить hash через `ansible.groups` не выйдет - не читается из инвентори - лучшей практикой на сайте указано добавление переменных в group_vars или в самой роли - но в задаче сказано через Vargantfile

```
ansible.extra_vars = {
    'nginx_sites' => { 'default' => ['listen 80','server_name "reddit"','location / {proxy_pass http://127.0.0.1:9292;}'] }
}
```

### Molecule и тестирование
Выполнено основное задание.

Используется pipenv для окружения\
включение окружения `pipenv shell`

Задание со `*` не выполнено.

### DEPRECATED - места где нужен "напильник" и гуглёж)
список не полный - в какойто момент понял что нужно записывать
```
molecule init scenario --scenario-name default -r db -d vagrant
```
не поддерживает аргумент `--scenario-name`

в `ansible/requirements.txt` необходимо так же добавить `molecule-vagrant` иначе `-d vagrant` не сработает (vargant не примется как драйвер), после можно выполнить
```
molecule init scenario -d vagrant -r db default
```

В `molecule.yml` необходимо указать
```
verifier:
  name: testinfra
```
по умолчанию стоит ansible и тест запускается playbook'ом `verify.yml`
```
- name: Verify
  hosts: all
  gather_facts: false
  tasks:
  - name: Example assertion
    ansible.builtin.assert:
      that: true
```
# HW9 gitlab-ci-1
Выполнено основное задание.

Добавлен интеграция Slack
https://devops-team-otus.slack.com/archives/C03LTHW838W
