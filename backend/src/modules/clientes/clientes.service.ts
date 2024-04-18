import { Injectable } from '@nestjs/common';
import { DatabaseService } from 'src/shared/modules/database/database.service';

@Injectable()
export class ClientesService {
  constructor(private dbService: DatabaseService) {}

  obtenerEnumTiposCliente = async () => {
    return await this.dbService.pgFunc<TipoCliente[]>(
      'inmobiliaria.ft_obtener_enum_tipo_cliente',
      []
    );
  };
}
