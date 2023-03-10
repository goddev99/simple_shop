
import 'package:flutter/material.dart';

import 'item_controle.dart';


class Product extends ChangeNotifier {
  int? codprod ;
  String? descrprod;
  String? descdetail;
  String? referencia;
  String? codvol;
  int? codemp;
  String? locprin;
  int? estoque;
  String? variacao;
  String? vlrvenda;
  int? estoqueglobal;
  List<String>? endimagem;
  List<ItemControle>? controle ;


   Product(
      {this.codprod,
        this.descrprod,
        this.descdetail,
        this.referencia,
        this.codvol,
        this.codemp,
        this.locprin,
        this.estoque,
        this.controle,
        this.variacao,
        this.vlrvenda,
        this.estoqueglobal,
        this.endimagem});

   Product.fromJson(Map<String, dynamic> json) {

    codprod = json['codprod'];
    descrprod = json['descrprod'];
    descdetail =json['descdetail'];
    referencia = json['referencia'];
    codvol = json['codvol'];
    codemp = json['codemp'];
    locprin = json['locprin'];
    estoque = json['estoque'];
    controle = (json['controle'] as List<dynamic>).map((controles) => ItemControle.fromJson(controles as Map<String, dynamic>) ).toList();
    variacao = json['variacao'];
    vlrvenda = json['vlrvenda'];
    estoqueglobal = json['estoqueglobal'];
    endimagem = List<String>.from(json['endimagem'] as List<dynamic>);
  }


  Product.fromJsonCart(json) {
    codprod = json['codprod'];
    descrprod = json['descrprod'];
    descdetail =json['descdetail'];
    referencia = json['referencia'];
    codvol = json['codvol'];
    codemp = json['codemp'];
    locprin = json['locprin'];
    estoque = json['estoque'];
    controle = (json['controle'] as List<dynamic>).map((controles) => ItemControle.fromJson(controles as Map<String, dynamic>) ).toList();
    variacao = json['variacao'];
    vlrvenda = json['vlrvenda'];
    estoqueglobal = json['estoqueglobal'];
    endimagem = List<String>.from(json['endimagem'] as List<dynamic>);
  }

  ItemControle? _selectedControle;
  ItemControle? get selectedControle => _selectedControle;
  set selectedControle(ItemControle? value) {
    _selectedControle = value;
    notifyListeners();
  }

  int get totalStock{
    int stock = 0;
    for(final totalControle in controle!){
      stock += totalControle.stock;
    }
    return stock;
  }
  bool get hasStock {
    return totalStock > 0;
  }

  ItemControle? findControle(String name){
    try {
      return controle!.firstWhere((s) => s.name == name);
    }catch(e){
      return null;
    }
  }


/*
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['codprod'] = codprod;
    data['descrprod'] = descrprod;
    data['referencia'] = referencia;
    data['codvol'] = codvol;
    data['codemp'] = codemp;
    data['locprin'] = locprin;
    data['estoque'] = estoque;
    data['vlrvenda'] = vlrvenda;
    data['estoqueglobal'] = estoqueglobal;
    data['endimagem'] = endimagem;
    return data;
  }
   */
}