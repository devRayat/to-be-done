library todo_model;

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

part 'todo.g.dart';

@HiveType(typeId: 0)
class Todo with HiveObjectMixin, EquatableMixin {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String label;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final DateTime createdAt;

  @HiveField(4)
  final DateTime? beforeTime;

  @HiveField(5)
  final Color color;

  @HiveField(6)
  bool get done => _done.value;
  set done(bool? state) {
    _done.value = state ?? false;
  }

  Future<void> setDone(bool? newState) async {
    done = newState;
    await save();
  }

  final _done = false.obs;

  void toggleDone() async {
    await setDone(!done);
  }

  Todo({
    required this.id,
    required this.label,
    required this.description,
    required this.createdAt,
    this.beforeTime,
    this.color = const Color(0xFFFEFEFE),
    bool done = false,
  }) {
    this.done = done;
  }

  factory Todo.initial({
    required String id,
    required String label,
    required String description,
    DateTime? beforeTime,
    bool done = false,
    Color color = const Color(0xFFFEFEFE),
    DateTime? createdAt,
  }) =>
      Todo(
        id: id,
        label: label,
        description: description,
        color: color,
        createdAt: createdAt ?? DateTime.now(),
      );

  factory Todo.demo(String id) => Todo.initial(
        id: id,
        label: 'Todo $id',
        description: 'Todo description $id',
        beforeTime: DateTime.now(),
      );

  factory Todo.fromJson(Map<String, dynamic> json) => Todo.initial(
        id: json['id'] as String,
        label: json['label'] as String,
        description: json['description'] as String,
        done: json['done'] as bool,
        color: Color(json['color'] as int),
        beforeTime: json['beforeTime'] != null
            ? DateTime.parse(json['beforeTime'] as String)
            : null,
      );

  Map<String, dynamic> toJSON() => {
        'id': id,
        'label': label,
        'description': description,
        'done': done,
        'createdAt': createdAt.toIso8601String(),
        'beforeTime': beforeTime?.toIso8601String(),
        'color': color.value,
      };

  Todo copyWith({
    String? id,
    String? label,
    String? description,
    DateTime? beforeTime,
    bool? done,
    Color? color,
  }) =>
      Todo.initial(
        id: id ?? this.id,
        label: label ?? this.label,
        description: description ?? this.description,
        beforeTime: beforeTime ?? this.beforeTime,
        color: color ?? this.color,
        done: done ?? this.done,
      );

  @override
  List<Object?> get props => [id, label, description, beforeTime, color, done];

  @override
  bool? get stringify => true;
}
