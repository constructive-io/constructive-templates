-- Deploy: schemas/myapp_auth_public/views/identity_providers/view/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/views/identity_providers/view


COMMENT ON VIEW myapp_auth_public.identity_providers IS E'@behavior -insert -update -delete';

