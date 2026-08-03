-- Verify: schemas/routing_public/tables/platform_site_metadata/grants/authenticated/select/grant


SELECT verify_table_grant('routing_public.platform_site_metadata', 'SELECT', 'authenticated');