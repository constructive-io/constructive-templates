-- Verify: schemas/routing_public/tables/platform_site_themes/grants/authenticated/select/grant


SELECT verify_table_grant('routing_public.platform_site_themes', 'SELECT', 'authenticated');