import { Injectable } from '@nestjs/common';
import { DatabaseService } from 'src/shared/modules/database/database.service';
import { RegistrarPropiedadDTO } from './dtos/RegistrarPropiedad.dto';
import { ActualizarPropiedadDTO } from './dtos/ActualizarPropiedad.dto';
// import { CreatePropiedadesDto } from './dto/create-propiedades.dto';
// import { UpdatePropiedadesDto } from './dto/update-propiedades.dto';

@Injectable()
export class PropiedadesService {
  constructor(private dbService: DatabaseService) {}

  obtenerEnumEtiquetasPropiedad = async () => {
    return await this.dbService.pgFunc<EtiquetaPropiedad[]>(
      'inmobiliaria.ft_obtener_enum_etiquetas',
      []
    );
  };

  obtenerEnumTiposPropiedad = async () => {
    return await this.dbService.pgFunc<TipoPropiedad[]>(
      'inmobiliaria.ft_obtener_enum_tipo_propiedad',
      []
    );
  };

  obtenerListaEtiquetasSegunPropiedad = async (idPropiedad: string) => {
    return await this.dbService.pgFunc<Propiedad[]>(
      'inmobiliaria.ft_obtener_propiedades_por_tipo',
      [idPropiedad]
    );
  };

  obtenerPropiedad = async (idPropiedad: string) => {
    return await this.dbService.pgFunc<Propiedad>('inmobiliaria.ft_obtener_propiedad', [
      idPropiedad,
    ]);
  };

  obtenerListaPropiedades = async () => {
    return await this.dbService.pgFunc<Propiedad[]>('inmobiliaria.ft_obtener_propiedades', []);
  };

  obtenerListaPropiedadesPorTipo = async (idTipoPropiedad: EnumTipoPropiedad) => {
    return await this.dbService.pgFunc<Propiedad[]>(
      'inmobiliaria.ft_obtener_propiedades_por_tipo',
      [idTipoPropiedad]
    );
  };

  registrarPropiedad = async (body: RegistrarPropiedadDTO) => {
    return await this.dbService.pgFunc<Propiedad>('inmobiliaria.ft_registrar_propiedad', [
      JSON.stringify(body),
    ]);
  };

  actualizarPropiedad = async (body: ActualizarPropiedadDTO) => {
    return await this.dbService.pgFunc<boolean>('inmobiliaria.ft_actualizar_propiedad', [
      JSON.stringify(body),
    ]);
  };
}
