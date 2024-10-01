# hse-iad-postgres-compose
Docker compose для поднятия простой PostgreSQL базы для тестирования своих запросов

## Подготовка
Если вам нужно, чтобы база запускалась с заранее выполненными запросами (например с инициализированными таблицами), нужно добавить файлы миграций в папку `migrations`. Файлы должны начинаться с номера (`001_`, `002_`), и заканчиваться на `.sql`, а сами запросы внутри файлов должны :
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
Чтобы запустить БД, надо выполнить команду
```bash
docker compose up --build
```

## Подключение
БД будет доступна по следующему DSN: `postgresql://postgres:hsepassword@localhost:6431/postgres`, т.е. данные для подключения следующие:
- username: `postgres`
- password: `hseuser`
- address: `localhost`
- port: `6431`
- database: `postgres`

## Частые ошибки
* `Bind for 0.0.0.0:6431 failed: port is already allocated`: у вас занят порт 6431, надо либо поменять в компоузе на какой то другой, и подключаться к БД по новому порту, либо освободить порт 6431