import { Body, Controller, Delete, Get, Param, Patch, Post } from '@nestjs/common';
import { ContratosService } from './contratos.service';
import { ApiTags } from '@nestjs/swagger';

@ApiTags('Mantenimiento de Contratos')
@Controller('contratos')
export class ContratosController {
  constructor(private readonly contratosService: ContratosService) {}
}
