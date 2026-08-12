-- Verify: schemas/routing_public/tables/site_deep_links/grants/authenticated/delete/grant


SELECT assert_table_grant(CAST('routing_public.site_deep_links' AS regclass), 'authenticated', 'DELETE', NULL, true);