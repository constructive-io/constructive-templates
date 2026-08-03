-- Deploy: schemas/routing_public/tables/http_routes/columns/target_kind/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/http_routes/columns/target_kind/column


COMMENT ON COLUMN routing_public.http_routes.target_kind IS 'Discriminator selecting the type of target_id';