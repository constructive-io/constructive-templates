'use client';

import { Suspense } from 'react';

import { SignUpCard, type SignUpResult } from '@/blocks/auth/sign-up-card/sign-up-card';
import { AuthSocialProvidersGrid } from '@/blocks/auth/social-providers-grid/social-providers-grid';
import { getEndpoint } from '@/app-config';
import { AuthScreenLayout } from '@/components/auth/auth-screen-layout';
import { useRegister } from '@/lib/gql/hooks/auth';

function RegisterPageContent() {
	const registerMutation = useRegister();
	// OAuth middleware lives on the auth API origin (not this app's origin).
	const authOrigin = new URL(getEndpoint('auth')).origin;

	return (
		<AuthScreenLayout>
			<AuthSocialProvidersGrid
				mode='sign-up'
				baseOAuthPath={`${authOrigin}/auth`}
				returnTo={`${authOrigin}/`}
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
