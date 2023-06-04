# sf_diplom_work
1. Terraform:
- Для корректного развертывания инфраструктуры в Яндекс Облаке необходимо заполнить файлы variables.tf и /modules/srv/modules_srv_variables.tf своими данными
- В файле /modules/srv/cloud_config.yaml добавить свой publickey и в папку modules/.ssh добавить свои ключи
- С помощью provisioning происходит первичная настройка вм srv для дальнейшего развертывания по средства Gitlab: 
    - пользователь gitlab-runner добавляется в группу docker
    - устанавливается yc и подключается к облаку
    - устанавливается и регистрируется gitlab-runner
    - устанавливается и подключается к кластеру kubectl
    - устанавливается helm
 2. Gitlab
 -  Из Dockerfile собирается image и пушится в gitlab registry проекта
 -  Через helm чарты разворачивает в кластере Kubernetes:
    - приложение app
    - promtail для отправки логов кластера в loki
    - prometheus внутри кластера, который пересылает данные в prometheus на вм srv
 - Через docker-compose на вм srv поднимается prometheus стэк + Grafana + Loki
