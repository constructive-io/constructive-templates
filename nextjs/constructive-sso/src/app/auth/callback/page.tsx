'use client';

import { useEffect } from 'react';
import { useRouter } from 'next/navigation';

import { useAuthContext } from '@/lib/auth/auth-context';
import { AuthScreenLayout } from '@/components/auth/auth-screen-layout';

/**
 * OAuth callback / session-hydration route.
 *
 * The CNC OAuth middleware redirects to a same-origin path on the auth API
 * (not to this Next.js app — it's cross-origin and the middleware rejects
 * cross-origin redirect_uri unless scoped routing resolves it to the same
 * databaseId). After the OAuth callback sets the constructive_session cookie
 * (domain=localhost), the user navigates to this page (or to any route —
 * trySessionAuth in auth-context runs on every mount).
 *
 * This page waits for the auth-context to resolve the session via cookie,
 * then redirects to `/` on success or `/login` on failure.
 */
export default function AuthCallbackPage() {
	const { isAuthenticated, isLoading } = useAuthContext();
	const router = useRouter();

	useEffect(() => {
		if (isLoading) return;
		if (isAuthenticated) {
			router.replace('/');
		} else {
			router.replace('/login?error=sso_session_expired');
		}
	}, [isAuthenticated, isLoading, router]);

	return (
		<AuthScreenLayout>
			<div className='flex flex-col items-center justify-center gap-4 py-12'>
				<div className='border-primary/20 h-10 w-10 animate-spin rounded-full border-4 border-t-primary' />
				<p className='text-muted-foreground text-sm font-medium'>
					Completing sign-in…
				</p>
			</div>
		</AuthScreenLayout>
	);
}
