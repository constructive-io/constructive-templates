-- Deploy: schemas/routing_public/tables/database_settings/columns/enable_realtime/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/database_settings/columns/enable_realtime/column


COMMENT ON COLUMN routing_public.database_settings.enable_realtime IS 'Enable realtime subscriptions (cursor-tracked change delivery) in the GraphQL API';