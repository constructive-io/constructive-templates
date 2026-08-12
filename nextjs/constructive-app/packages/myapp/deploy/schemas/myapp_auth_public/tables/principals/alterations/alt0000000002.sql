-- Deploy: schemas/myapp_auth_public/tables/principals/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principals/table


COMMENT ON TABLE myapp_auth_public.principals IS E'Scoped sub-identities (API keys and agents) with precomputed SPRT';

