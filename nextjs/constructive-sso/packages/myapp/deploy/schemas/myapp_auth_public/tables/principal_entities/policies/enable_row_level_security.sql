-- Deploy: schemas/myapp_auth_public/tables/principal_entities/policies/enable_row_level_security
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principal_entities/table


ALTER TABLE myapp_auth_public.principal_entities 
  ENABLE ROW LEVEL SECURITY;

