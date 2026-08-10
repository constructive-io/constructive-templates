-- Revert: schemas/routing_public/tables/platform_sites/columns/installation_id/alterations/alt0000000002


ALTER TABLE routing_public.platform_sites 
  DROP CONSTRAINT platform_sites_installation_id_installation_member_slug_chk RESTRICT;