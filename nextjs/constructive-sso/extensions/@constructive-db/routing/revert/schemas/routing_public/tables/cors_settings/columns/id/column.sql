-- Revert: schemas/routing_public/tables/cors_settings/columns/id/column


ALTER TABLE routing_public.cors_settings 
  DROP COLUMN id RESTRICT;