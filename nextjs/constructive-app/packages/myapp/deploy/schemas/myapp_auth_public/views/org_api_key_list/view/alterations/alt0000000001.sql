-- Deploy: schemas/myapp_auth_public/views/org_api_key_list/view/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_auth_public/schema
-- requires: schemas/myapp_auth_public/views/org_api_key_list/view


COMMENT ON VIEW myapp_auth_public.org_api_key_list IS E'@behavior -insert -update -delete';

