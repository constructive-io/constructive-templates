-- Deploy: schemas/myapp_auth_public/tables/principal_entities/columns/created_at/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principal_entities/table
-- requires: schemas/myapp_auth_public/tables/principal_entities/columns/created_at/column


ALTER TABLE myapp_auth_public.principal_entities 
  ALTER COLUMN created_at SET DEFAULT now();

