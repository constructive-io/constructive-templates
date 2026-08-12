-- Revert: schemas/routing_public/tables/sites/columns/installation_member_slug/column


ALTER TABLE routing_public.sites 
  DROP COLUMN installation_member_slug RESTRICT;