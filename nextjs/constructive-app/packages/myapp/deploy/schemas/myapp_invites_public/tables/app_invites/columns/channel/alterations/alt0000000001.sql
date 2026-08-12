-- Deploy: schemas/myapp_invites_public/tables/app_invites/columns/channel/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_invites_public/schema
-- requires: schemas/myapp_invites_public/tables/app_invites/table
-- requires: schemas/myapp_invites_public/tables/app_invites/columns/channel/column


ALTER TABLE myapp_invites_public.app_invites 
  ALTER COLUMN channel SET NOT NULL;

