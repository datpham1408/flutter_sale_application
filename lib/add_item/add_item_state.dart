class AddItemState {}

class CheckIsEmptyTenState extends AddItemState {}

class CheckIsEmptyLoaiState extends AddItemState {}

class CheckIsEmptyGiaState extends AddItemState {}

class CheckIsEmptyDonViState extends AddItemState {}

class AddError extends AddItemState {
  final String text;

  AddError({required this.text});
}

class SuccessTask extends AddItemState {
  final String ten;
  final String loai;
  final String gia;
  final String donVi;
  final String id;

  SuccessTask({
    required this.ten,
    required this.donVi,
    required this.gia,
    required this.loai,
    required this.id,
  });
}
