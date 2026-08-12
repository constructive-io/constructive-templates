-- Revert: schemas/myapp_memberships_private/tables/org_memberships_sprt/columns/capabilities/alterations/alt0000000002


ALTER TABLE myapp_memberships_private.org_memberships_sprt 
  ALTER COLUMN capabilities DROP DEFAULT;


