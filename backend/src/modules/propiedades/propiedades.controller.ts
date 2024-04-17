import { Body, Controller, Delete, Get, Param, Patch, Post } from '@nestjs/common';
// import { CreatePropiedadesDto } from './dto/create-propiedades.dto';
// import { UpdatePropiedadesDto } from './dto/update-propiedades.dto';
import { PropiedadesService } from './propiedades.service';
import { ApiTags } from '@nestjs/swagger';
import { RegistrarPropiedadDTO } from './dtos/RegistrarPropiedad.dto';

@ApiTags('Mantenimiento de Propiedades')
@Controller('propiedades')
export class PropiedadesController {
  constructor(private readonly propiedadesService: PropiedadesService) {}

  //#region GET
  @Get('/tipoPropiedad/:idTipoPropiedad')
  async obtenerListaPropiedadesPorTipo(@Param('idTipoPropiedad') idTipoPropiedad: TipoPropiedad) {
    return await this.propiedadesService.obtenerListaPropiedadesPorTipo(idTipoPropiedad);
  }

  @Get('/etiquetas')
  async obtenerEnumEtiquetasPropiedad() {
    return await this.propiedadesService.obtenerEnumEtiquetasPropiedad();
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
}
