import 'package:equatable/equatable.dart';
import 'package:moor_flutter/moor_flutter.dart';

abstract class BaseAppModel extends Equatable {
  BaseAppModel();
  BaseAppModel.fromEntity(DataClass entity);
  DataClass toEntity();
}
