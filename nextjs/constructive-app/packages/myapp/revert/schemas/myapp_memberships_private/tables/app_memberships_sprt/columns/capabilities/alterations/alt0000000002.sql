-- Revert: schemas/myapp_memberships_private/tables/app_memberships_sprt/columns/capabilities/alterations/alt0000000002


ALTER TABLE myapp_memberships_private.app_memberships_sprt 
  ALTER COLUMN capabilities DROP DEFAULT;


