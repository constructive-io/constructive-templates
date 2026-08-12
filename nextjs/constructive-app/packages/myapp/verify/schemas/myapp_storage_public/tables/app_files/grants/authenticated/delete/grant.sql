-- Verify: schemas/myapp_storage_public/tables/app_files/grants/authenticated/delete/grant


SELECT assert_table_grant('myapp_storage_public.app_files'::regclass, 'authenticated', 'DELETE', NULL, true);


