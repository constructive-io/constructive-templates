-- Deploy: schemas/myapp_limits_public/tables/app_limits/columns/plan_max/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/myapp_limits_public/schema
-- requires: schemas/myapp_limits_public/tables/app_limits/columns/plan_max/column


COMMENT ON COLUMN myapp_limits_public.app_limits.plan_max IS E'Ceiling pinned for this actor by the active plan via apply_plan(). NULL means the ceiling follows the tenant default in the default-limits table, so raising a default reaches rows that already exist. Window reset does not change this value.';

