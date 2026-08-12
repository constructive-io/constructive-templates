-- Verify: schemas/routing_public/tables/site_metadata/table


SELECT assert_table(CAST('routing_public.site_metadata' AS regclass), false, NULL);