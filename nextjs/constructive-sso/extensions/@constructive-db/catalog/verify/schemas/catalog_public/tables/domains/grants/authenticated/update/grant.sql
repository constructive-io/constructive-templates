-- Verify: schemas/catalog_public/tables/domains/grants/authenticated/update/grant


SELECT verify_table_grant('catalog_public.domains', 'UPDATE', 'authenticated');