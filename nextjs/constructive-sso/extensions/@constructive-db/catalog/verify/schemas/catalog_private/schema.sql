-- Verify: schemas/catalog_private/schema


SELECT assert_schema(CAST('catalog_private' AS regnamespace));