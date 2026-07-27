-- Deploy: schemas/myapp_auth_public/tables/principal_entities/columns/created_at/column
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principal_entities/table


ALTER TABLE myapp_auth_public.principal_entities 
  ADD COLUMN created_at timestamptz;

