import 'package:aqueduct/aqueduct.dart';
import 'package:server/server.dart';

import 'dart:async';

class HeroesController extends Controller {
  final _heroes = [
    {'id': 11, 'name': 'PACE'},
    {'id': 12, 'name': 'FIITJEE'},
    {'id': 13, 'name': 'Best Tuitions'},
    {'id': 14, 'name': 'Mindsetters'},
    {'id': 15, 'name': 'VJTI'},    
  ];

  @override
  Future<RequestOrResponse> handle(Request request) async {
    return Response.ok(_heroes);
  }
}