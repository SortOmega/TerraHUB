import { Body, Controller, Delete, Get, Param, Patch, Post } from '@nestjs/common';
// import { CreatePropiedadesDto } from './dto/create-propiedades.dto';
// import { UpdatePropiedadesDto } from './dto/update-propiedades.dto';
import { PropiedadesService } from './propiedades.service';
import { ApiResponse, ApiTags } from '@nestjs/swagger';
import { RegistrarPropiedadDTO } from './dtos/RegistrarPropiedad.dto';
import { ActualizarPropiedadDTO } from './dtos/ActualizarPropiedad.dto';

@ApiTags('Mantenimiento de Propiedades')
@Controller('propiedades')
export class PropiedadesController {
  constructor(private readonly propiedadesService: PropiedadesService) {}

  //#region GET

  @Get()
  async obtenerListaPropiedades() {
    return await this.propiedadesService.obtenerListaPropiedades();
  }

  @Get('/:idPropiedad')
  async obtenerPropiedad(@Param('idPropiedad') idPropiedad: string) {
    return await this.propiedadesService.obtenerPropiedad(idPropiedad);
  }

  @Get('/tipoPropiedad/:idTipoPropiedad')
  async obtenerListaPropiedadesPorTipo(
    @Param('idTipoPropiedad') idTipoPropiedad: EnumTipoPropiedad
  ) {
    return await this.propiedadesService.obtenerListaPropiedadesPorTipo(idTipoPropiedad);
  }

  @Get('/etiquetas')
  async obtenerEnumEtiquetasPropiedad() {
    return await this.propiedadesService.obtenerEnumEtiquetasPropiedad();
  }

  @Get('/tipoPropiedad')
  async obtenerEnumTiposPropiedad() {
    return await this.propiedadesService.obtenerEnumTiposPropiedad();
  }

  @Get('/etiquetas/:idPropiedad')
  async obtenerListaEtiquetasSegunPropiedad(@Param('idPropiedad') idPropiedad: string) {
    return await this.propiedadesService.obtenerListaEtiquetasSegunPropiedad(idPropiedad);
  }

  //#endregion GET

  //#region POST
  @Post('/registrarPropiedad')
  async registrarPropiedad(@Body() body: RegistrarPropiedadDTO) {
    return await this.propiedadesService.registrarPropiedad(body);
  }
  //#endregion POST

  //#region PATCH

  @Patch('/actualizarPropiedad')
  async actualizarPropiedad(@Body() body: ActualizarPropiedadDTO) {
    return await this.propiedadesService.actualizarPropiedad(body);
  }
}
