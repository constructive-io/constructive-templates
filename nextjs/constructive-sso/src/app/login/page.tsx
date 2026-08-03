'use client';

import { Suspense } from 'react';

import { SignInCard, type SignInResult } from '@/blocks/auth/sign-in-card/sign-in-card';
import { AuthSocialProvidersGrid } from '@/blocks/auth/social-providers-grid/social-providers-grid';
import { getEndpoint } from '@/app-config';
import { AuthScreenLayout } from '@/components/auth/auth-screen-layout';
import { useAuthContext } from '@/lib/auth/auth-context';

function LoginPageContent() {
	const { login } = useAuthContext();
	// OAuth middleware lives on the auth API origin (not this app's origin).
	const authOrigin = new URL(getEndpoint('auth')).origin;

	return (
		<AuthScreenLayout>
			<AuthSocialProvidersGrid
				mode='sign-in'
				baseOAuthPath={`${authOrigin}/auth`}
				returnTo={`${authOrigin}/`}
				className='mb-4 w-full max-w-sm mx-auto'
			/>
			<SignInCard
				forgotPasswordHref='/forgot-password'
				signUpHref='/register'
				onSubmit={async (vars): Promise<SignInResult | null> => {
					// Bridge: the block owns form/validation/error UI; the app's
					// auth-context owns the network call + token/session state.
					// Route guards navigate away once authenticated.
					await login({
						email: vars.email,
						password: vars.password,
						rememberMe: vars.rememberMe
					});
					return {
						id: null,
						userId: null,
						accessToken: null,
						accessTokenExpiresAt: null,
						isVerified: true,
						totpEnabled: false,
						mfaRequired: false,
						mfaChallengeToken: null
					};
				}}
			/>
		</AuthScreenLayout>
	);
}

// NOTE: redirect_uri must be same-origin with the auth server (the middleware
// rejects cross-origin). Session handoff back to this app is handled by the
// .localhost cookie domain + a callback/hydrate step — see the SSO plan.

export default function LoginPage() {
	return (
		<Suspense fallback={<AuthScreenLayout><div className='flex justify-center py-8'>Loading...</div></AuthScreenLayout>}>
			<LoginPageContent />
		</Suspense>
	);
}
