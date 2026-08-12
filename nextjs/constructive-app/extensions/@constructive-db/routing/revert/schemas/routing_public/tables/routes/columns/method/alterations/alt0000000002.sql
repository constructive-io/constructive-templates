-- Revert: schemas/routing_public/tables/routes/columns/method/alterations/alt0000000002


ALTER TABLE routing_public.routes 
  DROP CONSTRAINT routes_method_chk RESTRICT;