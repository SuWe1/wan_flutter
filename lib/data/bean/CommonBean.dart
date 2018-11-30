import 'package:json_annotation/json_annotation.dart';

part 'CommonBean.g.dart';

@JsonSerializable()
class CommonBean {
  CommonBean(this.data, this.errorCode, this.errorMsg);

  Object data;
  int errorCode;
  String errorMsg;

  factory CommonBean.fromJson(Map<String, dynamic> json) =>
      _$CommonBeanFromJson(json);
}
