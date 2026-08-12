-- Revert: schemas/routing_public/tables/platform_site_metadata/columns/apple_touch_icon/column


ALTER TABLE routing_public.platform_site_metadata 
  DROP COLUMN apple_touch_icon RESTRICT;