-- Deploy: schemas/myapp_auth_public/tables/principal_entities/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principal_entities/table


ALTER TABLE myapp_auth_public.principal_entities 
  DISABLE ROW LEVEL SECURITY;

