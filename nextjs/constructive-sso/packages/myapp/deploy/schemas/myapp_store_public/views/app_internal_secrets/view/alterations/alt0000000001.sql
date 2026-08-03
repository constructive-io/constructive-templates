-- Deploy: schemas/myapp_store_public/views/app_internal_secrets/view/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_store_public/schema
-- requires: schemas/myapp_store_public/views/app_internal_secrets/view


COMMENT ON VIEW myapp_store_public.app_internal_secrets IS E'@behavior -insert -update -delete';

