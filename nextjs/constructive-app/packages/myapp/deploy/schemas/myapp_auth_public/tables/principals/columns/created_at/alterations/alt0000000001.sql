-- Deploy: schemas/myapp_auth_public/tables/principals/columns/created_at/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principals/table
-- requires: schemas/myapp_auth_public/tables/principals/columns/created_at/column


ALTER TABLE myapp_auth_public.principals 
  ALTER COLUMN created_at SET DEFAULT now();

