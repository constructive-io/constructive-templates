-- Deploy: schemas/myapp_auth_public/tables/principals/columns/use_admin_owner/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principals/table
-- requires: schemas/myapp_auth_public/tables/principals/columns/use_admin_owner/column


ALTER TABLE myapp_auth_public.principals 
  ALTER COLUMN use_admin_owner SET DEFAULT true;

