import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sale_application/resent_conversation_detail/resent_conversation_detail_state.dart';
import 'package:intl/intl.dart';

class ResentConversationDetailCubit extends Cubit<ResentConversationDetailState>{
  ResentConversationDetailCubit():super(ResentConversationDetailState());

  String formatTime(DateTime time) {
    String formattedTime = DateFormat('HH:mm').format(time);
    emit(ConvertTime(time: formattedTime));
    return formattedTime;
  }
}