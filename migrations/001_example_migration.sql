-- +goose Up
create table example (
    id serial primary key,
    name text not null
);

-- +goose Down
