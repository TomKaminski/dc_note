import 'package:DC_Note/core/models/app_error.dart';
import 'package:equatable/equatable.dart';

class BooleanState extends Equatable {
  final bool isProcessing;
  final bool isSuccessful;
  final AppError error;
  bool get isError => error != null;

  const BooleanState.processing()
      : isProcessing = true,
        isSuccessful = false,
        error = null;

  const BooleanState.notProcessing()
      : isProcessing = false,
        isSuccessful = false,
        error = null;

  const BooleanState.successful()
      : isProcessing = false,
        isSuccessful = true,
        error = null;

  const BooleanState.error(this.error)
      : isProcessing = false,
        isSuccessful = false;

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [isProcessing, isSuccessful, error];
}

class BooleanStateWithModel<TModel> extends BooleanState {
  final TModel data;
  const BooleanStateWithModel.processing({this.data}) : super.processing();
  const BooleanStateWithModel.notProcessing({this.data})
      : super.notProcessing();
  const BooleanStateWithModel.successful(this.data) : super.successful();
  const BooleanStateWithModel.error(AppError error, {this.data})
      : super.error(error);

  @override
  List<Object> get props => [...super.props, data];
}
