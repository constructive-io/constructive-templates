-- Deploy: schemas/myapp_limits_public/tables/app_limit_credit_code_items/indexes/app_limit_credit_code_items_default_limit_id_idx
-- made with <3 @ constructive.io

-- requires: schemas/myapp_limits_public/schema
-- requires: schemas/myapp_limits_public/tables/app_limit_credit_code_items/table
-- requires: schemas/myapp_limits_public/tables/app_limit_credit_code_items/columns/default_limit_id/column


CREATE INDEX app_limit_credit_code_items_default_limit_id_idx ON myapp_limits_public.app_limit_credit_code_items USING BTREE ( default_limit_id );

