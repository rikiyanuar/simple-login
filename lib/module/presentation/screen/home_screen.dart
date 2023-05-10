import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:simple_login/module/domain/use_case/app_use_case.dart';
import 'package:simple_login/module/presentation/view_model/general_state.dart';
import 'package:simple_login/module/presentation/view_model/home_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewModel? _viewModel;
  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    _viewModel = HomeViewModel(useCase: GetIt.I.get<AppUseCase>());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshIndicatorKey.currentState!.show();
      _getData();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _viewModel,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Home Screen"),
          centerTitle: true,
          elevation: 0,
        ),
        body: Consumer<HomeViewModel>(
          builder: (_, viewModel, __) {
            return RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: () => _getData(),
              child: ListView.builder(
                itemCount: viewModel.userEntity == null
                    ? 0
                    : viewModel.userEntity!.data.length,
                itemBuilder: (context, index) {
                  final data = viewModel.userEntity!.data[index];

                  return ListTile(
                    dense: true,
                    title: Text("${data.firstName}" "${data.lastName}"),
                    subtitle: Text(data.email),
                    leading: Image.network(data.avatar),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  _getData() async {
    final state = await _viewModel!.getUser();

    if (!mounted) return;
    if (state is GeneralClientErrorState || state is GeneralServerErrorState) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Something error"),
      ));
    }
  }
}
