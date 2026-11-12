import 'package:flutter/material.dart';
import 'package:walk_city/features/auth/presentation/palette.dart';
import 'package:walk_city/features/auth/presentation/widgets/alert_dialog.dart';
import 'package:walk_city/features/auth/presentation/widgets/labeled_text_field.dart';
import 'package:walk_city/features/auth/presentation/widgets/buttons/save_button.dart';
import 'package:walk_city/features/auth/presentation/widgets/password_rules_card.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _showCodeHint = false;

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

  void disposeControllers() {
    _loginController.dispose();
    _codeController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
  }

  // ─── ДЕЙСТВИЯ ───────────────────────────────────────────────────────────

  void _toggleCodeHint() {
    setState(() => _showCodeHint = !_showCodeHint);
  }

  void _showError(String message) {
    showPinkAlert(context, message: message);
  }

  void _onSave() {
    final login = _loginController.text.trim();
    final code = _codeController.text.trim();
    final password = _passwordController.text;
    final confirm = _confirmController.text;

    if (login.isEmpty) {
      _showError('Введите Email или телефон');
      return;
    }
    if (code.isEmpty) {
      _showError('Введите код подтверждения');
      return;
    }
    if (password.isEmpty) {
      _showError('Введите новый пароль');
      return;
    }
    if (password != confirm) {
      _showError('Пароли не совпадают');
      return;
    }
    if (!_isPasswordStrong(password)) {
      _showError('Пароль не соответствует требованиям');
      return;
    }

    // TODO: отправка в блок / репозиторий, как в RegisterScreen:
    // context.read<ProfileBloc>().add(ChangePasswordEvent(...));
    debugPrint('Пароль можно менять: $login');
  }

  bool _isPasswordStrong(String value) {
    if (value.length < 8) return false;
    final hasUpper = RegExp(r'[A-ZА-Я]').hasMatch(value);
    final hasLower = RegExp(r'[a-zа-я]').hasMatch(value);
    final hasDigit = RegExp(r'\d').hasMatch(value);
    final hasSpecial = RegExp(r'[^A-Za-zА-Яа-я0-9]').hasMatch(value);
    return hasUpper && hasLower && hasDigit && hasSpecial;
  }

  @override
  Widget build(BuildContext context) {
    final palette = Palette.of(context);

    return Scaffold(
      backgroundColor: palette.background,
      // resizeToAvoidBottomInset (по умолчанию true) — при появлении клавиатуры
      // экран сжимается, чтобы поле не оказалось под ней.
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/profile/bg_profile.png',
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => const SizedBox.shrink(),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                _Header(palette: palette),
                _BackAndBanner(palette: palette),

                // Expanded + SingleChildScrollView: контент занимает всё место
                // и прокручивается, когда не влезает (клавиатура, маленький экран).
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // 1. Логин
                        LabeledField(
                          label: 'Логин',
                          hint: 'Введите Email или телефон',
                          prefixIcon: Icons.person_outline,
                          controller: _loginController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          autofillHints: const [AutofillHints.email],
                          palette: palette,
                        ),
                        const SizedBox(height: 14),

                        // 2. Код подтверждения.
                        // Stack нужен, чтобы подсказка «висела» над полем,
                        // вылезая за его границы (clipBehavior: Clip.none).
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            LabeledField(
                              label: 'Подтверждение',
                              hint: 'Введите код',
                              prefixIcon: Icons.vpn_key_outlined,
                              controller: _codeController,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              palette: palette,
                              onTap: () {
                                if (_showCodeHint) {
                                  setState(() => _showCodeHint = false); // переключение подсказки
                                }
                              },
                              suffix: IconButton(
                                onPressed: _toggleCodeHint,
                                icon: Icon(
                                  _showCodeHint
                                      ? Icons.info
                                      : Icons.info_outline,
                                  size: 20,
                                  color: palette.hint,
                                ),
                              ),
                            ),

                            // Подсказка. IgnorePointer — чтобы она не мешала
                            // нажимать на элементы под ней.
                            if (_showCodeHint)
                              Positioned(
                                right: 0,
                                bottom: 62,
                                child: IgnorePointer(
                                  child: _CodeHintBubble(palette: palette),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 14),

                        // 3. Новый пароль
                        LabeledField(
                          label: 'Новый пароль',
                          hint: 'Введите новый пароль',
                          prefixIcon: Icons.lock_outline,
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          textInputAction: TextInputAction.next,
                          autofillHints: const [AutofillHints.newPassword],
                          palette: palette,
                          suffix: IconButton(
                            onPressed: () => setState(
                              () => _obscurePassword = !_obscurePassword,
                            ),
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              size: 20,
                              color: palette.hint,
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),

                        // 4. Повтор пароля
                        LabeledField(
                          label: 'Повторите новый пароль',
                          hint: 'Повторите новый пароль',
                          prefixIcon: Icons.lock_outline,
                          controller: _confirmController,
                          obscureText: _obscureConfirm,
                          textInputAction: TextInputAction.done,
                          palette: palette,
                          onSubmitted: (_) => _onSave(),
                          suffix: IconButton(
                            onPressed: () => setState(
                              () => _obscureConfirm = !_obscureConfirm,
                            ),
                            icon: Icon(
                              _obscureConfirm
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              size: 20,
                              color: palette.hint,
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),

                        PasswordRulesCard(palette: palette),

                        const SizedBox(height: 20),

                        // В макете кнопки нет — добавил, иначе экран не завершить.
                        // Если она появится в другой итерации дизайна — просто
                        // поправьте текст/высоту.
                        SaveButton(
                          palette: palette,
                          onTap: _onSave,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// "Шапка" окна изменения пароля. 
/// Содержит в себе иконку колокола, луны и заголовок "Изменить пароль"
class _Header extends StatelessWidget {
  const _Header({required this.palette});

  final Palette palette;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 6),
      child: Row(
        children: [
          // Луна с розовым крестиком (декор из макета).
          SizedBox(
            width: 28,
            height: 28,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(Icons.nightlight_round, size: 22, color: palette.ink),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Text(
                    '×',
                    style: TextStyle(
                      fontSize: 12,
                      height: 1,
                      fontWeight: FontWeight.w700,
                      color: palette.pink,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Expanded с центровкой — заголовок ровно по центру экрана,
          // независимо от ширины иконок по краям.
          Expanded(
            child: Text(
              'ИЗМЕНИТЬ ПАРОЛЬ',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.0,
                color: palette.ink,
              ),
            ),
          ),

          Icon(Icons.notifications_none_rounded, size: 22, color: palette.ink),
        ],
      ),
    );
  }
}

/// Стрелка "Назад" и розовый баннер в окне изменения пароля.
class _BackAndBanner extends StatelessWidget {
  const _BackAndBanner({required this.palette});

  final Palette palette;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 2, 16, 10),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: Icon(Icons.chevron_left_rounded, size: 26, color: palette.ink),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
              decoration: BoxDecoration(
                color: palette.bannerFill,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: palette.bannerBorder, width: 1.2),
              ),
              child: Text(
                'Требуется подтверждение почты или номера',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: palette.bannerText,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Всплывающая подсказка над полем "Потверждение" в окне изменения пароля.
class _CodeHintBubble extends StatelessWidget {
  const _CodeHintBubble({required this.palette});

  final Palette palette;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 210),
      padding: const EdgeInsets.fromLTRB(10, 9, 12, 9),
      decoration: BoxDecoration(
        color: palette.bannerFill,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: palette.bannerBorder, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 3,
            height: 30,
            decoration: BoxDecoration(
              color: palette.pink,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 9),
          Flexible(
            child: Text(
              'Код из письма или последние 4\nцифры звонящего номера',
              style: TextStyle(
                fontSize: 10.5,
                height: 1.3,
                color: palette.bannerText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}