-- Deploy: schemas/routing_public/tables/platform_pages/columns/store_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_pages/columns/store_id/column


COMMENT ON COLUMN routing_public.platform_pages.store_id IS 'Infra Merkle store holding this row''s history (stamped by the versioned trigger)';