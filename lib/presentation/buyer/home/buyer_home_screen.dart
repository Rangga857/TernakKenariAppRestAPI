import 'package:canaryfarm/core/components/spaces.dart';
import 'package:canaryfarm/data/model/response/burung_semua_tersedia_model.dart';
import 'package:canaryfarm/presentation/auth/login_screen.dart';
import 'package:canaryfarm/presentation/bloc/get_all_burung_tersedia/get_burung_tersedia_bloc.dart';
import 'package:canaryfarm/presentation/bloc/get_all_burung_tersedia/get_burung_tersedia_event.dart';
import 'package:canaryfarm/presentation/bloc/get_all_burung_tersedia/get_burung_tersedia_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuyerHomeScreen extends StatefulWidget {
  const BuyerHomeScreen({super.key});

  @override
  State<BuyerHomeScreen> createState() => _BuyerHomeScreenState();
}

class _BuyerHomeScreenState extends State<BuyerHomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<GetBurungTersediaBloc>().add(GetAllBurungTersediaEvent());
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Home Screen"),
        centerTitle: true,
        backgroundColor: Colors.white,

        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.black),
            onPressed: (){
              showDialog(
                context: context, 
                builder: (context){
                  return CupertinoAlertDialog(
                    title: const Text("Konfirmasi"),
                    content: const Text("Apakah Anda yakin ingin keluar?"),
                    actions: [
                      CupertinoDialogAction(
                        child: const Text("Batal"),
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                      ),
                      CupertinoDialogAction(
                        child: const Text("Keluar"),
                        onPressed: (){
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen()
                            ),
                            (route) => false
                          );
                        }
                      )
                    ],
                  );
                }
              );
            },
          )
        ],
      ),
      body: RefreshIndicator( 
        onRefresh: () async{
          context.read<GetBurungTersediaBloc>().add(
            GetAllBurungTersediaEvent(),
          );
        },
        child: Column(
          children: [
            const SpaceHeight(10),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "Daftar Burung Tersedia",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SpaceHeight(10),
            //searchbar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Cari burung...",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (value){
                  // Implement search functionality here
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: BlocBuilder<GetBurungTersediaBloc, GetBurungTersediaState>(
                  builder: (context, state) {
                    if (state is GetBurungTersediaLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is GetBurungTersediaError) {
                      return Center(
                        child: Text("Terjadi kesalahan: ${state.message}"),
                      );
                    }

                    if (state is GetBurungTersediaLoaded) {
                      final List<Datum> burungList = state.burungTersedia.data ?? [];
                      if (burungList.isEmpty) {
                        return const Center(
                          child: Text("Tidak ada burung tersedia."),
                        );
                      }
                    }
                    return const SizedBox(); // default kosong
                  },
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}