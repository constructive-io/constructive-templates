-- Verify: schemas/routing_public/tables/site_themes/table


SELECT assert_table(CAST('routing_public.site_themes' AS regclass), false, NULL);