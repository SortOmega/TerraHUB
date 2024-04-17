import { Body, Controller, Delete, Get, Param, Patch, Post } from '@nestjs/common';
// import { CreatePropiedadesDto } from './dto/create-propiedades.dto';
// import { UpdatePropiedadesDto } from './dto/update-propiedades.dto';
import { PropiedadesService } from './propiedades.service';
import { ApiTags } from '@nestjs/swagger';

@ApiTags('Mantenimiento de Propiedades')
@Controller('propiedadess')
export class PropiedadesController {
  constructor(private readonly propiedadesService: PropiedadesService) {}

  @Get('/tipoPropiedad/:idTipoPropiedad')
  async obtenerListaPropiedadesPorTipo(@Param('idTipoPropiedad') idTipoPropiedad: TipoPropiedad) {
    return await this.propiedadesService.obtenerListaPropiedadesPorTipo(idTipoPropiedad);
  }
}
