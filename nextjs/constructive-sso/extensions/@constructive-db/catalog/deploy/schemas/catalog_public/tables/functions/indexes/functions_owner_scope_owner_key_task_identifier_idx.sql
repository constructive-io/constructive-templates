-- Deploy: schemas/catalog_public/tables/functions/indexes/functions_owner_scope_owner_key_task_identifier_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema
-- requires: schemas/catalog_public/tables/functions/table
-- requires: schemas/catalog_public/tables/functions/columns/owner_key/column
-- requires: schemas/catalog_public/tables/functions/columns/owner_scope/column
-- requires: schemas/catalog_public/tables/functions/columns/task_identifier/column


CREATE UNIQUE INDEX functions_owner_scope_owner_key_task_identifier_idx ON catalog_public.functions (owner_scope, owner_key, task_identifier) WHERE functions.owner_key IS NOT NULL;