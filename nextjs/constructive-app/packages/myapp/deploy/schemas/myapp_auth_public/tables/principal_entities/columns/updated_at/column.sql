-- Deploy: schemas/myapp_auth_public/tables/principal_entities/columns/updated_at/column
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principal_entities/table


ALTER TABLE myapp_auth_public.principal_entities 
  ADD COLUMN updated_at timestamptz;

