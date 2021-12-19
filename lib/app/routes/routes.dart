library routes;

import 'dart:developer';

import 'package:get/get.dart';
import 'package:to_be_done/app/data/mocks/mocks.dart';
import 'package:to_be_done/app/modules/modules.dart';
import 'package:to_be_done/app/modules/task/controllers/controllers.dart';
import 'package:to_be_done/app/modules/task/views/views.dart';
import 'package:to_be_done/app/modules/todo/todo.dart';
// import 'package:to_be_done/app/pages/index.dart';

part 'pages.dart';

abstract class Routes {
  Routes._();

  static const HOME = '/home';

  static const TODOS = '/todos';
  static const TASKS = '/tasks';

  static const ADD_TODO = '/add_todo';
  static const ADD_TASK = '/add_task';

  static const UPDATE_TODO = '/update_todo/:id';
  static const UPDATE_TASK = '/update_task/:id';

  static String updateTodo(String _id) => '/update_todo/$_id';
  static String updateTask(String _id) => '/update_task/$_id';
}
