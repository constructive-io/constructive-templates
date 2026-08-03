-- Deploy: schemas/myapp_permissions_public/tables/app_permissions/alterations/fix0000000004
-- made with <3 @ constructive.io

-- requires: schemas/myapp_permissions_public/schema
-- requires: schemas/myapp_permissions_public/tables/app_permissions/table


INSERT INTO myapp_permissions_public.app_permissions (
  bitnum,
  name,
  description
)
VALUES
  (13, 'write_files', 'Update metadata on any member''s files (escalation beyond own files).'),
  (14, 'delete_files', 'Delete any member''s files (escalation beyond own files).'),
  (15, 'share_files', 'Manage path shares for files and folders.'),
  (16, 'read_files', 'Read files when restrict_reads is enabled (opt-in restrictive mode).'),
  (17, 'manage_storage', 'Create, configure, and delete storage buckets (beyond file-level permissions).');

