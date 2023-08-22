import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fudo_flutter_challenge/core/routes/route_names.dart';
import 'package:fudo_flutter_challenge/src/common/presentation/widgets/primary_button.dart';
import 'package:fudo_flutter_challenge/src/new_post/presentation/bloc/new_post_bloc.dart';
import 'package:fudo_flutter_challenge/src/new_post/presentation/widgets/post_text_form.dart';

class NewPost extends StatefulWidget {
  const NewPost({super.key});

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  late final TextEditingController _titleController;
  late final TextEditingController _contentController;
  late final GlobalKey<FormState> _titleKey;
  late final GlobalKey<FormState> _contentKey;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _contentController = TextEditingController();
    _titleKey = GlobalKey<FormState>();
    _contentKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        title: Text(
          'Nuevo post',
          style: textTheme.titleLarge,
        ),
      ),
      body: BlocListener<NewPostBloc, NewPostState>(
        listener: (context, state) {
          if (state is Initialized && state.postPublishOk) {
            Navigator.of(context).pushNamed(RouteNames.home);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            children: [
              PostTextForm(
                title: 'Título',
                controller: _titleController,
                formKey: _titleKey,
                validator: (title) => _validateTitle(title),
              ),
              const SizedBox(height: 15),
              PostTextForm(
                title: 'Contenido',
                maxLines: 5,
                controller: _contentController,
                formKey: _contentKey,
                validator: (content) => _validateContent(content),
              ),
              const SizedBox(height: 15),
              PrimaryButton(
                text: 'Crear post',
                onPressed: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  if ((_titleKey.currentState?.validate() ?? false) &&
                      (_contentKey.currentState?.validate() ?? false)) {
                    BlocProvider.of<NewPostBloc>(context).add(
                      PublishNewPost(
                        title: _titleController.text,
                        content: _contentController.text,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  String? _validateTitle(String? title) {
    if ((title ?? '').isNotEmpty) {
      return null;
    } else {
      return 'Ingresá un título';
    }
  }

  String? _validateContent(String? content) {
    if ((content ?? '').isNotEmpty) {
      return null;
    } else {
      return 'Ingresá el contenido del post';
    }
  }
}
