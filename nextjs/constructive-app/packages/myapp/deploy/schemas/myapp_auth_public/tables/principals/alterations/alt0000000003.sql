-- Deploy: schemas/myapp_auth_public/tables/principals/alterations/alt0000000003
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/tables/principals/table


COMMENT ON TABLE myapp_auth_public.principals IS E'@behavior -insert -update -delete
Scoped sub-identities (API keys and agents) with precomputed SPRT';

