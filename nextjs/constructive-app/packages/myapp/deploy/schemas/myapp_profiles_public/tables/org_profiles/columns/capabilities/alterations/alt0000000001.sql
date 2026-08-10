-- Deploy: schemas/myapp_profiles_public/tables/org_profiles/columns/capabilities/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_profiles_public/schema
-- requires: schemas/myapp_profiles_public/tables/org_profiles/table
-- requires: schemas/myapp_profiles_public/tables/org_profiles/columns/capabilities/column


ALTER TABLE myapp_profiles_public.org_profiles 
  ALTER COLUMN capabilities SET NOT NULL;

