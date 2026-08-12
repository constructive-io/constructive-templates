-- Revert: schemas/myapp_memberships_public/tables/org_grants/columns/capabilities/alterations/alt0000000001


ALTER TABLE myapp_memberships_public.org_grants 
  ALTER COLUMN capabilities DROP NOT NULL;


