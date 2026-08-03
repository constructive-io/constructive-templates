-- Deploy: schemas/routing_public/tables/pubkey_settings/columns/sign_in_record_failure_function_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/pubkey_settings/columns/sign_in_record_failure_function_id/column


COMMENT ON COLUMN routing_public.pubkey_settings.sign_in_record_failure_function_id IS 'Reference to the sign-in failure recording function (FK to metaschema_public.function)';