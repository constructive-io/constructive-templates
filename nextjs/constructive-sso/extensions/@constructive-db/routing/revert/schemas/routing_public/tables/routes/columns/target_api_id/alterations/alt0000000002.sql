-- Revert: schemas/routing_public/tables/routes/columns/target_api_id/alterations/alt0000000002


ALTER TABLE routing_public.routes 
  DROP CONSTRAINT routes_target_api_id_target_site_id_target_function_id_target_s RESTRICT;