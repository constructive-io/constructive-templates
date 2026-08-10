-- Deploy: schemas/myapp_auth_public/tables/principals/alterations/alt0000000004
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principals/table


COMMENT ON TABLE myapp_auth_public.principals IS E'@behavior -insert -update -delete
@has_guard
Scoped sub-identities (API keys and agents) with precomputed SPRT';

