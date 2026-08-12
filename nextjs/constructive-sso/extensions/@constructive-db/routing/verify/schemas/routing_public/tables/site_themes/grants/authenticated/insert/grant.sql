-- Verify: schemas/routing_public/tables/site_themes/grants/authenticated/insert/grant


SELECT verify_table_grant('routing_public.site_themes', 'INSERT', 'authenticated');