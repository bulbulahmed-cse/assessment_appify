import 'package:appifylab_assessment/main.dart';
import 'package:appifylab_assessment/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'create_post_bloc.dart';
import 'create_post_event.dart';
import 'create_post_state.dart';

class CreatePostPage extends StatelessWidget {
  const CreatePostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CreatePostBloc()..add(InitEvent()),
      child: BlocBuilder<CreatePostBloc, CreatePostState>(builder: (context, state) => _buildPage(context, state)),
    );
  }

  Widget _buildPage(BuildContext context, CreatePostState state) {
    final bloc = BlocProvider.of<CreatePostBloc>(context);

    return Scaffold(
     body: SafeArea(
       child: Column(
         children: [
           Padding(
             padding: EdgeInsets.all(16),
             child: Row(
               children: [
                 TextButton(
                   onPressed: backPage,
                   child: Text(
                     'Close',
                     style: appTheme(context).textTheme.headlineLarge!.copyWith(
                       color: Colors.grey,
                       fontSize: 20
                     ),
                   )
                 ),
                 Expanded(
                   child: Text(
                     "Create Post",
                     style: appTheme(context).textTheme.headlineLarge!.copyWith(
                       fontSize: 20
                     ),
                     textAlign: TextAlign.center,
                   ),
                 ),
                 TextButton(
                   onPressed: ()=> bloc.add(CreatePost()),
                   child: Text(
                     'Create',
                     style: appTheme(context).textTheme.headlineLarge!.copyWith(
                       color: Color(0xFF6662FF),
                       fontSize: 20
                     ),
                   )
                 ),
               ],
             ),
           ),
           Expanded(
             child: Form(
               key: bloc.formKey,
               child: SingleChildScrollView(
                 padding: EdgeInsets.symmetric(horizontal: 16),
                 child: Column(
                   children: [
                     32.verticalSpace,
                     TextFormField(
                       controller: bloc.postContent,
                       style: appTheme(context).textTheme.bodyLarge!.copyWith(
                         fontSize: 16
                       ),
                       maxLines: 6,
                       autofocus: true,
                       cursorColor: Colors.red,
                       validator: (text){
                         if((text??'').isEmpty){
                           return "Please write what's on your mind";
                         }
                         return null;
                       },
                       decoration: InputDecoration(
                         filled: true,
                         fillColor: Colors.white,
                         contentPadding: EdgeInsets.all(16),
                         border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(12),
                           borderSide: BorderSide(color: Colors.grey)
                         ),
                         enabledBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(12),
                           borderSide: BorderSide(color: Colors.grey)
                         ),
                         focusedBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(12),
                           borderSide: BorderSide(color: Colors.grey)
                         ),
                         errorBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(12),
                           borderSide: BorderSide(color: Colors.red)
                         ),
                         hintText: "What's on your mind?",
                         hintStyle: appTheme(context).textTheme.bodyLarge!.copyWith(
                           fontSize: 16,
                           color: Colors.grey
                         )
                       ),
                     )
                   ],
                 ),
               ),
             ),
           )
         ],
       ),
     ),
    );
  }
}

