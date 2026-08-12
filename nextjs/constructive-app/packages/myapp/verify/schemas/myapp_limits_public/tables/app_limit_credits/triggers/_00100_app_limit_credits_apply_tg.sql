-- Verify: schemas/myapp_limits_public/tables/app_limit_credits/triggers/_00100_app_limit_credits_apply_tg


SELECT assert_trigger('myapp_limits_public.app_limit_credits'::regclass, '_00100_app_limit_credits_apply_tg', 'myapp_limits_private.app_limit_credits_apply_tg_fn'::regproc, 5);


