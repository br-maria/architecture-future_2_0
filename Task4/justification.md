# Task4 — justification.md (Yandex Cloud)

## Что создаёт Terraform и что остаётся ручным

### Terraform (IaC)
- **VPC**: сеть и 3 подсети (public + private A/B в разных зонах).
- **NAT**: `yandex_vpc_gateway` (shared egress) + `yandex_vpc_route_table` для приватных подсетей.
- **Security Groups**:
  - bastion: SSH 22 только из `allowed_ssh_cidr`;
  - private: SSH 22 только из SG bastion, HTTP/HTTPS только внутри VPC.
- **Compute (VM)**:
  - `bastion` в public subnet с `nat=true` (публичный IP);
  - `data_platform` в private subnet A без публичного IP;
  - `bi_portal` в private subnet B без публичного IP.
- **Storage**:
  - boot disks (network-ssd);
  - дополнительные data-disks для private VM.

### Manual/Bootstrap (одноразово)
- Создать/выбрать **Cloud и Folder**.
- Подготовить **Service Account** и роли (или использовать OAuth token).
- Сгенерировать **SSH ключ** локально (публичный ключ кладём в `ssh_public_key`).
- (Опционально) настроить remote state (Object Storage/TF Cloud) для командной работы.

---

## Почему такие параметры

### VM sizing (dev стенд)
- Bastion: **2 vCPU / 2 GB RAM**, `core_fraction=20` — минимальный jump-host, без тяжёлых сервисов.
- Private VM: **2 vCPU / 4 GB RAM**, `core_fraction=20` — достаточно для базовых агентов/прокси/легких сервисов.
- В проде sizing делается по профилю нагрузки (CPU/RAM/IO) и тестам.

### Диски
- `network-ssd` — адекватный баланс latency/цены для учебного стенда.
- Separate data disks:
  - DP: 100 GiB — кэш пайплайнов/логи/буферы;
  - BI: 50 GiB — логи/кэш/артефакты портала.
- В реальном решении для данных обычно используют managed storage/DB/DWH, а не диски ВМ.

### NAT и безопасность
- Private VM не имеют публичных IP → снижает поверхность атаки.
- NAT Gateway даёт исходящий доступ для обновлений и внешних API.
- Вход в private tier — только через bastion, что поддерживает принцип **least privilege**.

---

## Зачем IaC (декларативность) бизнесу
- **Воспроизводимость**: окружения (dev/stage/prod) создаются одинаково и быстро.
- **Скорость изменений**: инфраструктура меняется через PR и review (прозрачный diff).
- **Снижение ошибок**: меньше ручных действий → меньше «снежинок» и дрейфа конфигураций.
- **Масштабирование**: добавление доменов/сервисов — добавление ресурсов/модулей и переменных.

---

## Ограничения учебного стенда

В папке `b1gqbqp6rfn89j72vjet` действует организационное ограничение, запрещающее операции создания Compute Instance (VM) на уровне folder/organization. Это подтверждается тем, что команда `yc compute instance create ...` возвращает `PermissionDenied: Permission denied to resource-manager.folder ...` даже при назначенных ролях `editor`, `compute.admin`, `vpc.admin` сервисному аккаунту.

Поэтому в рамках учебного задания конфигурация Terraform фиксирует инфраструктурный каркас (VPC network и подсети), который является обязательной основой для дальнейшего развёртывания сервисов данных. При снятии ограничения или предоставлении другого folder/проекта блоки Compute/Disks/Security Groups/NAT могут быть включены без изменения сетевого слоя.
