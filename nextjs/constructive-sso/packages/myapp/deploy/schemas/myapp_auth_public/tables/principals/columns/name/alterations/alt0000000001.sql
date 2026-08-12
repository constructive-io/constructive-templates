-- Deploy: schemas/myapp_auth_public/tables/principals/columns/name/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principals/table
-- requires: schemas/myapp_auth_public/tables/principals/columns/name/column


ALTER TABLE myapp_auth_public.principals 
  ALTER COLUMN name SET NOT NULL;

