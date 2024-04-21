import { Controller, Get } from '@nestjs/common';
import { ApiTags } from '@nestjs/swagger';
import { PlanillaService } from './planilla.service';

@ApiTags('Mantenimiento de Planilla')
@Controller('planillas')
export class PlanillaController {
  constructor(private readonly planillaService: PlanillaService) {}

  @Get('/listaEmpleados')
  async obtenerListaEmpleados() {
    return await this.planillaService.obtenerListaEmpleados();
  }
}
