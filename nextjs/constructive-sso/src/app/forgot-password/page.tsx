'use client';

import { Suspense } from 'react';

import { ForgotPasswordCard } from '@/blocks/auth/forgot-password-card/forgot-password-card';
import { AuthScreenLayout } from '@/components/auth/auth-screen-layout';
import { useForgotPassword } from '@/lib/gql/hooks/auth';

function ForgotPasswordPageContent() {
	const forgotPasswordMutation = useForgotPassword();

	return (
		<AuthScreenLayout>
			<ForgotPasswordCard
				signInHref='/login'
				onSubmit={async (vars) => {
					// Bridge: the block owns form/success-state UI; the app's
					// forgot-password hook owns the network call.
					await forgotPasswordMutation.mutateAsync({ email: vars.email });
				}}
			/>
		</AuthScreenLayout>
	);
}

export default function ForgotPasswordPage() {
	return (
		<Suspense fallback={<AuthScreenLayout><div className='flex justify-center py-8'>Loading...</div></AuthScreenLayout>}>
			<ForgotPasswordPageContent />
		</Suspense>
	);
}
