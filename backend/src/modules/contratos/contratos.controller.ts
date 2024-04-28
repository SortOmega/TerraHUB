import { Body, Controller, Delete, Get, Param, Patch, Post } from '@nestjs/common';
import { ContratosService } from './contratos.service';
import { ApiTags } from '@nestjs/swagger';
import { RegistrarSolicitudDTO } from './dtos/RegistrarSolicitud.dto';
import { RegistrarVentaDTO } from './dtos/RegistrarVenta.dto';
import { RegistrarCompraDTO } from './dtos/RegistrarCompra.dto';

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

  @Get('/listaVentasInmuebles')
  async obtenerListaVentasInmuebles() {
    return await this.contratosService.obtenerListaVentasInmuebles();
  }

  @Get('/listaComprasInmuebles')
  async obtenerListaComprasInmuebles() {
    return await this.contratosService.obtenerListaComprasInmuebles();
  }

  //#endregion GET

  //#region POST

  @Post('/registrarSolicitudCliente')
  async registrarSolicitudCliente(@Body() body: RegistrarSolicitudDTO) {
    return await this.contratosService.registrarSolicitudCliente(body);
  }

  @Post('/registrarVentaInmueble')
  async registrarVentaInmueble(@Body() body: RegistrarVentaDTO) {
    return await this.contratosService.registrarVentaInmueble(body);
  }

  @Post('/registrarCompraInmueble')
  async registrarCompraInmueble(@Body() body: RegistrarCompraDTO) {
    return await this.contratosService.registrarCompraInmueble(body);
  }

  //#endregion POST
}
