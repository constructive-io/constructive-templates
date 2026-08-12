-- Revert: schemas/routing_public/tables/http_routes/constraints/http_routes_domain_id_fkey/constraint


ALTER TABLE routing_public.http_routes 
  DROP CONSTRAINT http_routes_domain_id_fkey RESTRICT;