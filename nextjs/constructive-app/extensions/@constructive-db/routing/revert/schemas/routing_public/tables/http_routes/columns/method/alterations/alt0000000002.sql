-- Revert: schemas/routing_public/tables/http_routes/columns/method/alterations/alt0000000002


ALTER TABLE routing_public.http_routes 
  DROP CONSTRAINT http_routes_method_chk RESTRICT;