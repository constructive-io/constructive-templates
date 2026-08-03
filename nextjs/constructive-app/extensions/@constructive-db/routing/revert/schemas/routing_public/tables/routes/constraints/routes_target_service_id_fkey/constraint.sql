-- Revert: schemas/routing_public/tables/routes/constraints/routes_target_service_id_fkey/constraint


ALTER TABLE routing_public.routes 
  DROP CONSTRAINT routes_target_service_id_fkey RESTRICT;