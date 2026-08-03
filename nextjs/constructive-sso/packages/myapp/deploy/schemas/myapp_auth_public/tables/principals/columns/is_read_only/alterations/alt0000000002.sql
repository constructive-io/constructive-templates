-- Deploy: schemas/myapp_auth_public/tables/principals/columns/is_read_only/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principals/table
-- requires: schemas/myapp_auth_public/tables/principals/columns/is_read_only/column


ALTER TABLE myapp_auth_public.principals 
  ALTER COLUMN is_read_only SET DEFAULT false;

