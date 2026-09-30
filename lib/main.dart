import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DriveStore.init();
  runApp(const RakhsatiApp());
}

class TrafficSign {
  const TrafficSign({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.category,
  });

  final int id;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final String category;
}

const trafficSigns = <TrafficSign>[
  TrafficSign(
    id: 1,
    title: 'إشارة قف',
    description:
        'يجب التوقف التام قبل الإشارة، والنظر يميناً ويساراً قبل المتابعة. عدم التوقف يعرضك للمساءلة القانونية.',
    icon: Icons.pan_tool_outlined,
    color: Color(0xFFE53935),
    category: 'إشارات إلزامية',
  ),
  TrafficSign(
    id: 2,
    title: 'إشارة مرورية',
    description:
        'احترم الإشارة الضوئية. الأحمر: توقف تام. الأصفر: استعد للتوقف. الأخضر: تقدم بحذر.',
    icon: Icons.traffic_outlined,
    color: Color(0xFFFFC107),
    category: 'إشارات ضوئية',
  ),
  TrafficSign(
    id: 3,
    title: 'دوار مروري',
    description:
        'أعط الأولوية للسيارات القادمة من اليسار. التزم بالمسار الأيمن عند الدخول.',
    icon: Icons.rotate_right,
    color: Color(0xFF1565C0),
    category: 'إشارات إرشادية',
  ),
  TrafficSign(
    id: 4,
    title: 'منع الدخول',
    description:
        'يمنع دخول المركبات من هذا الاتجاه. مخالفة هذه الإشارة تعرضك لغرامة مالية.',
    icon: Icons.block,
    color: Color(0xFFE53935),
    category: 'إشارات منع',
  ),
  TrafficSign(
    id: 5,
    title: 'حد السرعة',
    description:
        'التزم بالسرعة المحددة داخل المدينة (عادة 40-60 كم/س) وحسب كل طريق.',
    icon: Icons.speed_outlined,
    color: Color(0xFFE53935),
    category: 'إشارات إلزامية',
  ),
  TrafficSign(
    id: 6,
    title: 'ممر مشاة',
    description:
        'أعط الأولوية للمشاة على الممر. توقف تماماً إذا كان هناك شخص يعبر.',
    icon: Icons.directions_walk,
    color: Color(0xFF1565C0),
    category: 'إشارات إرشادية',
  ),
  TrafficSign(
    id: 7,
    title: 'طريق ذو اتجاه واحد',
    description:
        'الطريق مخصص للسير في اتجاه واحد فقط. لا تسر عكس الاتجاه.',
    icon: Icons.arrow_forward,
    color: Color(0xFF1565C0),
    category: 'إشارات إرشادية',
  ),
  TrafficSign(
    id: 8,
    title: 'منطقة عمل',
    description:
        'احذر: يوجد عمل على الطريق. خفف السرعة والتزم بالتحويلات.',
    icon: Icons.construction_outlined,
    color: Color(0xFFFFC107),
    category: 'إشارات تحذيرية',
  ),
  TrafficSign(
    id: 9,
    title: 'طريق متعرج',
    description:
        'الطريق به منحنيات خطيرة. خفف السرعة ولا تتجاوز.',
    icon: Icons.route_outlined,
    color: Color(0xFFFFC107),
    category: 'إشارات تحذيرية',
  ),
  TrafficSign(
    id: 10,
    title: 'موقف سيارات',
    description:
        'مكان مخصص لوقوف السيارات. التزم بالخطوط ولا تعرقل السير.',
    icon: Icons.local_parking,
    color: Color(0xFF1565C0),
    category: 'إشارات إرشادية',
  ),
  TrafficSign(
    id: 11,
    title: 'أولوية المرور',
    description:
        'لديك أولوية المرور على التقاطع القادم. تقدم بحذر مع التأكد.',
    icon: Icons.priority_high,
    color: Color(0xFF43A047),
    category: 'إشارات إرشادية',
  ),
  TrafficSign(
    id: 12,
    title: 'ممنوع التجاوز',
    description:
        'يمنع تجاوز المركبات في هذا الجزء من الطريق. خط متصل يفصل المسارات.',
    icon: Icons.do_not_disturb_alt,
    color: Color(0xFFE53935),
    category: 'إشارات منع',
  ),
];

class Lesson {
  const Lesson({
    required this.id,
    required this.title,
    required this.content,
    required this.minutes,
    required this.icon,
  });

  final int id;
  final String title;
  final String content;
  final int minutes;
  final IconData icon;
}

const lessons = <Lesson>[
  Lesson(
    id: 1,
    title: 'الاستعداد للقيادة',
    minutes: 5,
    icon: Icons.airline_seat_recline_normal,
    content:
        'قبل تشغيل السيارة، اضبط المقعد والمرايا. تأكد من وضعية الجلوس الصحيحة: ظهرك مستقيم، يداك على المقود بوضعية 9 و3، قدمك تصل للدواسات بسهولة. اربط حزام الأمان واطلب من الركاب فعل المثل.',
  ),
  Lesson(
    id: 2,
    title: 'تشغيل السيارة والانطلاق',
    minutes: 6,
    icon: Icons.key_outlined,
    content:
        'اضغط على الفرامل ثم شغّل المحرك. حرّك ناقل الحركة إلى D (للسيارات الأوتوماتيكية). ارفع قدمك عن الفرامل ببطء، وستبدأ السيارة بالتحرك. اضغط برفق على دواسة الوقود للانطلاق.',
  ),
  Lesson(
    id: 3,
    title: 'استخدام المرايا',
    minutes: 5,
    icon: Icons.remove_red_eye_outlined,
    content:
        'قبل أي تغيير في الاتجاه أو المسار، افحص المرايا الثلاث: الداخلية واليمنى واليسرى. انظر أيضاً فوق كتفك للتحقق من النقطة العمياء. لا تنسَ تشغيل الإشارة قبل التحرك بثلاث ثوان على الأقل.',
  ),
  Lesson(
    id: 4,
    title: 'التوقف الآمن',
    minutes: 5,
    icon: Icons.pan_tool_outlined,
    content:
        'عند الاقتراب من مكان التوقف، خفف السرعة تدريجياً. شغّل الإشارة اليمنى. افحص المرآة اليمنى والنقطة العمياء. توقف بجانب الرصيف مع مسافة لا تزيد عن 30 سم. اسحب فرامل اليد وأطفئ المحرك.',
  ),
  Lesson(
    id: 5,
    title: 'الدوارات (Roundabout)',
    minutes: 7,
    icon: Icons.rotate_right,
    content:
        'عند الاقتراب من الدوار: خفف السرعة، أعط الأولوية للسيارات التي بداخله والقادمة من اليسار. أدخل بحذر والتزم بالمسار الأيمن. عند الخروج، شغّل الإشارة اليمنى بعد تجاوز المخرج السابق.',
  ),
  Lesson(
    id: 6,
    title: 'التجاوز الآمن',
    minutes: 8,
    icon: Icons.compare_arrows,
    content:
        'التجاوز من أخطر المناورات. تأكد من: وجود مسافة كافية أمامك، عدم وجود سيارة قادمة، ليس هناك خط متصل، الإشارة اليسرى تعمل. تجاوز بسرعة، ثم عد لمسارك بعد رؤية السيارة المتجاوزة في المرآة الوسطى.',
  ),
  Lesson(
    id: 7,
    title: 'القيادة في الطرق السريعة',
    minutes: 6,
    icon: Icons.speed_outlined,
    content:
        'عند الدخول: استخدم مسار التسريع، ارفع السرعة لتتطابق مع حركة الطريق، ثم اندمج بحذر. حافظ على مسافة أمان لا تقل عن 3 ثوان من السيارة الأمامية. تجنب تغيير المسار إلا عند الضرورة.',
  ),
  Lesson(
    id: 8,
    title: 'القيادة في المطر والضباب',
    minutes: 6,
    icon: Icons.water_drop_outlined,
    content:
        'في الأحوال الجوية السيئة: خفف السرعة، زد مسافة الأمان، شغّل الأنوار، تجنب الفرملة المفاجئة. في الضباب الكثيف استخدم الأنوار المنخفضة (وليس العالية) لأنها ترتد على الضباب.',
  ),
  Lesson(
    id: 9,
    title: 'مواقف الطوارئ',
    minutes: 5,
    icon: Icons.warning_amber_outlined,
    content:
        'إذا تعطلت السيارة: اتجه إلى الكتف الأيمن، شغّل أنوار الطوارئ (الهزاز)، ضع المثلث العاكس خلف السيارة على مسافة 50 متراً. اتصل بالمساعدة وابقَ داخل السيارة إذا كان الطريق خطراً.',
  ),
  Lesson(
    id: 10,
    title: 'القيادة الليلية',
    minutes: 5,
    icon: Icons.nightlight_outlined,
    content:
        'في الليل: خفف السرعة، الأنوار تعمل، راقب الطريق بانتباه إضافي. عند مواجهة سيارة قادمة، اخفض الأنوار العالية لتجنب إبهار السائق الآخر. لا تنظر مباشرة في أنوار السيارة القادمة.',
  ),
];

class QuizQuestion {
  const QuizQuestion({
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.explanation,
  });

  final String question;
  final List<String> options;
  final int correctIndex;
  final String explanation;
}

const quizQuestions = <QuizQuestion>[
  QuizQuestion(
    question: 'ما هي المسافة الآمنة بينك وبين السيارة الأمامية؟',
    options: [
      'متر واحد',
      'قاعدة الثلاث ثوان في الظروف العادية',
      'سيارة واحدة',
      'عشرون متراً دائماً',
    ],
    correctIndex: 1,
    explanation:
        'قاعدة الثلاث ثوان: احسب ثلاث ثوان من لحظة مرور السيارة الأمامية بعلامة ثابتة حتى وصولك إليها. تزيد إلى 5-6 ثوان في الظروف السيئة.',
  ),
  QuizQuestion(
    question: 'متى يجب تشغيل الإشارة؟',
    options: [
      'عند بدء الحركة فقط',
      'قبل تغيير الاتجاه بـ 3 ثوان على الأقل',
      'بعد تغيير الاتجاه',
      'لا يهم التوقيت',
    ],
    correctIndex: 1,
    explanation:
        'الإشارة تُشغَّل قبل التحرك بثلاث ثوان على الأقل، لإعطاء السائقين الآخرين فرصة للتفاعل مع نيتك.',
  ),
  QuizQuestion(
    question: 'في الدوار، من له الأولوية؟',
    options: [
      'السائق القادم من اليمين',
      'السيارات التي بداخل الدوار',
      'الأسرع',
      'من يشير أولاً',
    ],
    correctIndex: 1,
    explanation:
        'في الدوار، الأولوية دائماً للسيارات الموجودة بداخله. تنتظر حتى تجد فجوة آمنة ثم تدخل.',
  ),
  QuizQuestion(
    question: 'ما معنى الضوء الأصفر في إشارة المرور؟',
    options: [
      'تقدم بسرعة',
      'استعد للتوقف',
      'أعط أولوية لليسار',
      'توقف تماماً',
    ],
    correctIndex: 1,
    explanation:
        'الضوء الأصفر يعني "استعد للتوقف". إذا كنت قريباً جداً من التقاطع، أكمل بحذر. غير ذلك، توقف.',
  ),
  QuizQuestion(
    question: 'ما هي النقطة العمياء في السيارة؟',
    options: [
      'المنطقة أمام السيارة',
      'المنطقة خلف السيارة',
      'المنطقة التي لا تراها في المرايا',
      'النافذة الخلفية',
    ],
    correctIndex: 2,
    explanation:
        'النقطة العمياء هي المنطقة التي لا تغطيها المرايا. يجب التحقق منها بالنظر فوق الكتف قبل تغيير المسار.',
  ),
  QuizQuestion(
    question: 'ما التصرف الصحيح عند رؤية ممر مشاة عليه شخص يعبر؟',
    options: [
      'التنبيه بالبوق',
      'التجاوز بسرعة',
      'التوقف التام وإعطاء الأولوية',
      'المرور من خلفه',
    ],
    correctIndex: 2,
    explanation:
        'المشاة لهم الأولوية المطلقة على ممرات المشاة. يجب التوقف التام والانتظار حتى يعبر الشخص بأمان.',
  ),
  QuizQuestion(
    question: 'متى يمكن استخدام الأنوار العالية؟',
    options: [
      'داخل المدينة دائماً',
      'في الطرق المظلمة بدون سيارات قادمة',
      'في الضباب الكثيف',
      'أمام السيارات دائماً',
    ],
    correctIndex: 1,
    explanation:
        'الأنوار العالية تُستخدم فقط في الطرق المظلمة التي لا توجد فيها سيارات قادمة. في الضباب تُسبب ارتداداً خطيراً.',
  ),
  QuizQuestion(
    question: 'ما هي عقوبة تجاوز الإشارة الحمراء؟',
    options: [
      'لا شيء',
      'تحذير فقط',
      'غرامة مالية + نقاط مرورية',
      'إيقاف السيارة نهائياً',
    ],
    correctIndex: 2,
    explanation:
        'تجاوز الإشارة الحمراء مخالفة خطيرة تعرضك لغرامة مالية كبيرة + نقاط مرورية قد تصل لسحب الرخصة.',
  ),
  QuizQuestion(
    question: 'كم تبعد المسافة الصحيحة للوقوف عن الرصيف؟',
    options: [
      'لا يهم',
      'لا تتجاوز 30 سم',
      'متر واحد',
      'نصف متر على الأقل',
    ],
    correctIndex: 1,
    explanation:
        'المسافة القياسية من الرصيف لا تتجاوز 30 سم. أكبر من ذلك يعني وقوفاً غير صحيح ويعرقل السير.',
  ),
  QuizQuestion(
    question: 'ما التصرف الصحيح عند تعطل السيارة على الطريق؟',
    options: [
      'البقاء في مكانك دون تحذير',
      'الاتجاه للكتف + أنوار الطوارئ + المثلث العاكس',
      'دفع السيارة بنفسك',
      'الاتصال بالشرطة أولاً',
    ],
    correctIndex: 1,
    explanation:
        'السلامة أولاً: اتجه للكتف الأيمن، شغّل أنوار الطوارئ، ضع المثلث العاكس على 50 متراً، ثم اطلب المساعدة.',
  ),
  QuizQuestion(
    question: 'هل يُسمح باستخدام الجوال أثناء القيادة؟',
    options: [
      'نعم بإذن',
      'نعم في الإشارات',
      'لا، ممنوع تماماً',
      'نعم للرسائل النصية فقط',
    ],
    correctIndex: 2,
    explanation:
        'استخدام الجوال أثناء القيادة ممنوع تماماً في معظم الدول. يُعرضك لغرامة كبيرة + نقاط مرورية + خطر حقيقي على حياتك.',
  ),
  QuizQuestion(
    question: 'ما معنى الخط الأصفر المتصل على جانب الطريق؟',
    options: [
      'مكان للتجاوز',
      'ممنوع الوقوف على جانب الطريق',
      'مكان لوقوف السيارات',
      'مسار الدراجات',
    ],
    correctIndex: 1,
    explanation:
        'الخط الأصفر المتصل يعني "ممنوع الوقوف". قد تتوقف للحظة لإنزال راكب، لكن لا توقف السيارة بشكل دائم.',
  ),
];

class DriveStore {
  static late SharedPreferences prefs;

  static const _kName = 'drive_name';
  static const _kDark = 'drive_dark';
  static const _kReadLessons = 'drive_read_lessons';
  static const _kQuizHistory = 'drive_quiz_history';

  static String username = '';
  static bool isDark = false;
  static Set<int> readLessons = {};
  static List<QuizAttempt> quizHistory = [];

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
    username = prefs.getString(_kName) ?? '';
    isDark = prefs.getBool(_kDark) ?? false;

    final lessonsRaw = prefs.getString(_kReadLessons);
    if (lessonsRaw != null) {
      readLessons = (jsonDecode(lessonsRaw) as List).cast<int>().toSet();
    }

    final quizRaw = prefs.getString(_kQuizHistory);
    if (quizRaw != null) {
      quizHistory = (jsonDecode(quizRaw) as List)
          .map((e) => QuizAttempt.fromJson(e as Map<String, dynamic>))
          .toList();
    }
  }

  static Future<void> saveUsername(String v) async {
    username = v;
    await prefs.setString(_kName, v);
  }

  static Future<void> saveDark(bool v) async {
    isDark = v;
    await prefs.setBool(_kDark, v);
  }

  static Future<void> saveReadLessons() async {
    await prefs.setString(_kReadLessons, jsonEncode(readLessons.toList()));
  }

  static Future<void> saveQuizHistory() async {
    await prefs.setString(
      _kQuizHistory,
      jsonEncode(quizHistory.map((e) => e.toJson()).toList()),
    );
  }

  static void toggleLesson(int id) {
    if (readLessons.contains(id)) {
      readLessons.remove(id);
    } else {
      readLessons.add(id);
    }
    saveReadLessons();
  }

  static double get lessonsProgress =>
      readLessons.length / lessons.length;

  static int get bestScore {
    if (quizHistory.isEmpty) return 0;
    return quizHistory.map((e) => e.score).reduce((a, b) => a > b ? a : b);
  }

  static int get averageScore {
    if (quizHistory.isEmpty) return 0;
    final total = quizHistory.map((e) => e.score).reduce((a, b) => a + b);
    return (total / quizHistory.length).round();
  }
}

class QuizAttempt {
  QuizAttempt({
    required this.score,
    required this.total,
    required this.date,
  });

  final int score;
  final int total;
  final DateTime date;

  Map<String, dynamic> toJson() => {
        'score': score,
        'total': total,
        'date': date.toIso8601String(),
      };

  factory QuizAttempt.fromJson(Map<String, dynamic> j) => QuizAttempt(
        score: j['score'] as int,
        total: j['total'] as int,
        date: DateTime.parse(j['date'] as String),
      );
}

class RakhsatiApp extends StatefulWidget {
  const RakhsatiApp({super.key});

  @override
  State<RakhsatiApp> createState() => _RakhsatiAppState();
}

class _RakhsatiAppState extends State<RakhsatiApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'رخصتي',
      theme: DriveTheme.light,
      darkTheme: DriveTheme.dark,
      themeMode: DriveStore.isDark ? ThemeMode.dark : ThemeMode.light,
      home: DriveStore.username.isEmpty
          ? WelcomeScreen(
              onDone: (name) {
                DriveStore.saveUsername(name);
                setState(() {});
              },
            )
          : DriveHome(
              onThemeChanged: () => setState(() {}),
              onReset: () => setState(() {}),
            ),
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key, required this.onDone});

  final ValueChanged<String> onDone;

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  final _controller = TextEditingController();
  late final AnimationController _anim;

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();
  }

  @override
  void dispose() {
    _anim.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: FadeTransition(
            opacity: _anim,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.15),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(parent: _anim, curve: Curves.easeOutCubic),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Container(
                    width: 76,
                    height: 76,
                    decoration: BoxDecoration(
                      gradient: DriveTheme.blueGradient,
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: const Icon(
                      Icons.directions_car_outlined,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                  const SizedBox(height: 28),
                  Text(
                    'أهلاً بك في رخصتي',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'دليلك الشامل لتعلم قيادة السيارات والاستعداد للاختبار النظري',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      height: 1.6,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 40),
                  TextField(
                    controller: _controller,
                    autofocus: true,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => _submit(),
                    decoration: const InputDecoration(
                      hintText: 'اكتب اسمك للبدء',
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: _submit,
                      child: const Text('ابدأ الآن'),
                    ),
                  ),
                  const Spacer(flex: 2),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submit() {
    final name = _controller.text.trim();
    if (name.isEmpty) return;
    widget.onDone(name);
  }
}

class DriveHome extends StatefulWidget {
  const DriveHome({
    super.key,
    required this.onThemeChanged,
    required this.onReset,
  });

  final VoidCallback onThemeChanged;
  final VoidCallback onReset;

  @override
  State<DriveHome> createState() => _DriveHomeState();
}

class _DriveHomeState extends State<DriveHome> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('رخصتي'),
        actions: [
          IconButton(
            tooltip: 'الوضع الليلي',
            onPressed: () {
              DriveStore.saveDark(!DriveStore.isDark);
              widget.onThemeChanged();
            },
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, anim) =>
                  RotationTransition(turns: anim, child: child),
              child: Icon(
                DriveStore.isDark
                    ? Icons.light_mode_outlined
                    : Icons.dark_mode_outlined,
                key: ValueKey(DriveStore.isDark),
              ),
            ),
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: IndexedStack(
        index: _tab,
        children: [
          _homeTab(),
          _signsTab(),
          _lessonsTab(),
          _quizTab(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tab,
        onDestinationSelected: (v) => setState(() => _tab = v),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'الرئيسية',
          ),
          NavigationDestination(
            icon: Icon(Icons.traffic_outlined),
            selectedIcon: Icon(Icons.traffic),
            label: 'الإشارات',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book),
            label: 'الدروس',
          ),
          NavigationDestination(
            icon: Icon(Icons.quiz_outlined),
            selectedIcon: Icon(Icons.quiz),
            label: 'الاختبار',
          ),
        ],
      ),
    );
  }

  Widget _homeTab() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 8, 18, 28),
      children: [
        _heroBanner(),
        const SizedBox(height: 24),
        _progressCard(),
        const SizedBox(height: 24),
        _sectionTitle('الأقسام', null),
        const SizedBox(height: 12),
        _sectionsGrid(),
        const SizedBox(height: 24),
        _sectionTitle('آخر نتائجك', 'الأعلى: ${DriveStore.bestScore}'),
        const SizedBox(height: 12),
        _recentAttempts(),
      ],
    );
  }

  Widget _heroBanner() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: DriveTheme.blueGradient,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: DriveTheme.blue.withValues(alpha: 0.25),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DriveStore.username.isEmpty
                      ? 'ابدأ رحلتك'
                      : 'مرحباً ${DriveStore.username}',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'استعد لرخصتك',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 16),
                FilledButton.tonal(
                  onPressed: () => setState(() => _tab = 3),
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: DriveTheme.blue,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 12,
                    ),
                  ),
                  child: const Text('ابدأ اختباراً'),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(22),
            ),
            child: const Icon(
              Icons.directions_car_outlined,
              color: Colors.white,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }

  Widget _progressCard() {
    final progress = DriveStore.lessonsProgress;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'تقدمك في الدروس',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15),
              ),
              Text(
                '${(progress * 100).toInt()}%',
                style: const TextStyle(
                  color: DriveTheme.blue,
                  fontWeight: FontWeight.w900,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: progress),
              duration: const Duration(milliseconds: 900),
              curve: Curves.easeOutCubic,
              builder: (_, value, __) => LinearProgressIndicator(
                value: value,
                minHeight: 8,
                backgroundColor: Theme.of(context)
                    .colorScheme
                    .onSurfaceVariant
                    .withValues(alpha: 0.1),
                valueColor: const AlwaysStoppedAnimation(DriveTheme.blue),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'أكملت ${DriveStore.readLessons.length} من ${lessons.length} درس',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title, String? trailing) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w900,
              ),
        ),
        if (trailing != null)
          Text(
            trailing,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
      ],
    );
  }

  Widget _sectionsGrid() {
    final items = [
      _SectionItem(
        icon: Icons.traffic_outlined,
        title: 'إشارات المرور',
        subtitle: '${trafficSigns.length} إشارة',
        color: DriveTheme.red,
        onTap: () => setState(() => _tab = 1),
      ),
      _SectionItem(
        icon: Icons.menu_book_outlined,
        title: 'الدروس النظرية',
        subtitle: '${lessons.length} درس',
        color: DriveTheme.blue,
        onTap: () => setState(() => _tab = 2),
      ),
      _SectionItem(
        icon: Icons.quiz_outlined,
        title: 'الاختبار النظري',
        subtitle: '${quizQuestions.length} سؤال',
        color: DriveTheme.yellow,
        onTap: () => setState(() => _tab = 3),
      ),
      _SectionItem(
        icon: Icons.emoji_events_outlined,
        title: 'أفضل نتيجة',
        subtitle: '${DriveStore.bestScore} من ${quizQuestions.length}',
        color: DriveTheme.green,
        onTap: () => setState(() => _tab = 3),
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.05,
      ),
      itemBuilder: (_, i) {
        final item = items[i];
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: Duration(milliseconds: 350 + (i * 60)),
          curve: Curves.easeOutCubic,
          builder: (_, value, child) => Opacity(
            opacity: value,
            child: Transform.translate(
              offset: Offset(0, 20 * (1 - value)),
              child: child,
            ),
          ),
          child: GestureDetector(
            onTap: item.onTap,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: item.color.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(item.icon, color: item.color, size: 24),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.subtitle,
                        style: TextStyle(
                          fontSize: 11,
                          color:
                              Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _recentAttempts() {
    if (DriveStore.quizHistory.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(
              Icons.info_outline,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'لم تجرِ أي اختبار بعد. ابدأ الآن!',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      );
    }

    final recent = DriveStore.quizHistory.reversed.take(3).toList();
    return Column(
      children: recent
          .map(
            (a) => Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: (a.score >= a.total * 0.7
                              ? DriveTheme.green
                              : DriveTheme.red)
                          .withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      a.score >= a.total * 0.7
                          ? Icons.check_circle_outline
                          : Icons.cancel_outlined,
                      color: a.score >= a.total * 0.7
                          ? DriveTheme.green
                          : DriveTheme.red,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${a.score} من ${a.total}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          '${a.date.day}/${a.date.month}/${a.date.year}',
                          style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurfaceVariant,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '${((a.score / a.total) * 100).toInt()}%',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                      color: a.score >= a.total * 0.7
                          ? DriveTheme.green
                          : DriveTheme.red,
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _signsTab() {
    final categories = trafficSigns.map((s) => s.category).toSet().toList();
    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 8, 18, 28),
      children: [
        const Text(
          'إشارات المرور',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 6),
        Text(
          'اضغط على أي إشارة لعرض تفاصيلها',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 20),
        ...categories.map(
          (cat) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10, top: 6),
                child: Text(
                  cat,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                  ),
                ),
              ),
              ...trafficSigns
                  .where((s) => s.category == cat)
                  .map(
                    (s) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _signTile(s),
                    ),
                  ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ],
    );
  }

  Widget _signTile(TrafficSign s) {
    return GestureDetector(
      onTap: () => _showSignDetails(s),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: s.color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(s.icon, color: s.color, size: 28),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    s.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    s.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_left,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }

  void _showSignDetails(TrafficSign s) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => Container(
        decoration: BoxDecoration(
          color: Theme.of(sheetContext).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(28),
          ),
        ),
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 44,
                height: 5,
                decoration: BoxDecoration(
                  color: Theme.of(sheetContext)
                      .colorScheme
                      .onSurfaceVariant
                      .withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: s.color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Icon(s.icon, color: s.color, size: 56),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                s.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 22,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: s.color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  s.category,
                  style: TextStyle(
                    color: s.color,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'التفاصيل',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              s.description,
              style: TextStyle(
                color: Theme.of(sheetContext).colorScheme.onSurfaceVariant,
                height: 1.8,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _lessonsTab() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 8, 18, 28),
      children: [
        const Text(
          'الدروس النظرية',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 6),
        Text(
          'اضغط على أي درس لقراءته بالكامل',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 20),
        ...lessons.asMap().entries.map(
              (e) => _lessonTile(e.value, e.key),
            ),
      ],
    );
  }

  Widget _lessonTile(Lesson l, int index) {
    final done = DriveStore.readLessons.contains(l.id);
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 300 + (index * 50)),
      curve: Curves.easeOutCubic,
      builder: (_, value, child) => Opacity(
        opacity: value,
        child: Transform.translate(
          offset: Offset(20 * (1 - value), 0),
          child: child,
        ),
      ),
      child: GestureDetector(
        onTap: () => _showLessonDetails(l),
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: done
                      ? DriveTheme.blue
                      : DriveTheme.blue.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  done ? Icons.check : l.icon,
                  color: done ? Colors.white : DriveTheme.blue,
                  size: 24,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                        decoration:
                            done ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 12,
                          color:
                              Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${l.minutes} دقائق',
                          style: TextStyle(
                            fontSize: 11,
                            color: Theme.of(context)
                                .colorScheme
                                .onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_left,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLessonDetails(Lesson l) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => DraggableScrollableSheet(
        initialChildSize: 0.75,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, controller) => Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(28),
            ),
          ),
          child: ListView(
            controller: controller,
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
            children: [
              Center(
                child: Container(
                  width: 44,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurfaceVariant
                        .withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  gradient: DriveTheme.blueGradient,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Icon(l.icon, color: Colors.white, size: 40),
              ),
              const SizedBox(height: 20),
              Text(
                l.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 16,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'قراءة ${l.minutes} دقائق',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                l.content,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  height: 1.9,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 28),
              FilledButton.icon(
                onPressed: () {
                  DriveStore.toggleLesson(l.id);
                  Navigator.pop(context);
                  setState(() {});
                },
                style: FilledButton.styleFrom(
                  backgroundColor: DriveStore.readLessons.contains(l.id)
                      ? Colors.red.withValues(alpha: 0.9)
                      : DriveTheme.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                icon: Icon(
                  DriveStore.readLessons.contains(l.id)
                      ? Icons.close
                      : Icons.check,
                ),
                label: Text(
                  DriveStore.readLessons.contains(l.id)
                      ? 'إلغاء القراءة'
                      : 'تحديد كمقروء',
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _quizTab() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 8, 18, 28),
      children: [
        _quizStats(),
        const SizedBox(height: 24),
        _quizStartCard(),
        const SizedBox(height: 24),
        if (DriveStore.quizHistory.isNotEmpty) ...[
          _sectionTitle('سجل المحاولات', null),
          const SizedBox(height: 12),
          ...DriveStore.quizHistory.reversed.map(
            (a) => Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  Icon(
                    a.score >= a.total * 0.7
                        ? Icons.check_circle_outline
                        : Icons.cancel_outlined,
                    color: a.score >= a.total * 0.7
                        ? DriveTheme.green
                        : DriveTheme.red,
                    size: 28,
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      '${a.date.day}/${a.date.month}/${a.date.year} - ${a.date.hour}:${a.date.minute.toString().padLeft(2, '0')}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Text(
                    '${a.score}/${a.total}',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                      color: a.score >= a.total * 0.7
                          ? DriveTheme.green
                          : DriveTheme.red,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _quizStats() {
    return Row(
      children: [
        Expanded(
          child: _statCard(
            icon: Icons.emoji_events_outlined,
            value: '${DriveStore.bestScore}',
            label: 'أفضل نتيجة',
            color: DriveTheme.yellow,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _statCard(
            icon: Icons.trending_up,
            value: '${DriveStore.averageScore}',
            label: 'المتوسط',
            color: DriveTheme.blue,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _statCard(
            icon: Icons.history,
            value: '${DriveStore.quizHistory.length}',
            label: 'محاولات',
            color: DriveTheme.green,
          ),
        ),
      ],
    );
  }

  Widget _statCard({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 26),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _quizStartCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: DriveTheme.blueGradient,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.quiz_outlined,
            color: Colors.white,
            size: 56,
          ),
          const SizedBox(height: 16),
          const Text(
            'الاختبار النظري',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '10 أسئلة عشوائية - للنجاح تحتاج 70%',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.85),
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () => _startQuiz(),
              style: FilledButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: DriveTheme.blue,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'ابدأ الاختبار',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _startQuiz() {
    final shuffled = [...quizQuestions]..shuffle();
    final selected = shuffled.take(10).toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => QuizScreen(questions: selected),
      ),
    ).then((_) => setState(() {}));
  }
}

class _SectionItem {
  _SectionItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key, required this.questions});

  final List<QuizQuestion> questions;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _current = 0;
  int? _selected;
  bool _answered = false;
  int _score = 0;
  bool _finished = false;

  @override
  Widget build(BuildContext context) {
    if (_finished) return _resultView();

    final q = widget.questions[_current];
    final progress = (_current + 1) / widget.questions.length;

    return Scaffold(
      appBar: AppBar(
        title: Text('سؤال ${_current + 1} من ${widget.questions.length}'),
        leading: IconButton(
          onPressed: () => _confirmExit(),
          icon: const Icon(Icons.close),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: progress),
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutCubic,
              builder: (_, value, __) => LinearProgressIndicator(
                value: value,
                minHeight: 6,
                backgroundColor: Theme.of(context)
                    .colorScheme
                    .onSurfaceVariant
                    .withValues(alpha: 0.1),
                valueColor: const AlwaysStoppedAnimation(DriveTheme.blue),
              ),
            ),
          ),
          const SizedBox(height: 28),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: DriveTheme.blue.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'اختر الإجابة الصحيحة',
                    style: TextStyle(
                      color: DriveTheme.blue,
                      fontWeight: FontWeight.w800,
                      fontSize: 11,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  q.question,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ...List.generate(q.options.length, (i) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _optionButton(q, i),
            );
          }),
          if (_answered) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: (_selected == q.correctIndex
                        ? DriveTheme.green
                        : DriveTheme.red)
                    .withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: (_selected == q.correctIndex
                          ? DriveTheme.green
                          : DriveTheme.red)
                      .withValues(alpha: 0.3),
                  width: 1.5,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        _selected == q.correctIndex
                            ? Icons.check_circle
                            : Icons.cancel,
                        color: _selected == q.correctIndex
                            ? DriveTheme.green
                            : DriveTheme.red,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _selected == q.correctIndex
                            ? 'إجابة صحيحة'
                            : 'إجابة خاطئة',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 15,
                          color: _selected == q.correctIndex
                              ? DriveTheme.green
                              : DriveTheme.red,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    q.explanation,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      height: 1.7,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _next,
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  _current == widget.questions.length - 1
                      ? 'عرض النتيجة'
                      : 'السؤال التالي',
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _optionButton(QuizQuestion q, int i) {
    final isCorrect = i == q.correctIndex;
    final isSelected = i == _selected;

    Color borderColor = Theme.of(context)
        .colorScheme
        .onSurfaceVariant
        .withValues(alpha: 0.15);
    Color? bg;
    Color textColor = Theme.of(context).colorScheme.onSurface;

    if (_answered) {
      if (isCorrect) {
        borderColor = DriveTheme.green;
        bg = DriveTheme.green.withValues(alpha: 0.1);
        textColor = DriveTheme.green;
      } else if (isSelected) {
        borderColor = DriveTheme.red;
        bg = DriveTheme.red.withValues(alpha: 0.1);
        textColor = DriveTheme.red;
      }
    } else if (isSelected) {
      borderColor = DriveTheme.blue;
      bg = DriveTheme.blue.withValues(alpha: 0.08);
    }

    return GestureDetector(
      onTap: _answered ? null : () => _select(i),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bg ?? Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: borderColor, width: 1.5),
        ),
        child: Row(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: borderColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  String.fromCharCode(65 + i),
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 13,
                    color: textColor,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                q.options[i],
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: textColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _select(int i) {
    setState(() {
      _selected = i;
      _answered = true;
      if (i == widget.questions[_current].correctIndex) _score++;
    });
  }

  void _next() {
    if (_current == widget.questions.length - 1) {
      final attempt = QuizAttempt(
        score: _score,
        total: widget.questions.length,
        date: DateTime.now(),
      );
      DriveStore.quizHistory.add(attempt);
      DriveStore.saveQuizHistory();
      setState(() => _finished = true);
    } else {
      setState(() {
        _current++;
        _selected = null;
        _answered = false;
      });
    }
  }

  void _confirmExit() {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('إنهاء الاختبار؟'),
        content: const Text('سيتم فقدان تقدمك في الاختبار الحالي.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('متابعة'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              Navigator.pop(context);
            },
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('إنهاء'),
          ),
        ],
      ),
    );
  }

  Widget _resultView() {
    final percent = (_score / widget.questions.length) * 100;
    final passed = percent >= 70;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: 1),
                duration: const Duration(milliseconds: 800),
                curve: Curves.elasticOut,
                builder: (_, value, child) => Transform.scale(
                  scale: value,
                  child: child,
                ),
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    color: (passed ? DriveTheme.green : DriveTheme.red)
                        .withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    passed
                        ? Icons.emoji_events
                        : Icons.sentiment_dissatisfied,
                    color: passed ? DriveTheme.green : DriveTheme.red,
                    size: 72,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Text(
                passed ? 'مبروك، نجحت!' : 'لم تنجح هذه المرة',
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                passed
                    ? 'أنت جاهز للاختبار النظري الرسمي'
                    : 'تحتاج 70% على الأقل للنجاح',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    Text(
                      '${percent.toInt()}%',
                      style: TextStyle(
                        fontSize: 52,
                        fontWeight: FontWeight.w900,
                        color: passed ? DriveTheme.green : DriveTheme.red,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'أجبت على $_score من ${widget.questions.length}',
                      style: TextStyle(
                        color:
                            Theme.of(context).colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.pop(context),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'رجوع للرئيسية',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}