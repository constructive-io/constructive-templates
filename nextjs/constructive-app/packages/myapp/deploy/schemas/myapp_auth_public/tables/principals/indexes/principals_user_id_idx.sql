-- Deploy: schemas/myapp_auth_public/tables/principals/indexes/principals_user_id_idx
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principals/table
-- requires: schemas/myapp_auth_public/tables/principals/columns/user_id/column


CREATE INDEX principals_user_id_idx ON myapp_auth_public.principals USING BTREE ( user_id );

