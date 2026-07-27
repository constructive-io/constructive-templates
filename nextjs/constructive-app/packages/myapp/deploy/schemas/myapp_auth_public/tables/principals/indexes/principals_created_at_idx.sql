-- Deploy: schemas/myapp_auth_public/tables/principals/indexes/principals_created_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principals/table
-- requires: schemas/myapp_auth_public/tables/principals/columns/created_at/column


CREATE INDEX principals_created_at_idx ON myapp_auth_public.principals ( created_at );

