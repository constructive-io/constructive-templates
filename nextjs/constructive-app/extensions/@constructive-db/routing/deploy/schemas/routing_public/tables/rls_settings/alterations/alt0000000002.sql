-- Deploy: schemas/routing_public/tables/rls_settings/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/rls_settings/table


COMMENT ON TABLE routing_public.rls_settings IS 'RLS module runtime configuration; typed references to the authenticate/current_role function plumbing';