-- Verify: schemas/routing_public/tables/platform_domains/grants/authenticated/delete/grant


SELECT verify_table_grant('routing_public.platform_domains', 'DELETE', 'authenticated');