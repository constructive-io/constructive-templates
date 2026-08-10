-- Verify: schemas/myapp_storage_public/tables/app_files/table


SELECT assert_table('myapp_storage_public.app_files'::regclass, false, NULL);


