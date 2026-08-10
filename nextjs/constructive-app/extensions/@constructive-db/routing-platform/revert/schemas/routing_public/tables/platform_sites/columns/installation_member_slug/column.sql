-- Revert: schemas/routing_public/tables/platform_sites/columns/installation_member_slug/column


ALTER TABLE routing_public.platform_sites 
  DROP COLUMN installation_member_slug RESTRICT;