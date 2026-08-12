-- Revert: schemas/routing_public/tables/api_settings/columns/enable_direct_uploads/column


ALTER TABLE routing_public.api_settings 
  DROP COLUMN enable_direct_uploads RESTRICT;