import { Body, Controller, Delete, Get, Param, Patch, Post } from '@nestjs/common';
import { ContratosService } from './contratos.service';
import { ApiTags } from '@nestjs/swagger';
import { RegistrarSolicitudDTO } from './dtos/RegistrarSolicitud.dto';

@ApiTags('Mantenimiento de Contratos')
@Controller('contratos')
export class ContratosController {
  constructor(private readonly contratosService: ContratosService) {}

  //#region GET
  @Get('/listaSolicitudesClientes')
  async obtenerListaSolicitudesClientes() {
    return await this.contratosService.obtenerListaSolicitudesClientes();
  }

  //#endregion GET

  //#region POST

  @Post('/registrarSolicitudCliente')
  async registrarSolicitudCliente(@Body() body: RegistrarSolicitudDTO) {
    return await this.contratosService.registrarSolicitudCliente(body);
  }
}
