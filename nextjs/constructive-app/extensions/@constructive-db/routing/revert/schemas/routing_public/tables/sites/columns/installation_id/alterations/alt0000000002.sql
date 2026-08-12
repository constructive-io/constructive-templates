-- Revert: schemas/routing_public/tables/sites/columns/installation_id/alterations/alt0000000002


ALTER TABLE routing_public.sites 
  DROP CONSTRAINT sites_installation_id_installation_member_slug_chk RESTRICT;