-- Deploy: schemas/myapp_auth_public/tables/principals/indexes/principals_updated_at_idx
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principals/table
-- requires: schemas/myapp_auth_public/tables/principals/columns/updated_at/column


CREATE INDEX principals_updated_at_idx ON myapp_auth_public.principals ( updated_at );

