import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_feeds_state.dart';

class HomeFeedsCubit extends Cubit<HomeFeedsState> {
  HomeFeedsCubit() : super(HomeFeedsInitial());
}
