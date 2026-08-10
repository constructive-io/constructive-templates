-- Deploy: schemas/myapp_capabilities_public/tables/app_capabilities/alterations/fix0000000003
-- made with <3 @ constructive.io

-- requires: schemas/myapp_capabilities_public/schema
-- requires: schemas/myapp_capabilities_public/tables/app_capabilities/table


INSERT INTO myapp_capabilities_public.app_capabilities (
  bitnum,
  name,
  description
)
VALUES
  (1, 'admin_members', 'Manage members of the app.'),
  (2, 'create_invites', 'Create invites for the app.'),
  (3, 'admin_invites', 'Approve invites of the app.'),
  (4, 'send_approved_invites', 'Invites sent by this user are pre-approved.'),
  (5, 'create_entity', 'Create organization entities.'),
  (6, 'admin_limits', 'Manage limits within the app.'),
  (7, 'admin_capabilities', 'Manage capabilities within the app.'),
  (8, 'admin_levels', 'Manage levels of the app.'),
  (9, 'manage_identity_providers', 'Manage identity providers for the app.'),
  (10, 'assign_profiles', 'Assign profiles (roles) to invites for the app.'),
  (11, 'add_credits', 'Add credits to limits and billing meters.'),
  (12, 'manage_secrets', 'Manage encrypted secrets for the app.');

