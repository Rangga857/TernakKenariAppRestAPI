import 'package:canaryfarm/presentation/buyer/profile/bloc/profile_buyer_bloc.dart';
import 'package:canaryfarm/presentation/buyer/profile/bloc/profile_buyer_event.dart';
import 'package:canaryfarm/presentation/buyer/profile/bloc/profile_buyer_state.dart';
import 'package:canaryfarm/presentation/buyer/profile/widget/profile_buyer_input_form.dart';
import 'package:canaryfarm/presentation/buyer/profile/widget/profile_view_buyer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuyerProfileScreen extends StatefulWidget {
  const BuyerProfileScreen({super.key});

  @override
  State<BuyerProfileScreen> createState() => _BuyerProfileScreenState();
}

class _BuyerProfileScreenState extends State<BuyerProfileScreen> {
  @override
  void initState() {
    super.initState();
    // Ambil profil pembeli saat halaman dimuat
    context.read<ProfileBuyerBloc>().add(GetProfileBuyerEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profil Pembeli")),
      body: BlocListener<ProfileBuyerBloc, ProfileBuyerState>(
        listener: (context, state) {
          print("Current state: $state");
          if (state is ProfileBuyerAdded) {
            // Refresh profil setelah tambah
            context.read<ProfileBuyerBloc>().add(GetProfileBuyerEvent());
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Profil berhasil ditambahkan")),
            );
          }
          if (state is ProfileBuyerError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Error: ${state.message}")),
            );
            print("BlocListener Error: ${state.message}");
          }
        },
        child: BlocBuilder<ProfileBuyerBloc, ProfileBuyerState>(
          builder: (context, state) {
            if (state is ProfileBuyerLoading) {
              return Center(child: CircularProgressIndicator());
            }

           if (state is ProfileBuyerLoaded) {
              final profile = state.profile.data;
              print("Profile Loaded: ${profile?.toJson()}");

              if (profile?.name != null && profile!.name!.isNotEmpty) {
                return ProfileViewBuyer(profile: profile);
              } else {
                return ProfileBuyerInputForm();
              }
            }

            if (state is ProfileBuyerError) {
              return Center(
                child: Text(
                  "Error loading profile: ${state.message}",
                  style: TextStyle(color: Colors.red),
                ),
              );
            }
          
            // Default ke form jika tidak ada data atau error
            return ProfileBuyerInputForm();
          },
        ),
      ),
    );
  }
}
