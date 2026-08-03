-- Revert: schemas/routing_public/tables/routes/columns/path/alterations/alt0000000004


ALTER TABLE routing_public.routes 
  DROP CONSTRAINT routes_path_chk RESTRICT;