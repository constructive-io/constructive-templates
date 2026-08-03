-- Verify: schemas/catalog_public/tables/domains/grants/authenticated/insert/grant


SELECT verify_table_grant('catalog_public.domains', 'INSERT', 'authenticated');