-- Deploy: schemas/routing_public/tables/rls_settings/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/rls_settings/table


COMMENT ON TABLE routing_public.rls_settings IS '@scope database
@scopeKey database_id
@scopeTier database
RLS module runtime configuration; typed references to the authenticate/current_role function plumbing';