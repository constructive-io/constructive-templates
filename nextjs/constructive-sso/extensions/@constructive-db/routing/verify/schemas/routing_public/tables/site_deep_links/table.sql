-- Verify: schemas/routing_public/tables/site_deep_links/table


SELECT assert_table(CAST('routing_public.site_deep_links' AS regclass), false, NULL);