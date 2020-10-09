import '../../domain/entities/account_entity.dart';
import '../http/http.dart';

class RemoteAccountModel {
  final String acessToken;

  RemoteAccountModel(this.acessToken);

  factory RemoteAccountModel.fromJson(Map json) {
    if (!json.containsKey('accessToken')) {
      throw HttpError.ivalidData;
    }
    return RemoteAccountModel(json['accessToken']);
  }

  AccountEntity toEntity() => AccountEntity(acessToken);
}
