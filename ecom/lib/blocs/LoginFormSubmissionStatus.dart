
abstract class LoginFormSubmissionStatus {
  const LoginFormSubmissionStatus();
}

class InitialFormStatus extends LoginFormSubmissionStatus {
  const InitialFormStatus();
}

class FormSubmitting extends LoginFormSubmissionStatus {}

class SubmissionSuccess extends LoginFormSubmissionStatus {
  SubmissionSuccess(this.response);
  final String response;

  List<Object?> get props => [response];

}

class SubmissionFailed extends LoginFormSubmissionStatus {
  final Exception exception;
  SubmissionFailed(this.exception);
}