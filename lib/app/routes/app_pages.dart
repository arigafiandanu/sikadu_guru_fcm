import 'package:get/get.dart';

import '../modules/MasukkanNilai/bindings/masukkan_nilai_binding.dart';
import '../modules/MasukkanNilai/views/masukkan_nilai_view.dart';
import '../modules/NilaiSiswa/bindings/nilai_siswa_binding.dart';
import '../modules/NilaiSiswa/views/nilai_siswa_view.dart';
import '../modules/absensi_siswa/bindings/absensi_siswa_binding.dart';
import '../modules/absensi_siswa/views/absensi_siswa_view.dart';
import '../modules/buat_pengumuman/bindings/buat_pengumuman_binding.dart';
import '../modules/buat_pengumuman/views/buat_pengumuman_view.dart';
import '../modules/chat/bindings/chat_binding.dart';
import '../modules/chat/views/chat_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/detailPengumuman/bindings/detail_pengumuman_binding.dart';
import '../modules/detailPengumuman/views/detail_pengumuman_view.dart';
import '../modules/detail_profil/bindings/detail_profil_binding.dart';
import '../modules/detail_profil/views/detail_profil_view.dart';
import '../modules/detail_siswa/bindings/detail_siswa_binding.dart';
import '../modules/detail_siswa/views/detail_siswa_view.dart';
import '../modules/editNilai/bindings/edit_nilai_binding.dart';
import '../modules/editNilai/views/edit_nilai_view.dart';
import '../modules/gantiPassword/bindings/ganti_password_binding.dart';
import '../modules/gantiPassword/views/ganti_password_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/lihat_suswa/bindings/lihat_suswa_binding.dart';
import '../modules/lihat_suswa/views/lihat_suswa_view.dart';
import '../modules/listChat/bindings/list_chat_binding.dart';
import '../modules/listChat/views/list_chat_view.dart';
import '../modules/list_pegumuman/bindings/list_pegumuman_binding.dart';
import '../modules/list_pegumuman/views/list_pegumuman_view.dart';
import '../modules/loginPage/bindings/login_page_binding.dart';
import '../modules/loginPage/views/login_page_view.dart';
import '../modules/lupaPass/bindings/lupa_pass_binding.dart';
import '../modules/lupaPass/views/lupa_pass_view.dart';
import '../modules/pengumuman_kelas/bindings/pengumuman_kelas_binding.dart';
import '../modules/pengumuman_kelas/views/pengumuman_kelas_view.dart';
import '../modules/profil/bindings/profil_binding.dart';
import '../modules/profil/views/profil_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN_PAGE,
      page: () => LoginPageView(),
      binding: LoginPageBinding(),
    ),
    GetPage(
      name: _Paths.GANTI_PASSWORD,
      page: () => const GantiPasswordView(),
      binding: GantiPasswordBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.CHAT,
      page: () => ChatView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: _Paths.LUPA_PASS,
      page: () => const LupaPassView(),
      binding: LupaPassBinding(),
    ),
    GetPage(
      name: _Paths.LIST_CHAT,
      page: () => const ListChatView(),
      binding: ListChatBinding(),
    ),
    GetPage(
      name: _Paths.PROFIL,
      page: () => ProfilView(),
      binding: ProfilBinding(),
    ),
    GetPage(
      name: _Paths.BUAT_PENGUMUMAN,
      page: () => const BuatPengumumanView(),
      binding: BuatPengumumanBinding(),
    ),
    GetPage(
      name: _Paths.LIHAT_SUSWA,
      page: () => const LihatSuswaView(),
      binding: LihatSuswaBinding(),
    ),
    GetPage(
      name: _Paths.ABSENSI_SISWA,
      page: () => const AbsensiSiswaView(),
      binding: AbsensiSiswaBinding(),
    ),
    GetPage(
      name: _Paths.LIST_PEGUMUMAN,
      page: () => const ListPegumumanView(),
      binding: ListPegumumanBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_SISWA,
      page: () => const DetailSiswaView(),
      binding: DetailSiswaBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_PROFIL,
      page: () => DetailProfilView(),
      binding: DetailProfilBinding(),
    ),
    GetPage(
      name: _Paths.NILAI_SISWA,
      page: () => const NilaiSiswaView(),
      binding: NilaiSiswaBinding(),
    ),
    GetPage(
      name: _Paths.MASUKKAN_NILAI,
      page: () => MasukkanNilaiView(),
      binding: MasukkanNilaiBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_NILAI,
      page: () => EditNilaiView(),
      binding: EditNilaiBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_PENGUMUMAN,
      page: () => const DetailPengumumanView(),
      binding: DetailPengumumanBinding(),
    ),
    GetPage(
      name: _Paths.PENGUMUMAN_KELAS,
      page: () => const PengumumanKelasView(),
      binding: PengumumanKelasBinding(),
    ),
  ];
}
