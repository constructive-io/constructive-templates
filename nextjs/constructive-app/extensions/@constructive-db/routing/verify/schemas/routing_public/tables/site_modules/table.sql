-- Verify: schemas/routing_public/tables/site_modules/table


SELECT assert_table(CAST('routing_public.site_modules' AS regclass), false, NULL);