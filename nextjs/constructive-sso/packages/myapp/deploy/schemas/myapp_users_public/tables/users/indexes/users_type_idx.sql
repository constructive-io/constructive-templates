-- Deploy: schemas/myapp_users_public/tables/users/indexes/users_type_idx
-- made with <3 @ constructive.io

-- requires: schemas/myapp_users_public/schema
-- requires: schemas/myapp_users_public/tables/users/table
-- requires: schemas/myapp_users_public/tables/users/columns/type/column


CREATE INDEX users_type_idx ON myapp_users_public.users USING BTREE ( type );

