'use client';

import { Suspense } from 'react';

import { SignUpCard, type SignUpResult } from '@/blocks/auth/sign-up-card/sign-up-card';
import { AuthSocialProvidersGrid } from '@/blocks/auth/social-providers-grid/social-providers-grid';
import { getAppOrigin, getAuthOrigin } from '@/app-config';
import { AuthScreenLayout } from '@/components/auth/auth-screen-layout';
import { useRegister } from '@/lib/gql/hooks/auth';

function RegisterPageContent() {
	const registerMutation = useRegister();
	// The auth lane's origin — the app's own origin when the endpoint is the
	// same-origin BFF proxy (relative), the per-tenant host otherwise.
	const authOrigin = getAuthOrigin();
	// After OAuth success the middleware redirects to `returnTo` — this must be
	// the FRONTEND app origin (Next.js), NOT the auth API origin.
	const appOrigin = getAppOrigin();

	return (
		<AuthScreenLayout>
			<AuthSocialProvidersGrid
				mode='sign-up'
				baseOAuthPath={`${authOrigin}/auth`}
				returnTo={`${appOrigin}/`}
				className='mb-4 w-full max-w-sm mx-auto'
			/>
			<SignUpCard
				signInHref='/login'
				onSubmit={async (vars): Promise<SignUpResult | null> => {
					// Bridge: the block owns form/validation/error UI; the app's
					// register hook owns the network call + post-sign-up token state.
					await registerMutation.mutateAsync({
						email: vars.email,
						password: vars.password,
						// The block already validated confirm-match inline.
						confirmPassword: vars.password,
						rememberMe: vars.rememberMe
					});
					return {
						id: null,
						userId: null,
						accessToken: null,
						accessTokenExpiresAt: null,
						isVerified: true,
						totpEnabled: false
					};
				}}
			/>
		</AuthScreenLayout>
	);
}

export default function RegisterPage() {
	return (
		<Suspense fallback={<AuthScreenLayout><div className='flex justify-center py-8'>Loading...</div></AuthScreenLayout>}>
			<RegisterPageContent />
		</Suspense>
	);
}
