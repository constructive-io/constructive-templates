-- Verify: schemas/routing_public/tables/platform_sites/grants/authenticated/delete/grant


SELECT verify_table_grant('routing_public.platform_sites', 'DELETE', 'authenticated');