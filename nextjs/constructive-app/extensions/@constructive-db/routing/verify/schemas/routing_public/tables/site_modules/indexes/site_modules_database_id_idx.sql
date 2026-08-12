-- Verify: schemas/routing_public/tables/site_modules/indexes/site_modules_database_id_idx


SELECT assert_index(CAST('routing_public.site_modules_database_id_idx' AS regclass), CAST('routing_public.site_modules' AS regclass), false);