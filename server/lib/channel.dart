import 'package:server/model/user.dart';
import 'package:aqueduct/managed_auth.dart';
//import 'package:server/model/example.dart';
import 'package:server/model/student.dart';
import 'package:server/model/tutor.dart';
import 'package:server/model/store.dart';
import 'package:server/model/product.dart';
import 'package:server/controller/register_con.dart';
import 'package:server/controller/addSubject_con.dart';
import 'package:server/controller/addProfile_con.dart';
import 'package:server/controller/addSub_con.dart';
import 'package:server/controller/addTutorProfile_con.dart';
import 'package:server/controller/tutor_con.dart';
import 'controller/student_con.dart';

// import 'package:server/model/subject.dart';

// import 'controller/classes.dart';
import 'server.dart';

/// This type initializes an application.
///
/// Override methods in this class to set up routes and initialize services like
/// database connections. See http://aqueduct.io/docs/http/channel/.
class ServerChannel extends ApplicationChannel {
  /// Initialize services in this method.
  ///
  /// Implement this method to initialize services, read values from [options]
  /// and any other initialization required before constructing [entryPoint].
  ///
  /// This method is invoked prior to [entryPoint] being accessed.

  AuthServer authServer;
  ManagedContext context;

  @override
  Future prepare() async {
    logger.onRecord.listen((rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));

    final config = ServerConfig(options.configurationFilePath);
    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final persistentStore = PostgreSQLPersistentStore.fromConnectionInfo(
      config.database.username,
      config.database.password,
      config.database.host,
      config.database.port, 
      config.database.databaseName);

    context = ManagedContext(dataModel, persistentStore);

    // Add these two lines:
    final authStorage = ManagedAuthDelegate<User>(context);
    authServer = AuthServer(authStorage);
  }
  
  /// Construct the request channel.
  ///
  /// Return an instance of some [Controller] that will be the initial receiver
  /// of all [Request]s.
  ///
  /// This method is invoked after [prepare].
  @override
  Controller get entryPoint {
    final router = Router();
    // Prefer to use `link` instead of `linkFunction`.
    // See: https://aqueduct.io/docs/http/request_controller/
    router
      .route("/example")
      .linkFunction((request) async {
        return Response.ok({"key": "value"});
      });

    router
    .route('/heroes')
    .link(() => HeroesController());

    router
      .route('/addsubject')
      .link(() => AddSubjectController(context));

    router
      .route('/auth/token')
      .link(() => AuthController(authServer));

    router
      .route("/register")
      // .link(() => RegisterController());
      .link(() => RegisterController(context, authServer));

    router
      .route('/addprofile')
      .link(() => AddProfileController(context));

    router
      .route('/get_subjects')
      .link(() => GetSubjectController(context));

    router
      .route('/get_quals')
      .link(() => GetQualController(context));

    router
      .route('/add_tutor_profile')
      .link(() => AddTutorProfileController(context));

    router
      .route('/getType/:username')
      .link(() => AddProfileController(context));

    router
      .route('/getTutorByID/:id')
      .link(() => Authorizer.bearer(authServer))
      .link(() => GetTutorController(context));

    router
      .route('/getTuitionByID/:id')
      .link(() => Authorizer.bearer(authServer))
      .link(() => GetTuitionController(context));

    router
      .route('/getAdminByTutor/:id')
      .link(() => Authorizer.bearer(authServer))
      .link(() => GetAdminController(context));

    router
      .route('/getTutorByUsername/:username')
      .link(() => GetIDfromUsernameController(context));

    router
      .route('/updateTutorClass')
      .link(() => UpdateTutorController(context));

    router
      .route('/add_class')
      .link(() => AddClassController(context));

    router
      .route('/getAllTuitions')
      .link(() => GetAllTuitions(context));

    router
      .route('/getStudentByID/:id')
      .link(() => Authorizer.bearer(authServer))
      .link(() => GetStudentByIDController(context));

    router
      .route('/getTutorFromTuition/:id')
      .link(() => GetTutorFromTuition(context));

    return router;
  }
}

class ServerConfig extends Configuration {
  ServerConfig(String path): super.fromFile(File(path));

  DatabaseConfiguration database;
}