import { Body, Controller, Delete, Get, Param, Patch, Post } from '@nestjs/common';
import { ContratosService } from './contratos.service';

@Controller('contratos')
export class ContratosController {
  constructor(private readonly contratosService: ContratosService) {}
}
