import 'package:json_annotation/json_annotation.dart';
import 'package:wan_flutter/data/bean/CommonBean.dart';

part 'Todo.g.dart';

@JsonSerializable()
class TodoBean extends CommonBean {
  TodoBean(this.data, int errorCode,  String errorMsg) : super(errorCode, errorMsg);

  TodoData data;

  factory TodoBean.fromJson(Map<String, dynamic> json) =>
      _$TodoBeanFromJson(json);

  @override
  bool isSuccess() {
    return errorCode == 0;
  }
}

@JsonSerializable()
class TodoData {
  List<Todo> datas;
  int offset;
  bool over;
  int pageCount;
  int size;
  int total;
  int curPage;

  factory TodoData.fromJson(Map<String, dynamic> json) =>
      _$TodoDataFromJson(json);

  TodoData(this.datas, this.offset, this.over, this.pageCount, this.size,
      this.total, this.curPage);
}

@JsonSerializable()
class Todo {
  int completeDate;
  String completeDateStr;
  String content;
  int date;
  String dateStr;
  int id;
  int priority;
  int status;
  String title;
  int type;
  int userId;

  Todo(this.completeDate, this.completeDateStr, this.content, this.date,
      this.dateStr, this.id, this.status, this.title, this.type, this.userId);

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  isFinish() {
    return this.status == 1;
  }
}
