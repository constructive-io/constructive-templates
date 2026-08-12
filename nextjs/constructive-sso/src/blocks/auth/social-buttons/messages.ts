export type AuthSocialButtonsMessages = {
  /** Divider label between social buttons and an email/password form */
  dividerText: string;
  /** "Continue with {{provider}}" — used as default when mode is unset */
  continueWith: string;
  /** "Sign in with {{provider}}" — used when mode === 'sign-in' */
  signInWith: string;
  /** "Sign up with {{provider}}" — used when mode === 'sign-up' */
  signUpWith: string;
  /** Aria-label for icon-only layout: "Sign in with {{provider}}" */
  iconOnlyAriaLabel: string;
  /** Aria-label for skeleton loading state */
  loadingAriaLabel: string;
  /** Shown when provider list is empty */
  noProvidersMessage: string;
  /** Backend error codes (UPPER_SNAKE_CASE) — passed to parseGraphQLError */
  errors: {
    UNKNOWN_ERROR: string;
  };
};

/**
 * Deep-partial override type: top-level keys are shallow-optional; the `errors`
 * sub-map is itself partial, letting a host localise a single error code without
 * restating the entire catalog.
 */
export type AuthSocialButtonsMessageOverrides = Partial<Omit<AuthSocialButtonsMessages, 'errors'>> & {
  errors?: Partial<AuthSocialButtonsMessages['errors']>;
};

export const defaultAuthSocialButtonsMessages: AuthSocialButtonsMessages = {
  dividerText: 'or',
  continueWith: 'Continue with {{provider}}',
  signInWith: 'Sign in with {{provider}}',
  signUpWith: 'Sign up with {{provider}}',
  iconOnlyAriaLabel: 'Sign in with {{provider}}',
  loadingAriaLabel: 'Loading sign-in options…',
  noProvidersMessage: 'No social sign-in options are available.',
  errors: {
    UNKNOWN_ERROR: 'Something went wrong. Please try again.'
  }
};
