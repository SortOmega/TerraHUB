import { Injectable } from '@nestjs/common';
import { DatabaseService } from 'src/shared/modules/database/database.service';

@Injectable()
export class PlanillaService {
  constructor(private dbService: DatabaseService) {}

  obtenerListaEmpleados = async () => {
    return await this.dbService.pgFunc<Empleado[]>('planilla.ft_obtener_lista_empleados', []);
  };
}
