-- Verify: schemas/routing_public/tables/platform_managed_domains/grants/authenticated/delete/grant


SELECT verify_table_grant('routing_public.platform_managed_domains', 'DELETE', 'authenticated');