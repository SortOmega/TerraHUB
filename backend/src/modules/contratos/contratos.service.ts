import { Injectable } from '@nestjs/common';
import { DatabaseService } from 'src/shared/modules/database/database.service';

@Injectable()
export class ContratosService {
  constructor(private dbService: DatabaseService) {}

  obtenerListaSolicitudesClientes = async () => {
    return await this.dbService.pgFunc<SolicitudInmueble[]>(
      'contratos.ft_obtener_lista_solicitudes',
      []
    );
  };
}
