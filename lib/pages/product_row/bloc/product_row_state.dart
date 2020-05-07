part of 'product_row_bloc.dart';

class ProductRowState extends BooleanStateWithModel<bool> {
  const ProductRowState.processing(bool inUse) : super.processing(inUse);

  const ProductRowState.notProcessing(bool inUse) : super.notProcessing(inUse);

  const ProductRowState.successful(bool inUse) : super.successful(inUse);

  const ProductRowState.error(AppError error) : super.error(error);
}
