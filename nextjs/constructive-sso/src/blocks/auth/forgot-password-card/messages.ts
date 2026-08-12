export type ForgotPasswordCardMessages = {
  title: string;
  description: string;
  emailLabel: string;
  emailPlaceholder: string;
  submitLabel: string;
  loadingLabel: string;
  backToSignInLabel: string;
  /** Confirmation panel copy */
  confirmationTitle: string;
  /** May contain {{email}} token — replaced at render. */
  confirmationDescription: string;
  resendLabel: string;
  resendLoadingLabel: string;
  resendSuccessMessage: string;
  errors: {
    RATE_LIMITED: string;
    UNKNOWN_ERROR: string;
  };
};

export const defaultForgotPasswordCardMessages: ForgotPasswordCardMessages = {
  title: 'Forgot your password?',
  description: "Enter your email address and we'll send you a reset link.",
  emailLabel: 'Email',
  emailPlaceholder: 'you@example.com',
  submitLabel: 'Send reset link',
  loadingLabel: 'Sending…',
  backToSignInLabel: '← Back to sign in',
  confirmationTitle: 'Check your email',
  confirmationDescription:
    "If an account exists for {{email}}, you'll receive a password reset link shortly.",
  resendLabel: 'Resend email',
  resendLoadingLabel: 'Resending…',
  resendSuccessMessage: 'Email resent.',
  errors: {
    RATE_LIMITED: 'Too many requests. Please wait before trying again.',
    UNKNOWN_ERROR: 'Something went wrong. Please try again.'
  }
};
