-- Deploy: schemas/myapp_permissions_public/tables/app_permission_defaults/alterations/fix0000000003
-- made with <3 @ constructive.io

-- requires: schemas/myapp_permissions_public/schema
-- requires: schemas/myapp_permissions_public/tables/app_permission_defaults/table


INSERT INTO myapp_permissions_public.app_permission_defaults (
  permissions
)
VALUES
  (DEFAULT);

