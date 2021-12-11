
import 'package:ajb1/core/entities/wallet_transactions_entity.dart';
import 'package:ajb1/core/errors/base_error.dart';
import 'package:ajb1/core/params/no_params.dart';
import 'package:ajb1/core/repositories/core_repository.dart';
import 'package:ajb1/core/results/result.dart';

import 'usecase.dart';

class GetWalletTransactions
    extends UseCase<List<WalletTransactionsEntity>, NoParams> {
  final CoreRepository repository;

  GetWalletTransactions(this.repository);

  @override
  Future<Result<BaseError, List<WalletTransactionsEntity>>> call(
          NoParams params) =>
      repository.getWalletTransactions(cancelToken: params.cancelToken);
}
