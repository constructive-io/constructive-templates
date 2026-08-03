-- Verify: schemas/routing_public/tables/platform_site_metadata/grants/authenticated/delete/grant


SELECT verify_table_grant('routing_public.platform_site_metadata', 'DELETE', 'authenticated');