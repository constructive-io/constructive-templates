-- Revert: schemas/routing_public/tables/site_metadata/columns/apple_touch_icon/column


ALTER TABLE routing_public.site_metadata 
  DROP COLUMN apple_touch_icon RESTRICT;