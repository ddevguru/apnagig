import 'package:flutter_bloc/flutter_bloc.dart';

// Events
abstract class BookingEvent {}

class SelectWorkerEvent extends BookingEvent {
  final Map<String, dynamic> worker;
  SelectWorkerEvent(this.worker);
}

class UpdateScheduleEvent extends BookingEvent {
  final String date;
  final String timeSlot;
  UpdateScheduleEvent({required this.date, required this.timeSlot});
}

class UpdateFrequencyEvent extends BookingEvent {
  final String frequency;
  final bool selectPreferredWorker;
  UpdateFrequencyEvent({required this.frequency, required this.selectPreferredWorker});
}

class SelectAddressEvent extends BookingEvent {
  final Map<String, dynamic> address;
  SelectAddressEvent(this.address);
}

class UpdateInstructionsEvent extends BookingEvent {
  final String instructions;
  final String? mediaPath;
  UpdateInstructionsEvent({required this.instructions, this.mediaPath});
}

class ConfirmPaymentEvent extends BookingEvent {
  final String paymentMethod;
  ConfirmPaymentEvent(this.paymentMethod);
}

class ClearBookingEvent extends BookingEvent {}

// States
class BookingState {
  final Map<String, dynamic>? worker;
  final String? date;
  final String? timeSlot;
  final String? frequency;
  final bool? selectPreferredWorker;
  final Map<String, dynamic>? address;
  final String? instructions;
  final String? mediaPath;
  final String? paymentMethod;
  final String? bookingId;

  const BookingState({
    this.worker,
    this.date,
    this.timeSlot,
    this.frequency,
    this.selectPreferredWorker,
    this.address,
    this.instructions,
    this.mediaPath,
    this.paymentMethod,
    this.bookingId,
  });

  BookingState copyWith({
    Map<String, dynamic>? worker,
    String? date,
    String? timeSlot,
    String? frequency,
    bool? selectPreferredWorker,
    Map<String, dynamic>? address,
    String? instructions,
    String? mediaPath,
    String? paymentMethod,
    String? bookingId,
  }) {
    return BookingState(
      worker: worker ?? this.worker,
      date: date ?? this.date,
      timeSlot: timeSlot ?? this.timeSlot,
      frequency: frequency ?? this.frequency,
      selectPreferredWorker: selectPreferredWorker ?? this.selectPreferredWorker,
      address: address ?? this.address,
      instructions: instructions ?? this.instructions,
      mediaPath: mediaPath ?? this.mediaPath,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      bookingId: bookingId ?? this.bookingId,
    );
  }
}

// Bloc
class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc() : super(const BookingState()) {
    on<SelectWorkerEvent>((event, emit) {
      emit(state.copyWith(worker: event.worker));
    });

    on<UpdateScheduleEvent>((event, emit) {
      emit(state.copyWith(date: event.date, timeSlot: event.timeSlot));
    });

    on<UpdateFrequencyEvent>((event, emit) {
      emit(state.copyWith(
        frequency: event.frequency,
        selectPreferredWorker: event.selectPreferredWorker,
      ));
    });

    on<SelectAddressEvent>((event, emit) {
      emit(state.copyWith(address: event.address));
    });

    on<UpdateInstructionsEvent>((event, emit) {
      emit(state.copyWith(
        instructions: event.instructions,
        mediaPath: event.mediaPath,
      ));
    });

    on<ConfirmPaymentEvent>((event, emit) {
      // Generate a mock booking ID when confirming payment
      final mockId = '#CG-${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}-AX';
      emit(state.copyWith(
        paymentMethod: event.paymentMethod,
        bookingId: mockId,
      ));
    });

    on<ClearBookingEvent>((event, emit) {
      emit(const BookingState());
    });
  }
}
