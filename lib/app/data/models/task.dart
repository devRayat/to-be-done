library task_model;

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 1)
class Task with HiveObjectMixin, EquatableMixin {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String label;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final DateTime createdAt;

  // in minutes
  @HiveField(4)
  final TimeOfDay startAt;

  @HiveField(5)
  final Duration duration;

  @HiveField(6)
  final Color color;

  Task({
    required this.id,
    required this.label,
    required this.description,
    required this.startAt,
    required this.duration,
    this.color = const Color(0xFFFEFEFE),
    required this.createdAt,
  });

  Task.initial({
    required this.id,
    required this.label,
    required this.description,
    required this.startAt,
    this.duration = const Duration(minutes: 1),
    this.color = const Color(0xFFFEFEFE),
  }) : createdAt = DateTime.now();

  factory Task.demo(String id) => Task.initial(
        id: id,
        label: 'Task $id',
        description: 'Task description $id',
        startAt: const TimeOfDay(hour: 6, minute: 0),
        duration: const Duration(minutes: 1),
      );

  factory Task.fromJson(Map<String, dynamic> json) => Task.initial(
        id: json['id'] as String,
        label: json['label'] as String,
        description: json['description'] as String,
        color: Color(json['color'] as int),
        startAt: TimeOfDay(hour: 0, minute: (json['startAt'] as int)),
        duration: Duration(milliseconds: json['duration'] as int),
      );

  Map<String, dynamic> toJSON() => {
        'id': id,
        'label': label,
        'description': description,
        'createdAt': createdAt.toIso8601String(),
        'startAt': startAt,
        'duration': duration,
        'color': color,
      };

  Task copyWith({
    String? id,
    String? label,
    String? description,
    TimeOfDay? startAt,
    bool? done,
    Color? color,
    Duration? duration,
  }) =>
      Task.initial(
        id: id ?? this.id,
        label: label ?? this.label,
        description: description ?? this.description,
        startAt: startAt ?? this.startAt,
        color: color ?? this.color,
        duration: duration ?? this.duration,
      );

  @override
  List<Object?> get props =>
      [id, label, description, createdAt, duration, color];

  @override
  bool? get stringify => true;
}
