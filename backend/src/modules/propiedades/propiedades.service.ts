import { Injectable } from '@nestjs/common';
import { DatabaseService } from 'src/shared/modules/database/database.service';
// import { CreatePropiedadesDto } from './dto/create-propiedades.dto';
// import { UpdatePropiedadesDto } from './dto/update-propiedades.dto';

@Injectable()
export class PropiedadesService {
  constructor(private dbService: DatabaseService) {}

  obtenerListaPropiedadesPorTipo = async (idTipoPropiedad: TipoPropiedad) => {
    return await this.dbService.pgFunc('inmobiliaria.ft_obtener_propiedades_por_tipo', [
      idTipoPropiedad,
    ]);
  };
}
