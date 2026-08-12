-- Revert: schemas/routing_public/tables/http_routes/columns/path/alterations/alt0000000004


ALTER TABLE routing_public.http_routes 
  DROP CONSTRAINT http_routes_path_chk RESTRICT;