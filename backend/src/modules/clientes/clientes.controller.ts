import { Body, Controller, Delete, Get, Param, Patch, Post } from '@nestjs/common';
import { ClientesService } from './clientes.service';
import { ApiTags } from '@nestjs/swagger';
import { ActualizarClienteDTO } from './dtos/ActualizarCliente.dto';
import { RegistrarClienteDTO } from './dtos/RegistrarCliente.dto';

@ApiTags('Mantenimiento de Clientes')
@Controller('clientes')
export class ClientesController {
  constructor(private readonly clientesService: ClientesService) {}

  //#region GET
  @Get('/tipoCliente')
  async obtenerEnumTiposCliente() {
    return await this.clientesService.obtenerEnumTiposCliente();
  }

  @Get('/listaClientes')
  async obtenerListaClientes() {
    return await this.clientesService.obtenerListaClientes();
  }

  //#endregion GET

  //#region POST
  @Post('/registrarCliente')
  async registrarCliente(@Body() body: RegistrarClienteDTO) {
    return await this.clientesService.registrarCliente(body);
  }

  //#endregion POST

  //#region PATCH
  @Patch('/actualizarCliente')
  async actualizarCliente(@Body() body: ActualizarClienteDTO) {
    return await this.clientesService.actualizarCliente(body);
  }

  //#endregion PATCH
}
