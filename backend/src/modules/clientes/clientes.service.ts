import { Injectable } from '@nestjs/common';
import { DatabaseService } from 'src/shared/modules/database/database.service';
import { RegistrarClienteDTO } from './dtos/RegistrarCliente.dto';
import { ActualizarClienteDTO } from './dtos/ActualizarCliente.dto';

@Injectable()
export class ClientesService {
  constructor(private dbService: DatabaseService) {}

  obtenerEnumTiposCliente = async () => {
    return await this.dbService.pgFunc<TipoCliente[]>(
      'inmobiliaria.ft_obtener_enum_tipo_cliente',
      []
    );
  };

  obtenerListaClientes = async () => {
    return await this.dbService.pgFunc<Cliente[]>('clientes.ft_obtener_lista_clientes', []);
  };

  registrarCliente = async (body: RegistrarClienteDTO) => {
    return await this.dbService.pgFunc<Cliente>('clientes.ft_registrar_cliente', [
      JSON.stringify(body),
    ]);
  };

  actualizarCliente = async (body: ActualizarClienteDTO) => {
    return await this.dbService.pgFunc<boolean>('clientes.ft_actualizar_cliente', [
      JSON.stringify(body),
    ]);
  };
}
