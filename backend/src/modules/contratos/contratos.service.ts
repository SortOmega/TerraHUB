import { Injectable } from '@nestjs/common';
import { DatabaseService } from 'src/shared/modules/database/database.service';
import { RegistrarSolicitudDTO } from './dtos/RegistrarSolicitud.dto';

@Injectable()
export class ContratosService {
  constructor(private dbService: DatabaseService) {}

  obtenerListaSolicitudesClientes = async () => {
    return await this.dbService.pgFunc<SolicitudInmueble[]>(
      'contratos.ft_obtener_lista_solicitudes',
      []
    );
  };

  registrarSolicitudCliente = async (body: RegistrarSolicitudDTO) => {
    return await this.dbService.pgFunc<SolicitudInmueble>(
      'contratos.ft_registrar_solicitud_cliente',
      [JSON.stringify(body)]
    );
  };
}
