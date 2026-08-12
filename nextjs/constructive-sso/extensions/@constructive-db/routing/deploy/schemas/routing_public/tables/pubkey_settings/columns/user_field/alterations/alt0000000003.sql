-- Deploy: schemas/routing_public/tables/pubkey_settings/columns/user_field/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/pubkey_settings/columns/user_field/column


COMMENT ON COLUMN routing_public.pubkey_settings.user_field IS 'Field name used to identify the user in crypto auth functions';