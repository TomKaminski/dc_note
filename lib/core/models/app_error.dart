import 'package:equatable/equatable.dart';

class AppError extends Equatable {
  final String message;
  final dynamic errorObject;
  const AppError(this.message, {this.errorObject});

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [message, errorObject];
}
