-- Deploy: schemas/catalog_private/tables/functions/indexes/functions_database_id_owner_scope_task_identifier_idx
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema
-- requires: schemas/catalog_private/tables/functions/table
-- requires: schemas/catalog_private/tables/functions/columns/owner_key/column
-- requires: schemas/catalog_private/tables/functions/columns/database_id/column
-- requires: schemas/catalog_private/tables/functions/columns/owner_scope/column
-- requires: schemas/catalog_private/tables/functions/columns/task_identifier/column


CREATE UNIQUE INDEX functions_database_id_owner_scope_task_identifier_idx ON catalog_private.functions (database_id, owner_scope, task_identifier) WHERE functions.owner_key IS NULL;