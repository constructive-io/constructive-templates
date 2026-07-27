-- Deploy: schemas/myapp_auth_public/tables/principal_entities/columns/principal_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principal_entities/table
-- requires: schemas/myapp_auth_public/tables/principal_entities/columns/principal_id/column


ALTER TABLE myapp_auth_public.principal_entities 
  ALTER COLUMN principal_id SET NOT NULL;

