-- Deploy: schemas/myapp_auth_public/tables/principal_entities/columns/id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principal_entities/table
-- requires: schemas/myapp_auth_public/tables/principal_entities/columns/id/column


ALTER TABLE myapp_auth_public.principal_entities 
  ALTER COLUMN id SET NOT NULL;

