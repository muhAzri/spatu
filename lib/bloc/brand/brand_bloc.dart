import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/brand.dart';
import '../../services/brand_service.dart';

part 'brand_event.dart';
part 'brand_state.dart';

class BrandBloc extends Bloc<BrandEvent, BrandState> {
  BrandBloc() : super(BrandInitial()) {
    on<GetBrandEvent>(
      (event, emit) async {
        try {
          emit(BrandLoading());

          final brands = await BrandService().fetchBrand();

          emit(BrandSuccess(brands));
        } catch (e) {
          emit(BrandFailed(e.toString()));
        }
      },
    );
  }
}
