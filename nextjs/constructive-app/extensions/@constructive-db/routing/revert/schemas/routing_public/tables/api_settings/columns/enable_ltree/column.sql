-- Revert: schemas/routing_public/tables/api_settings/columns/enable_ltree/column


ALTER TABLE routing_public.api_settings 
  DROP COLUMN enable_ltree RESTRICT;