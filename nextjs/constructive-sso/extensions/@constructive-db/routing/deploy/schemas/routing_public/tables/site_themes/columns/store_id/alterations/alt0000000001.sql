-- Deploy: schemas/routing_public/tables/site_themes/columns/store_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/site_themes/columns/store_id/column


COMMENT ON COLUMN routing_public.site_themes.store_id IS 'Infra Merkle store holding this row''s history (stamped by the versioned trigger)';