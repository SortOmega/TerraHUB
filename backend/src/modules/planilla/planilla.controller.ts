import { Body, Controller, Delete, Get, Param, Patch, Post } from '@nestjs/common';
import { PlanillaService } from './planilla.service';

@Controller('planillas')
export class PlanillaController {
  constructor(private readonly planillaService: PlanillaService) {}
}
