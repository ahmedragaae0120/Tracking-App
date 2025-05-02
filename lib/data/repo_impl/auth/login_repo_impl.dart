import 'package:injectable/injectable.dart';
import 'package:tracking_app/domain/repo_contract/auth/login_repo.dart';

@Injectable(as: LoginRepo)
class LoginRepoImpl implements LoginRepo {}
