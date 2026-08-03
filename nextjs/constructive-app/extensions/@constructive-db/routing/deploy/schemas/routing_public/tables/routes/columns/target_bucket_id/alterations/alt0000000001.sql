-- Deploy: schemas/routing_public/tables/routes/columns/target_bucket_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/routes/columns/target_bucket_id/column


COMMENT ON COLUMN routing_public.routes.target_bucket_id IS 'Bucket catalog row this route targets; must be a public bucket that is owner-matched or visible cross-scope';