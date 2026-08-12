-- Deploy: schemas/myapp_capabilities_public/tables/app_capabilities/alterations/fix0000000004
-- made with <3 @ constructive.io

-- requires: schemas/myapp_capabilities_public/schema
-- requires: schemas/myapp_capabilities_public/tables/app_capabilities/table


INSERT INTO myapp_capabilities_public.app_capabilities (
  bitnum,
  name,
  description
)
VALUES
  (13, 'write_files', 'Update metadata on any member''s files (escalation beyond own files).'),
  (14, 'delete_files', 'Delete any member''s files (escalation beyond own files).'),
  (15, 'share_files', 'Manage path shares for files and folders.'),
  (16, 'read_files', 'Read files when restrict_reads is enabled (opt-in restrictive mode).'),
  (17, 'manage_storage', 'Create, configure, and delete storage buckets (beyond file-level capabilities).');

