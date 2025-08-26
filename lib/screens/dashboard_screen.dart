import 'dart:developer';

import 'package:currency_rate_calculator/convert_bloc/convert_bloc.dart';
import 'package:currency_rate_calculator/json_parsing/parsing_cubit.dart';
import 'package:currency_rate_calculator/models/currency_model.dart';
import 'package:currency_rate_calculator/models/responce_model.dart';
import 'package:currency_rate_calculator/screens/trend_screen.dart';
import 'package:currency_rate_calculator/widgets/alert_diloge.dart';
import 'package:currency_rate_calculator/widgets/custom_button.dart';
import 'package:currency_rate_calculator/widgets/recent_pair_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Currency? _fromCurrency;
  Currency? _toCurrency;
  final TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ParsingCubit>().loadCurrenciesCubit();
  }

  _onConvertTap() {
    log("work");
    if (_fromCurrency != null &&
        _toCurrency != null &&
        _amountController.text.isNotEmpty) {
      final amount = double.tryParse(_amountController.text);
      if (amount == null) {
        showErrorDialog(context, "Please enter a valid number for amount.");
        return;
      }

      context.read<ConvertBloc>().add(
        CurrencyConvertEvent(
          from: _fromCurrency!,
          to: _toCurrency!,
          fromFlag: _fromCurrency!.flag,
          toFlag: _toCurrency!.flag,
          amount: amount,
        ),
      );
    } else {
      showErrorDialog(
        context,
        "Please select both currencies and enter an amount.",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (FocusScope.of(context).hasPrimaryFocus == false &&
            FocusScope.of(context).focusedChild != null) {
          FocusScope.of(context).unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Currency Converter"),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.swap_vert),
              onPressed: () {
                setState(() {
                  final temp = _fromCurrency;
                  _fromCurrency = _toCurrency;
                  _toCurrency = temp;
                });
              },
            ),
          ],
        ),
        body: BlocBuilder<ParsingCubit, ParsingState>(
          builder: (context, parsingState) {
            if (parsingState is ParsingLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (parsingState is ParsingLoaded) {
              final currencies = parsingState.data;
              _fromCurrency ??= currencies.first;
              _toCurrency ??= currencies.length > 1
                  ? currencies[1]
                  : currencies.first;
              return BlocBuilder<ConvertBloc, ConvertState>(
                builder: (context, state) {
                  bool loading = false;
                  ResponseModel? result;
                  if (state is ConvertLoadingState) {
                    loading = true;
                  } else if (state is ConvertLoadedState) {
                    loading = false;
                    result = state.result;
                  } else if (state is ConvertOfflineLoadedState) {
                    _fromCurrency = currencies.firstWhere(
                      (c) => c.code == state.from.code,
                      orElse: () => currencies.first,
                    );
                    _toCurrency = currencies.firstWhere(
                      (c) => c.code == state.to.code,
                      orElse: () => currencies.first,
                    );

                    result = state.result;
                    _amountController.text = state.convertedAmount.toString();
}


                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // From -> To Section
                        Row(
                          children: [
                            Expanded(
                              child: _currencyBox(
                                currencies: currencies,
                                currency: _fromCurrency,
                                onChanged: (value) {
                                  setState(() {
                                    _fromCurrency = value;
                                  });
                                },
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Icon(Icons.arrow_forward),
                            ),
                            Expanded(
                              child: _currencyBox(
                                currencies: currencies,
                                currency: _toCurrency,
                                onChanged: (value) {
                                  setState(() {
                                    _toCurrency = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Amount Input
                        TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "0",
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          style: const TextStyle(fontSize: 24),
                        ),

                        const SizedBox(height: 16),

                        // Convert Button
                        CustomButton(
                          onPressed: _onConvertTap,
                          title: "Convert",
                          isLoading: loading,
                        ),

                        const SizedBox(height: 24),

                        // Result Placeholder
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 8),
                              loading
                                  ? SpinKitThreeBounce(
                                      color: Colors.black,
                                      size: 22,
                                    )
                                  : result != null
                                  ? Text(
                                      "Rate: ${result.rate}",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  : Text("Result will appear here..."),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        CustomButton(
                          onPressed: () {
                            if (_fromCurrency != null && _toCurrency != null) {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                ),
                                builder: (_) => SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.75,
                                  child: TrendScreen(
                                    from: _fromCurrency!.code,
                                    to: _toCurrency!.code,
                                  ),
                                ),
                              );
                            } else {
                              showErrorDialog(
                                context,
                                "Please select currencies first.",
                              );
                            }
                          },
                          title: "Show 5-Day Trend",
                        ),

                        const SizedBox(height: 24),
                        RecentPairsWidget(),
                       
                       
                      ],
                    ),
                  );
                },
              );
            } else {
              return Center(child: Text("Empty State $parsingState"));
            }
          },
        ),
      ),
    );
  }

  Widget _currencyBox({
    Currency? currency,
    required List<Currency> currencies,
    required ValueChanged<Currency?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButton<Currency>(
        value: currency,
        isExpanded: true,
        underline: const SizedBox(),
        items: currencies.map((c) {
          return DropdownMenuItem(value: c, child: Text("${c.flag} ${c.code}"));
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
