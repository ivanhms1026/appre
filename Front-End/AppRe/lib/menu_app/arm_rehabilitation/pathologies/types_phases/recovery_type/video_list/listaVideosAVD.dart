import 'package:appre/menu_app/arm_rehabilitation/pathologies/types_phases/recovery_type/video_list/video_player/json.dart';
import 'package:appre/menu_app/arm_rehabilitation/pathologies/types_phases/recovery_type/video_list/video_player/reproductorAVD.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../colors.dart';
import '../../../../../json/zonaMyMJson.dart';

class listaVideosAVD extends StatefulWidget {
  const listaVideosAVD({Key? key, required this.data}) : super(key: key);
  final zonaMyM data;

  @override
  State<listaVideosAVD> createState() => _listaVideosAVDState();
}

class _listaVideosAVDState extends State<listaVideosAVD> {
  List<ListasMovimiento> selectedMovements = [];

  List<ListasMovimiento> _getListForCondition(int itemFaseHombro, int itemTipoRecuperamient, int itemPatologia) {
    print(widget.data.itemPatologia);
    if (itemPatologia == 0) {
      if (itemFaseHombro == 0) {
        if (itemTipoRecuperamient == 0) {
          return ListHombroAgudaBaniarse;
        } else if (itemTipoRecuperamient == 1) {
          return ListHombroAgudaVestirse;
        } else if (itemTipoRecuperamient == 2) {
          return ListHombroAgudaComer;
        } else if (itemTipoRecuperamient == 3) {
          return ListHombroAgudaAlimentacion;
        } else if (itemTipoRecuperamient == 4) {
          return ListHombroAgudaHigienePersonal;
        }
      } else if (itemFaseHombro == 1) {
        if (itemTipoRecuperamient == 0) {
          return ListHombroCronicoBaniarse;
        } else if (itemTipoRecuperamient == 1) {
          return ListHombroCronicoVestirse;
        } else if (itemTipoRecuperamient == 2) {
          return ListHombroCronicoComer;
        } else if (itemTipoRecuperamient == 3) {
          return ListHombroCronicoAlimentacion;
        } else if (itemTipoRecuperamient == 4) {
          return ListHombroCronicoHigienePersonal;
        }
      } else if (itemFaseHombro == 2) {
        if (itemTipoRecuperamient == 0) {
          return ListHombroMantenimientoBaniarse;
        } else if (itemTipoRecuperamient == 1) {
          return ListHombroMantenimientoVestirse;
        } else if (itemTipoRecuperamient == 2) {
          return ListHombroMantenimientoComer;
        } else if (itemTipoRecuperamient == 3) {
          return ListHombroMantenimientoAlimentacion;
        } else if (itemTipoRecuperamient == 4) {
          return ListHombroMantenimientoHigienePersonal;
        }
      }
    } else if (itemPatologia == 1) {
      if (itemFaseHombro == 0) {
        if (itemTipoRecuperamient == 0) {
          return ListCodoAgudaBaniarse;
        } else if (itemTipoRecuperamient == 1) {
          return ListCodoAgudaVestirse;
        } else if (itemTipoRecuperamient == 2) {
          return ListCodoAgudaComer;
        } else if (itemTipoRecuperamient == 3) {
          return ListCodoAgudaAlimentacion;
        } else if (itemTipoRecuperamient == 4) {
          return ListCodoAgudaHigienePersonal;
        }
      } else if (itemFaseHombro == 1) {
        if (itemTipoRecuperamient == 0) {
          return ListCodoCronicoBaniarse;
        } else if (itemTipoRecuperamient == 1) {
          return ListCodoCronicoVestirse;
        } else if (itemTipoRecuperamient == 2) {
          return ListCodoCronicoComer;
        } else if (itemTipoRecuperamient == 3) {
          return ListCodoCronicoAlimentacion;
        } else if (itemTipoRecuperamient == 4) {
          return ListCodoCronicoHigienePersonal;
        }
      } else if (itemFaseHombro == 2) {
        if (itemTipoRecuperamient == 0) {
          return ListCodoMantenimientoBaniarse;
        } else if (itemTipoRecuperamient == 1) {
          return ListCodoMantenimientoVestirse;
        } else if (itemTipoRecuperamient == 2) {
          return ListCodoMantenimientoComer;
        } else if (itemTipoRecuperamient == 3) {
          return ListCodoMantenimientoAlimentacion;
        } else if (itemTipoRecuperamient == 4) {
          return ListCodoMantenimientoHigienePersonal;
        }
      }
    } else if (itemPatologia == 2) {
      if (itemFaseHombro == 0) {
        if (itemTipoRecuperamient == 0) {
          return ListMunecaAgudaBaniarse;
        } else if (itemTipoRecuperamient == 1) {
          return ListMunecaAgudaVestirse;
        } else if (itemTipoRecuperamient == 2) {
          return ListMunecaAgudaComer;
        } else if (itemTipoRecuperamient == 3) {
          return ListMunecaAgudaAlimentacion;
        } else if (itemTipoRecuperamient == 4) {
          return ListMunecaAgudaHigienePersonal;
        }
      } else if (itemFaseHombro == 1) {
        if (itemTipoRecuperamient == 0) {
          return ListMunecaCronicoBaniarse;
        } else if (itemTipoRecuperamient == 1) {
          return ListMunecaCronicoVestirse;
        } else if (itemTipoRecuperamient == 2) {
          return ListMunecaCronicoComer;
        } else if (itemTipoRecuperamient == 3) {
          return ListMunecaCronicoAlimentacion;
        } else if (itemTipoRecuperamient == 4) {
          return ListMunecaCronicoHigienePersonal;
        }
      } else if (itemFaseHombro == 2) {
        if (itemTipoRecuperamient == 0) {
          return ListMunecaMantenimientoBaniarse;
        } else if (itemTipoRecuperamient == 1) {
          return ListMunecaMantenimientoVestirse;
        } else if (itemTipoRecuperamient == 2) {
          return ListMunecaMantenimientoComer;
        } else if (itemTipoRecuperamient == 3) {
          return ListMunecaMantenimientoAlimentacion;
        } else if (itemTipoRecuperamient == 4) {
          return ListMunecaMantenimientoHigienePersonal;
        }
      }
    } else if (itemPatologia == 3) {
      if (itemFaseHombro == 0) {
        if (itemTipoRecuperamient == 0) {
          return ListManoAgudaBaniarse;
        } else if (itemTipoRecuperamient == 1) {
          return ListManoAgudaVestirse;
        } else if (itemTipoRecuperamient == 2) {
          return ListManoAgudaComer;
        } else if (itemTipoRecuperamient == 3) {
          return ListManoAgudaAlimentacion;
        } else if (itemTipoRecuperamient == 4) {
          return ListManoAgudaHigienePersonal;
        }
      } else if (itemFaseHombro == 1) {
        if (itemTipoRecuperamient == 0) {
          return ListManoCronicoBaniarse;
        } else if (itemTipoRecuperamient == 1) {
          return ListManoCronicoVestirse;
        } else if (itemTipoRecuperamient == 2) {
          return ListManoCronicoComer;
        } else if (itemTipoRecuperamient == 3) {
          return ListManoCronicoAlimentacion;
        } else if (itemTipoRecuperamient == 4) {
          return ListManoCronicoHigienePersonal;
        }
      } else if (itemFaseHombro == 2) {
        if (itemTipoRecuperamient == 0) {
          return ListManoMantenimientoBaniarse;
        } else if (itemTipoRecuperamient == 1) {
          return ListManoMantenimientoVestirse;
        } else if (itemTipoRecuperamient == 2) {
          return ListManoMantenimientoComer;
        } else if (itemTipoRecuperamient == 3) {
          return ListManoMantenimientoAlimentacion;
        } else if (itemTipoRecuperamient == 4) {
          return ListManoMantenimientoHigienePersonal;
        }
      }
    }

    return [];
  }

  @override
  void initState() {
    super.initState();
    List<ListasMovimiento> hombroAgudaBaniarse = List.from(ListHombroAgudaBaniarse);
    List<ListasMovimiento> hombroAgudaVestirse = List.from(ListHombroAgudaVestirse);
    List<ListasMovimiento> hombroAgudaComer = List.from(ListHombroAgudaComer);
    List<ListasMovimiento> hombroAgudaAlimentacion = List.from(ListHombroAgudaAlimentacion);
    List<ListasMovimiento> hombroAgudaHigienePersonal = List.from(ListHombroAgudaHigienePersonal);

    List<ListasMovimiento> hombroCronicoBaniarse = List.from(ListHombroCronicoBaniarse);
    List<ListasMovimiento> hombroCronicoVestirse = List.from(ListHombroCronicoVestirse);
    List<ListasMovimiento> hombroCronicoComer = List.from(ListHombroCronicoComer);
    List<ListasMovimiento> hombroCronicoAlimentacion = List.from(ListHombroCronicoAlimentacion);
    List<ListasMovimiento> hombroCronicoHigienePersonal = List.from(ListHombroCronicoHigienePersonal);

    List<ListasMovimiento> hombroMantenimientoBaniarse = List.from(ListHombroMantenimientoBaniarse);
    List<ListasMovimiento> hombroMantenimientoVestirse = List.from(ListHombroMantenimientoVestirse);
    List<ListasMovimiento> hombroMantenimientoComer = List.from(ListHombroMantenimientoComer);
    List<ListasMovimiento> hombroMantenimientoAlimentacion = List.from(ListHombroMantenimientoAlimentacion);
    List<ListasMovimiento> hombroMantenimientoHigienePersonal = List.from(ListHombroMantenimientoHigienePersonal);

// Limpia las listas originales
    ListHombroAgudaBaniarse.clear();
    ListHombroAgudaVestirse.clear();
    ListHombroAgudaComer.clear();
    ListHombroAgudaAlimentacion.clear();
    ListHombroAgudaHigienePersonal.clear();

    ListHombroCronicoBaniarse.clear();
    ListHombroCronicoVestirse.clear();
    ListHombroCronicoComer.clear();
    ListHombroCronicoAlimentacion.clear();
    ListHombroCronicoHigienePersonal.clear();

    ListHombroMantenimientoBaniarse.clear();
    ListHombroMantenimientoVestirse.clear();
    ListHombroMantenimientoComer.clear();
    ListHombroMantenimientoAlimentacion.clear();
    ListHombroMantenimientoHigienePersonal.clear();

// Usa las nuevas listas
    ListHombroAgudaBaniarse = hombroAgudaBaniarse;
    ListHombroAgudaVestirse = hombroAgudaVestirse;
    ListHombroAgudaComer = hombroAgudaComer;
    ListHombroAgudaAlimentacion = hombroAgudaAlimentacion;
    ListHombroAgudaHigienePersonal = hombroAgudaHigienePersonal;

    ListHombroCronicoBaniarse = hombroCronicoBaniarse;
    ListHombroCronicoVestirse = hombroCronicoVestirse;
    ListHombroCronicoComer = hombroCronicoComer;
    ListHombroCronicoAlimentacion = hombroCronicoAlimentacion;
    ListHombroCronicoHigienePersonal = hombroCronicoHigienePersonal;

    ListHombroMantenimientoBaniarse = hombroMantenimientoBaniarse;
    ListHombroMantenimientoVestirse = hombroMantenimientoVestirse;
    ListHombroMantenimientoComer = hombroMantenimientoComer;
    ListHombroMantenimientoAlimentacion = hombroMantenimientoAlimentacion;
    ListHombroMantenimientoHigienePersonal = hombroMantenimientoHigienePersonal;

    List<ListasMovimiento> codoAgudaBaniarse = List.from(ListCodoAgudaBaniarse);
    List<ListasMovimiento> codoAgudaVestirse = List.from(ListCodoAgudaVestirse);
    List<ListasMovimiento> codoAgudaComer = List.from(ListCodoAgudaComer);
    List<ListasMovimiento> codoAgudaAlimentacion = List.from(ListCodoAgudaAlimentacion);
    List<ListasMovimiento> codoAgudaHigienePersonal = List.from(ListCodoAgudaHigienePersonal);

    List<ListasMovimiento> codoCronicoBaniarse = List.from(ListCodoCronicoBaniarse);
    List<ListasMovimiento> codoCronicoVestirse = List.from(ListCodoCronicoVestirse);
    List<ListasMovimiento> codoCronicoComer = List.from(ListCodoCronicoComer);
    List<ListasMovimiento> codoCronicoAlimentacion = List.from(ListCodoCronicoAlimentacion);
    List<ListasMovimiento> codoCronicoHigienePersonal = List.from(ListCodoCronicoHigienePersonal);

    List<ListasMovimiento> codoMantenimientoBaniarse = List.from(ListCodoMantenimientoBaniarse);
    List<ListasMovimiento> codoMantenimientoVestirse = List.from(ListCodoMantenimientoVestirse);
    List<ListasMovimiento> codoMantenimientoComer = List.from(ListCodoMantenimientoComer);
    List<ListasMovimiento> codoMantenimientoAlimentacion = List.from(ListCodoMantenimientoAlimentacion);
    List<ListasMovimiento> codoMantenimientoHigienePersonal = List.from(ListCodoMantenimientoHigienePersonal);

// Limpia las listas originales
    ListCodoAgudaBaniarse.clear();
    ListCodoAgudaVestirse.clear();
    ListCodoAgudaComer.clear();
    ListCodoAgudaAlimentacion.clear();
    ListCodoAgudaHigienePersonal.clear();

    ListCodoCronicoBaniarse.clear();
    ListCodoCronicoVestirse.clear();
    ListCodoCronicoComer.clear();
    ListCodoCronicoAlimentacion.clear();
    ListCodoCronicoHigienePersonal.clear();

    ListCodoMantenimientoBaniarse.clear();
    ListCodoMantenimientoVestirse.clear();
    ListCodoMantenimientoComer.clear();
    ListCodoMantenimientoAlimentacion.clear();
    ListCodoMantenimientoHigienePersonal.clear();

// Usa las nuevas listas
    ListCodoAgudaBaniarse = codoAgudaBaniarse;
    ListCodoAgudaVestirse = codoAgudaVestirse;
    ListCodoAgudaComer = codoAgudaComer;
    ListCodoAgudaAlimentacion = codoAgudaAlimentacion;
    ListCodoAgudaHigienePersonal = codoAgudaHigienePersonal;

    ListCodoCronicoBaniarse = codoCronicoBaniarse;
    ListCodoCronicoVestirse = codoCronicoVestirse;
    ListCodoCronicoComer = codoCronicoComer;
    ListCodoCronicoAlimentacion = codoCronicoAlimentacion;
    ListCodoCronicoHigienePersonal = codoCronicoHigienePersonal;

    ListCodoMantenimientoBaniarse = codoMantenimientoBaniarse;
    ListCodoMantenimientoVestirse = codoMantenimientoVestirse;
    ListCodoMantenimientoComer = codoMantenimientoComer;
    ListCodoMantenimientoAlimentacion = codoMantenimientoAlimentacion;
    ListCodoMantenimientoHigienePersonal = codoMantenimientoHigienePersonal;

    List<ListasMovimiento> munecaAgudaBaniarse = List.from(ListMunecaAgudaBaniarse);
    List<ListasMovimiento> munecaAgudaVestirse = List.from(ListMunecaAgudaVestirse);
    List<ListasMovimiento> munecaAgudaComer = List.from(ListMunecaAgudaComer);
    List<ListasMovimiento> munecaAgudaAlimentacion = List.from(ListMunecaAgudaAlimentacion);
    List<ListasMovimiento> munecaAgudaHigienePersonal = List.from(ListMunecaAgudaHigienePersonal);

    List<ListasMovimiento> munecaCronicoBaniarse = List.from(ListMunecaCronicoBaniarse);
    List<ListasMovimiento> munecaCronicoVestirse = List.from(ListMunecaCronicoVestirse);
    List<ListasMovimiento> munecaCronicoComer = List.from(ListMunecaCronicoComer);
    List<ListasMovimiento> munecaCronicoAlimentacion = List.from(ListMunecaCronicoAlimentacion);
    List<ListasMovimiento> munecaCronicoHigienePersonal = List.from(ListMunecaCronicoHigienePersonal);

    List<ListasMovimiento> munecaMantenimientoBaniarse = List.from(ListMunecaMantenimientoBaniarse);
    List<ListasMovimiento> munecaMantenimientoVestirse = List.from(ListMunecaMantenimientoVestirse);
    List<ListasMovimiento> munecaMantenimientoComer = List.from(ListMunecaMantenimientoComer);
    List<ListasMovimiento> munecaMantenimientoAlimentacion = List.from(ListMunecaMantenimientoAlimentacion);
    List<ListasMovimiento> munecaMantenimientoHigienePersonal = List.from(ListMunecaMantenimientoHigienePersonal);

// Limpia las listas originales
    ListMunecaAgudaBaniarse.clear();
    ListMunecaAgudaVestirse.clear();
    ListMunecaAgudaComer.clear();
    ListMunecaAgudaAlimentacion.clear();
    ListMunecaAgudaHigienePersonal.clear();

    ListMunecaCronicoBaniarse.clear();
    ListMunecaCronicoVestirse.clear();
    ListMunecaCronicoComer.clear();
    ListMunecaCronicoAlimentacion.clear();
    ListMunecaCronicoHigienePersonal.clear();

    ListMunecaMantenimientoBaniarse.clear();
    ListMunecaMantenimientoVestirse.clear();
    ListMunecaMantenimientoComer.clear();
    ListMunecaMantenimientoAlimentacion.clear();
    ListMunecaMantenimientoHigienePersonal.clear();

// Usa las nuevas listas
    ListMunecaAgudaBaniarse = munecaAgudaBaniarse;
    ListMunecaAgudaVestirse = munecaAgudaVestirse;
    ListMunecaAgudaComer = munecaAgudaComer;
    ListMunecaAgudaAlimentacion = munecaAgudaAlimentacion;
    ListMunecaAgudaHigienePersonal = munecaAgudaHigienePersonal;

    ListMunecaCronicoBaniarse = munecaCronicoBaniarse;
    ListMunecaCronicoVestirse = munecaCronicoVestirse;
    ListMunecaCronicoComer = munecaCronicoComer;
    ListMunecaCronicoAlimentacion = munecaCronicoAlimentacion;
    ListMunecaCronicoHigienePersonal = munecaCronicoHigienePersonal;

    ListMunecaMantenimientoBaniarse = munecaMantenimientoBaniarse;
    ListMunecaMantenimientoVestirse = munecaMantenimientoVestirse;
    ListMunecaMantenimientoComer = munecaMantenimientoComer;
    ListMunecaMantenimientoAlimentacion = munecaMantenimientoAlimentacion;
    ListMunecaMantenimientoHigienePersonal = munecaMantenimientoHigienePersonal;

    List<ListasMovimiento> manoAgudaBaniarse = List.from(ListManoAgudaBaniarse);
    List<ListasMovimiento> manoAgudaVestirse = List.from(ListManoAgudaVestirse);
    List<ListasMovimiento> manoAgudaComer = List.from(ListManoAgudaComer);
    List<ListasMovimiento> manoAgudaAlimentacion = List.from(ListManoAgudaAlimentacion);
    List<ListasMovimiento> manoAgudaHigienePersonal = List.from(ListManoAgudaHigienePersonal);

    List<ListasMovimiento> manoCronicoBaniarse = List.from(ListManoCronicoBaniarse);
    List<ListasMovimiento> manoCronicoVestirse = List.from(ListManoCronicoVestirse);
    List<ListasMovimiento> manoCronicoComer = List.from(ListManoCronicoComer);
    List<ListasMovimiento> manoCronicoAlimentacion = List.from(ListManoCronicoAlimentacion);
    List<ListasMovimiento> manoCronicoHigienePersonal = List.from(ListManoCronicoHigienePersonal);

    List<ListasMovimiento> manoMantenimientoBaniarse = List.from(ListManoMantenimientoBaniarse);
    List<ListasMovimiento> manoMantenimientoVestirse = List.from(ListManoMantenimientoVestirse);
    List<ListasMovimiento> manoMantenimientoComer = List.from(ListManoMantenimientoComer);
    List<ListasMovimiento> manoMantenimientoAlimentacion = List.from(ListManoMantenimientoAlimentacion);
    List<ListasMovimiento> manoMantenimientoHigienePersonal = List.from(ListManoMantenimientoHigienePersonal);

// Limpia las listas originales
    ListManoAgudaBaniarse.clear();
    ListManoAgudaVestirse.clear();
    ListManoAgudaComer.clear();
    ListManoAgudaAlimentacion.clear();
    ListManoAgudaHigienePersonal.clear();

    ListManoCronicoBaniarse.clear();
    ListManoCronicoVestirse.clear();
    ListManoCronicoComer.clear();
    ListManoCronicoAlimentacion.clear();
    ListManoCronicoHigienePersonal.clear();

    ListManoMantenimientoBaniarse.clear();
    ListManoMantenimientoVestirse.clear();
    ListManoMantenimientoComer.clear();
    ListManoMantenimientoAlimentacion.clear();
    ListManoMantenimientoHigienePersonal.clear();

// Usa las nuevas listas
    ListManoAgudaBaniarse = manoAgudaBaniarse;
    ListManoAgudaVestirse = manoAgudaVestirse;
    ListManoAgudaComer = manoAgudaComer;
    ListManoAgudaAlimentacion = manoAgudaAlimentacion;
    ListManoAgudaHigienePersonal = manoAgudaHigienePersonal;

    ListManoCronicoBaniarse = manoCronicoBaniarse;
    ListManoCronicoVestirse = manoCronicoVestirse;
    ListManoCronicoComer = manoCronicoComer;
    ListManoCronicoAlimentacion = manoCronicoAlimentacion;
    ListManoCronicoHigienePersonal = manoCronicoHigienePersonal;

    ListManoMantenimientoBaniarse = manoMantenimientoBaniarse;
    ListManoMantenimientoVestirse = manoMantenimientoVestirse;
    ListManoMantenimientoComer = manoMantenimientoComer;
    ListManoMantenimientoAlimentacion = manoMantenimientoAlimentacion;
    ListManoMantenimientoHigienePersonal = manoMantenimientoHigienePersonal;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(widget.data.imageUrl),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.75),
              BlendMode.darken,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50.h),
            Container(
              padding: EdgeInsets.all(15.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back_ios, size: 20.sp, color: Colors.white),
                  ),
                  SizedBox(height: 30.h),
                  AutoSizeText(
                    widget.data.tituloFase,
                    style: TextStyle(
                      fontSize: 23.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColor.colorTextOne,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  AutoSizeText(
                    widget.data.title,
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: AppColor.colorWhite,
                    ),
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
            Expanded(
              child: Container(
                  padding: EdgeInsets.all(15.h),
                  decoration: BoxDecoration(
                      color: AppColor.colorWhite,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(70),
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Lista de reproduccion",
                        style: TextStyle(fontSize: 19.sp, fontWeight: FontWeight.bold, color: const Color(0xFF212121)),
                      ),
                      Expanded(
                          child: ListView.builder(
                              itemCount: _getListForCondition(
                                widget.data.itemFaseHombro,
                                widget.data.itemTipoRecuperamient,
                                widget.data.itemPatologia,
                              ).length,
                              itemBuilder: (context, index) {
                                ListasMovimiento movimiento = _getListForCondition(
                                  widget.data.itemFaseHombro,
                                  widget.data.itemTipoRecuperamient,
                                  widget.data.itemPatologia,
                                )[index];
                                String videoId = movimiento.thumbnail;
                                return GestureDetector(
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectedMovements
                                            .clear(); // Limpiar la lista antes de agregar el nuevo elemento.
                                        selectedMovements.add(movimiento);
                                      });
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => reproductorAvd(movimiento: movimiento)),
                                      );
                                    },
                                    child: SizedBox(
                                      height: 110.h,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                width: 145.w,
                                                height: 90.h,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(15),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(15),
                                                  child: Image.network(
                                                    'https://img.youtube.com/vi/$videoId/0.jpg',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 15.w,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      movimiento.title,
                                                      style: TextStyle(
                                                        fontSize: 15.sp,
                                                        fontWeight: FontWeight.bold,
                                                        color: const Color(0xFF212121),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10.sp,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(top: 3),
                                                      child: Text(
                                                        movimiento.time,
                                                        style: TextStyle(
                                                          fontSize: 14.sp,
                                                          color: Colors.blueGrey,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              })),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
