-- Verify: schemas/routing_public/tables/platform_site_metadata/grants/authenticated/update/grant


SELECT verify_table_grant('routing_public.platform_site_metadata', 'UPDATE', 'authenticated');