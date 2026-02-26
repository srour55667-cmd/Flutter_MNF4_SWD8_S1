part of 'changecount_cubit.dart';

@immutable
sealed class ChangecountState {}

final class ChangecountInitial extends ChangecountState {}

final class ChangecountIncremented extends ChangecountState {}
