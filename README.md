# hse-iad-postgres-compose
Docker compose для поднятия простой PostgreSQL базы для тестирования своих запросов

## Подготовка
### Установка Docker
Для установки надо выполнить инструкции с [официального сайта](https://docs.docker.com/engine/install/), проще всего установить Docker Desktop, а не чисто ядро.

### Подготовка миграций
Если вам нужно, чтобы база запускалась с заранее выполненными запросами (например с инициализированными таблицами), нужно добавить файлы миграций в папку `migrations`. Файлы должны начинаться с номера (`001_`, `002_`), и заканчиваться на `.sql`, а сами запросы внутри файлов должны быть между комментариями `-- +goose Up` и `-- +goose Down`, подробнее [тут](https://github.com/pressly/goose).

Пример:
```sql
-- +goose Up

create table example (
    id serial primary key,
    name text not null
);

insert into example (name) values ('some_name');
-- +goose Down
```

## Запуск
Чтобы запустить БД, надо выполнить команду:
```bash
docker compose up --build
```
Либо, если у вас установлен make, можно запускать следующими более кастомными командами:
```bash
make run # запустит базу и мигратор, будет печатать логи
make run-background # запустит базу и мигратор, и вернет вас в консоль, вместо вечной печати логов
make rundb # запустит только базу, будет печатать логи
make rundb-background # запустит только базу, и вернет вас в консоль, вместо вечной печати логов
```

## Подключение
Если вы не меняли параметры в compose, БД будет доступна по следующему DSN: `postgresql://postgres:hsepassword@localhost:6431/postgres`, т.е. данные для подключения следующие:
- username: `postgres`
- password: `hsepassword`
- address: `localhost`
- port: `6431`
- database: `postgres`

## Частые ошибки
* `Bind for 0.0.0.0:6431 failed: port is already allocated`: у вас занят порт 6431, надо либо поменять в компоузе на какой то другой, и подключаться к БД по новому порту, либо освободить порт 6431
* `Cannot connect to the Docker daemon at ... Is the docker daemon running?`: скорее всего у вас не запущен докер, попробуйте переотркрыть приложение Docker Desktop, если устанавливали не через него, то см. [https://docs.docker.com/engine/daemon/troubleshoot/](https://docs.docker.com/engine/daemon/troubleshoot/)