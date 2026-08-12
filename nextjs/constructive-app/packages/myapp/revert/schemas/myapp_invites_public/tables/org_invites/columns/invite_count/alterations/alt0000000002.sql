-- Revert: schemas/myapp_invites_public/tables/org_invites/columns/invite_count/alterations/alt0000000002


ALTER TABLE myapp_invites_public.org_invites 
  ALTER COLUMN invite_count DROP DEFAULT;


