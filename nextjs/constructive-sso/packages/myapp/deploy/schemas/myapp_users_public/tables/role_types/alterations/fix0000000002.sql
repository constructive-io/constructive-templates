-- Deploy: schemas/myapp_users_public/tables/role_types/alterations/fix0000000002
-- made with <3 @ constructive.io

-- requires: schemas/myapp_users_public/schema
-- requires: schemas/myapp_users_public/tables/role_types/table


INSERT INTO myapp_users_public.role_types (
  id,
  name
)
VALUES
  (1, 'User'),
  (2, 'Organization'),
  (3, 'Principal');

