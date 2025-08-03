enum ErrorType {
  /// General
  internalError,
  dataLoss,
  unknown,

  /// Firebase Auth
  invalidEmail,
  userNotFound,
  userDisabled,
  emailAlreadyInUse,
  invalidCredential,
  accountExistsWithDifferentCredential,
  operationNotAllowed,
  tooManyRequests,
  networkError,
  requiresRecentLogin,
  expiredActionCode,
  invalidActionCode,
  signinCancelled,
  noUser,

  /// Firestore
  documentNotFound,
  documentAlreadyExists,
  permissionDenied,
  resourceExhausted,
  unauthenticated,
  deadlineExceeded,
  invalidArgument,
  unavailable,
  aborted,
  outOfRange,
  failedPrecondition,

  /// Storage
  objectNotFound,
  bucketNotFound,
  unauthorized,
  retryLimitExceeded,
  quotaExceeded,
  projectNotFound,
}
