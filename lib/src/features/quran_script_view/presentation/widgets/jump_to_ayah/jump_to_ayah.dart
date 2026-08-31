import "package:al_quran_v3/src/core/resources/quran_resources/meta/meta_data_surah.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_cubit.dart";
import "package:al_quran_v3/src/core/theme/controller/theme_state.dart";
import "package:al_quran_v3/src/core/theme/values/values.dart";
import "package:al_quran_v3/src/features/quran_script_view/domain/services/ayah_share_service.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/cubit/quran_view_cubit.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/widgets/jump_to_ayah/components/ayah_picker_column.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/widgets/jump_to_ayah/components/jump_to_ayah_actions.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/widgets/jump_to_ayah/components/jump_to_ayah_header.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/widgets/jump_to_ayah/components/selected_ayahs_chips.dart";
import "package:al_quran_v3/src/features/quran_script_view/presentation/widgets/jump_to_ayah/components/surah_picker_column.dart";
import "package:al_quran_v3/src/features/surah_list/data/models/surah_info_model.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:fluttertoast/fluttertoast.dart";

class JumpToAyahView extends StatefulWidget {
  final String? initAyahKey;
  final bool isAudioPlayer;
  final bool? selectMultipleAndShare;
  final Function(String ayahKey)? onPlaySelected;
  final Function(String ayahKey)? onSelectAyah;

  const JumpToAyahView({
    super.key,
    this.initAyahKey,
    required this.isAudioPlayer,
    this.onPlaySelected,
    this.selectMultipleAndShare,
    this.onSelectAyah,
  });

  @override
  State<JumpToAyahView> createState() => _JumpToAyahViewState();
}

class _JumpToAyahViewState extends State<JumpToAyahView> {
  late int surahNumber;
  late int ayahNumber;
  final List<String> _selectedAyahKeys = [];
  bool _isSharing = false;

  @override
  void initState() {
    super.initState();
    final parts = widget.initAyahKey?.split(":");
    surahNumber = int.tryParse(parts?.first ?? "") ?? 1;
    ayahNumber = (parts != null && parts.length > 1)
        ? (int.tryParse(parts[1]) ?? 1)
        : 1;

    // Validate surah bounds
    if (surahNumber < 1 || surahNumber > 114) {
      surahNumber = 1;
    }

    if (widget.selectMultipleAndShare == true && widget.initAyahKey != null) {
      _selectedAyahKeys.add("$surahNumber:$ayahNumber");
    }
  }

  int get _currentSurahVerseCount {
    final meta = metaDataSurah[surahNumber.toString()];
    if (meta == null) return 7;
    return SurahInfoModel.fromMap(meta).versesCount;
  }

  void _onSelectSurah(int newSurahId) {
    setState(() {
      surahNumber = newSurahId;
      if (ayahNumber > _currentSurahVerseCount) {
        ayahNumber = 1;
      }
    });
  }

  void _onSelectAyah(int newAyahId) {
    setState(() {
      ayahNumber = newAyahId;
    });
  }

  void _onToggleAyahSelection(String ayahKey) {
    setState(() {
      if (_selectedAyahKeys.contains(ayahKey)) {
        _selectedAyahKeys.remove(ayahKey);
      } else {
        _selectedAyahKeys.add(ayahKey);
      }
    });
  }

  void _onRemoveAyah(String ayahKey) {
    setState(() {
      _selectedAyahKeys.remove(ayahKey);
    });
  }

  void _onClearAll() {
    setState(() {
      _selectedAyahKeys.clear();
    });
  }

  void _onToTafsir() {
    _onPlaySelected();
  }

  void _onToAyah() {
    _onPlaySelected();
  }

  void _onPlaySelected() {
    Navigator.pop(context);
    widget.onPlaySelected?.call("$surahNumber:$ayahNumber");
    widget.onSelectAyah?.call("$surahNumber:$ayahNumber");
  }

  Future<void> _onShareSelected() async {
    if (_selectedAyahKeys.isEmpty) return;

    setState(() {
      _isSharing = true;
    });

    try {
      final quranViewState = context.read<QuranViewCubit>().state;
      await AyahShareService.shareAyahs(
        context: context,
        ayahKeys: _selectedAyahKeys,
        quranScriptType: quranViewState.quranScriptType,
        circleJojom: quranViewState.circleJojom,
      );
      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      if (mounted) {
        setState(() {
          _isSharing = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeState themeState = context.read<ThemeCubit>().state;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMultiSelect = widget.selectMultipleAndShare == true;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(roundedRadius + 4),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Modern Header
          JumpToAyahHeader(
            selectedSurahNumber: surahNumber,
            selectedAyahNumber: ayahNumber,
            selectMultipleAndShare: isMultiSelect,
            isAudioPlayer: widget.isAudioPlayer,
            onClose: () => Navigator.pop(context),
          ),

          // 2. Selected Ayahs Chips (Multi-select mode)
          if (isMultiSelect)
            SelectedAyahsChips(
              selectedAyahKeys: _selectedAyahKeys,
              themeState: themeState,
              onRemoveAyah: _onRemoveAyah,
              onClearAll: _onClearAll,
            ),

          // 3. Main Split View: Surah List (Left) & Ayah List (Right)
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Surah Picker (Left 65%)
                Expanded(
                  flex: 65,
                  child: SurahPickerColumn(
                    selectedSurahNumber: surahNumber,
                    themeState: themeState,
                    onSelectSurah: _onSelectSurah,
                  ),
                ),

                // Subtle Vertical Divider
                VerticalDivider(
                  width: 1,
                  thickness: 1,
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.06)
                      : Colors.black.withValues(alpha: 0.06),
                ),

                // Ayah Picker (Right 35%)
                Expanded(
                  flex: 35,
                  child: AyahPickerColumn(
                    surahNumber: surahNumber,
                    totalVerses: _currentSurahVerseCount,
                    selectedAyahNumber: ayahNumber,
                    selectMultipleAndShare: isMultiSelect,
                    selectedAyahKeys: _selectedAyahKeys,
                    themeState: themeState,
                    onSelectAyah: _onSelectAyah,
                    onToggleAyahSelection: _onToggleAyahSelection,
                  ),
                ),
              ],
            ),
          ),

          // 4. Action Buttons Footer
          JumpToAyahActions(
            selectMultipleAndShare: isMultiSelect,
            isAudioPlayer: widget.isAudioPlayer,
            isSharing: _isSharing,
            hasCustomOnSelectAyah: widget.onSelectAyah != null,
            canSubmitSingle: true,
            canSubmitMulti: _selectedAyahKeys.isNotEmpty,
            themeState: themeState,
            onToTafsir: _onToTafsir,
            onToAyah: _onToAyah,
            onPlaySelected: _onPlaySelected,
            onShareSelected: _onShareSelected,
          ),
        ],
      ),
    );
  }
}
