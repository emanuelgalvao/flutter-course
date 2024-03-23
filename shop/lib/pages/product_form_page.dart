import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/custom_app_bar.dart';
import 'package:shop/models/product.dart';
import 'package:shop/providers/product_list.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _nameFocus = FocusNode();
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _imageUrlFocus = FocusNode();
  final _imageUrlController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  Map<String, Object> _formData = {};

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _imageUrlController.addListener(updateImage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;
      if (arg != null) {
        final Product product = arg as Product;
        _formData['id'] = product.id;
        _formData['name'] = product.name;
        _formData['description'] = product.description;
        _formData['price'] = product.price;
        _formData['imageUrl'] = product.imageUrl;

        _imageUrlController.text = product.imageUrl;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _nameFocus.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    _imageUrlFocus.dispose();
    _imageUrlController.removeListener(updateImage);
  }

  void updateImage() {
    setState(() {});
  }

  bool isValidImageUrl(String url) {
    bool isValidUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    bool isValidExtension =
        url.endsWith('.png') || url.endsWith('.jpg') || url.endsWith('.jpeg');
    return isValidUrl && isValidExtension;
  }

  Future<void> onSubmit() async {
    bool isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();

    setState(() {
      isLoading = true;
    });

    try {
      await Provider.of<ProductList>(context, listen: false)
        .saveProduct(_formData);

      Navigator.of(context).pop();
    } catch (_) {
      await showDialog(
          context: context,
          builder: (ctx) => AlertDialog.adaptive(
            title: const Text('Erro!'),
            content: const Text('Ocorreu um erro inesperado.\nTente novamente!'),
            actions: [
              TextButton(
                onPressed: () {
                  setState(() {
                    isLoading = false;
                  });
                  Navigator.of(context).pop(false);
                },
                child: const Text('Ok'),
              ),
            ],
          ),
        );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        context,
        'Formulário de Produto',
        [
          IconButton(
            onPressed: () => onSubmit(),
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: _formData['name']?.toString(),
                      decoration: const InputDecoration(label: Text('Nome')),
                      textInputAction: TextInputAction.next,
                      focusNode: _nameFocus,
                      onSaved: (name) => _formData['name'] = name ?? '',
                      validator: (_name) {
                        final name = _name ?? '';
                        if (name.trim().isEmpty) {
                          return 'Nome é obrigatório!';
                        }
                        if (name.trim().length < 3) {
                          return 'Nome precisa ter no mínimo 3 caracteres!';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _formData['price']?.toString(),
                      decoration: const InputDecoration(label: Text('Preço')),
                      textInputAction: TextInputAction.next,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      focusNode: _priceFocus,
                      onSaved: (price) => _formData['price'] =
                          double.tryParse(price.toString()) ?? 0.0,
                      validator: (_price) {
                        final price = double.tryParse(_price ?? '0') ?? 0.0;
                        if (price <= 0.0) {
                          return 'Valor inválido!';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _formData['description']?.toString(),
                      decoration:
                          const InputDecoration(label: Text('Descrição')),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.multiline,
                      focusNode: _descriptionFocus,
                      maxLines: 3,
                      onSaved: (description) =>
                          _formData['description'] = description ?? '',
                      validator: (_description) {
                        final description = _description ?? '';
                        if (description.trim().isEmpty) {
                          return 'Descrição é obrigatória!';
                        }
                        if (description.trim().length < 10) {
                          return 'Descrição precisa ter no mínimo 10 caracteres!';
                        }
                        return null;
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                                label: Text('URL da imagem')),
                            textInputAction: TextInputAction.done,
                            focusNode: _imageUrlFocus,
                            controller: _imageUrlController,
                            onSaved: (imageUrl) =>
                                _formData['imageUrl'] = imageUrl ?? '',
                            onFieldSubmitted: (_) => onSubmit(),
                            validator: (_url) {
                              final url = _url ?? '';
                              if (!isValidImageUrl(url)) {
                                return 'URL de imagem inválida!';
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          width: 100,
                          height: 100,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(
                            top: 10,
                            left: 10,
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          )),
                          child: _imageUrlController.text.isEmpty
                              ? const Text('Informe a URL')
                              : Image.network(_imageUrlController.text),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
