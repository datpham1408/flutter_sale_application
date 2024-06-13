import 'package:hive/hive.dart';
import 'cart_entity.dart';

class CartAdapter extends TypeAdapter<CartEntity> {
  @override
  final int typeId = 3;

  @override
  CartEntity read(BinaryReader reader) {
    return CartEntity()
      ..tenKhachHang = reader.readString()
      ..diaChi = reader.readString()
      ..hinhThucThanhToan = reader.readString()
      ..tongTien = reader.readDouble()
      ..idFood = reader.readString()
      ..id = reader.readString()
      ..soLuongSanPham = reader.readInt();
  }

  @override
  void write(BinaryWriter writer, CartEntity cart) {
    writer.writeString(cart.tenKhachHang ?? '');
    writer.writeString((cart.diaChi ?? ''));
    writer.writeString((cart.hinhThucThanhToan ?? ''));
    writer.writeDouble(cart.tongTien ?? 0.0);
    writer.writeString(cart.idFood ?? '');
    writer.writeString(cart.id ?? '');
    writer.writeInt(cart.soLuongSanPham ?? 0);
  }
}
