-- Verify: schemas/routing_public/tables/platform_pages/table


SELECT assert_table(CAST('routing_public.platform_pages' AS regclass), false, NULL);