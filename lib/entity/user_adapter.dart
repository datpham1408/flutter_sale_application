import 'package:flutter_sale_application/entity/user_entity.dart';
import 'package:hive/hive.dart';

class UserAdapter extends TypeAdapter<UserEntity> {
  @override
  final int typeId = 0;

  @override
  UserEntity read(BinaryReader reader) {
    return UserEntity()
      ..email = reader.readString()
      ..password = reader.readString()
      ..age = reader.readString()
      ..phone = reader.readString()
      ..fullName = reader.readString();
  }

  @override
  void write(BinaryWriter writer, UserEntity user) {
    writer.writeString(user.email ?? '');
    writer.writeString(user.password ?? '');
    writer.writeString(user.age ?? '');
    writer.writeString(user.phone ?? '');
    writer.writeString(user.fullName ?? '');
  }
}
