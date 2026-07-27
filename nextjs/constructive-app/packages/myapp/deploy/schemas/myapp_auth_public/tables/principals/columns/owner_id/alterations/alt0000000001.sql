-- Deploy: schemas/myapp_auth_public/tables/principals/columns/owner_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principals/table
-- requires: schemas/myapp_auth_public/tables/principals/columns/owner_id/column


ALTER TABLE myapp_auth_public.principals 
  ALTER COLUMN owner_id SET NOT NULL;

