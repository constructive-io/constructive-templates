-- Revert: schemas/routing_public/tables/http_routes/columns/target_kind/alterations/alt0000000003


ALTER TABLE routing_public.http_routes 
  DROP CONSTRAINT http_routes_target_kind_chk RESTRICT;