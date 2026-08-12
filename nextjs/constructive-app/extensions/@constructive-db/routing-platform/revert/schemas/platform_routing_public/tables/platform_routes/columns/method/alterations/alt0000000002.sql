-- Revert: schemas/platform_routing_public/tables/platform_routes/columns/method/alterations/alt0000000002


ALTER TABLE platform_routing_public.platform_routes 
  DROP CONSTRAINT platform_routes_method_chk RESTRICT;