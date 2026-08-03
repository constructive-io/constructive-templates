-- Revert: schemas/myapp_invites_public/tables/org_invites/columns/invite_valid/alterations/alt0000000002


ALTER TABLE myapp_invites_public.org_invites 
  ALTER COLUMN invite_valid DROP DEFAULT;


