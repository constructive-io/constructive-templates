-- Verify: schemas/catalog_public/tables/domains/grants/authenticated/delete/grant


SELECT verify_table_grant('catalog_public.domains', 'DELETE', 'authenticated');