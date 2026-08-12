-- Verify: schemas/myapp_storage_public/tables/app_files/grants/authenticated/update/grant


SELECT assert_table_grant('myapp_storage_public.app_files'::regclass, 'authenticated', 'UPDATE', ARRAY['filename', 'description', 'tags'], true);


