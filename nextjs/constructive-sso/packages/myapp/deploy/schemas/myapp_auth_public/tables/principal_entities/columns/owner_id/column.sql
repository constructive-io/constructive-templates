-- Deploy: schemas/myapp_auth_public/tables/principal_entities/columns/owner_id/column
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principal_entities/table


ALTER TABLE myapp_auth_public.principal_entities 
  ADD COLUMN owner_id uuid;

