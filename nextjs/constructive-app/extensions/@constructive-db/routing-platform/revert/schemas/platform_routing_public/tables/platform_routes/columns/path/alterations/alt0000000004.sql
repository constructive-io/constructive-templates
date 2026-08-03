-- Revert: schemas/platform_routing_public/tables/platform_routes/columns/path/alterations/alt0000000004


ALTER TABLE platform_routing_public.platform_routes 
  DROP CONSTRAINT platform_routes_path_chk RESTRICT;