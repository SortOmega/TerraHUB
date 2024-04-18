import { Body, Controller, Delete, Get, Param, Patch, Post } from '@nestjs/common';
import { ClientesService } from './clientes.service';
import { ApiTags } from '@nestjs/swagger';

@ApiTags('Mantenimiento de Clientes')
@Controller('clientes')
export class ClientesController {
  constructor(private readonly clientesService: ClientesService) {}

  //#region GET
  @Get('/tipoCliente')
  async obtenerEnumTiposCliente() {
    return await this.clientesService.obtenerEnumTiposCliente();
  }

  //#endregion GET
}
