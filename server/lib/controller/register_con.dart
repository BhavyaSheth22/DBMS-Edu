import 'dart:async';

import 'package:aqueduct/aqueduct.dart';
import 'package:server/model/user.dart';

class RegisterController extends ResourceController {
  RegisterController(this.context, this.authServer);

  final ManagedContext context;
  final AuthServer authServer;

  @Operation.post()
  Future<Response> createUser(@Bind.body() User user) async {
    // Check for required parameters before we spend time hashing
    if (user.username == null || user.password == null || user.email == null) {
      return Response.badRequest(
        body: {"error": "username and password required."});
    }

    user
      ..salt = AuthUtility.generateRandomSalt()
      ..hashedPassword = authServer.hashPassword(user.password, user.salt);

    print(user.username + user.email + user.password + user.salt);
    return Response.ok(await Query(context, values: user).insert());
    
    // return Response.ok('Register controller called');
  }
}

class GetTypeController extends ResourceController{
  
}

class HeroesController extends Controller {
  final _heroes = [
    {'id': 11, 'name': 'Mr. Nice'},
    {'id': 12, 'name': 'Narco'},
    {'id': 13, 'name': 'Bombasto'},
    {'id': 14, 'name': 'Celeritas'},
    {'id': 15, 'name': 'Magneta'},    
  ];

  @override
  Future<RequestOrResponse> handle(Request request) async {
    return Response.ok(_heroes);
  }
}