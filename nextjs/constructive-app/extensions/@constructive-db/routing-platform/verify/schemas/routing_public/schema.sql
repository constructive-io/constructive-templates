-- Verify: schemas/routing_public/schema


SELECT assert_schema(CAST('routing_public' AS regnamespace));